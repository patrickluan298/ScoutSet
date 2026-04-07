import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_page_scaffold.dart';
import '../data/rules_catalog_repository.dart';
import '../models/rules_models.dart';
import '../widgets/rules_section_panel.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({
    super.key,
    this.showScaffold = true,
    this.repository = const RulesCatalogRepository(),
    this.initialSearchTerm = '',
  });

  final bool showScaffold;
  final RulesCatalogRepository repository;
  final String initialSearchTerm;

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  late final Future<RulesCatalog> _catalogFuture;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<String> _expandedIds = <String>{};

  String _selectedCategoryId = 'system-points';
  String? _selectedChapterId;
  String? _selectedDocumentId;
  String _searchTerm = '';

  static const Map<String, IconData> _categoryIcons = {
    'system-points': Icons.scoreboard_outlined,
    'game-structure': Icons.account_tree_outlined,
    'rotation-positions': Icons.sync_outlined,
    'ball-contacts': Icons.sports_volleyball_outlined,
    'net-invasions': Icons.vertical_align_center_outlined,
    'attack': Icons.flash_on_outlined,
    'block': Icons.shield_outlined,
    'serve': Icons.sports_handball_outlined,
    'libero': Icons.person_outline,
    'penalties': Icons.gavel_outlined,
    'supplemental': Icons.menu_book_outlined,
  };

  @override
  void initState() {
    super.initState();
    _catalogFuture = widget.repository.load();
    _searchTerm = widget.initialSearchTerm;
    if (_searchTerm.isNotEmpty) {
      _searchController.text = _searchTerm;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = FutureBuilder<RulesCatalog>(
      future: _catalogFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return _RulesErrorState(
            message: 'Não foi possível carregar o catálogo local das regras oficiais.',
          );
        }

        return SelectionArea(
          child: _buildCatalogView(context, snapshot.data!),
        );
      },
    );

    return AppPageScaffold(
      showScaffold: widget.showScaffold,
      currentRoute: AppRoutes.rules,
      child: content,
    );
  }

  Widget _buildCatalogView(BuildContext context, RulesCatalog catalog) {
    final display = _buildCurrentDisplay(catalog);

    return LayoutBuilder(
      builder: (context, constraints) {
        final showSidebar = constraints.maxWidth >= 900;

        return Padding(
          padding: AppSpacing.screen,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showSidebar) ...[
                SizedBox(
                  width: 280,
                  height: constraints.maxHeight,
                  child: _buildSidebar(catalog, scrollableWithinCard: true),
                ),
                const SizedBox(width: 20),
              ],
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [
                    _buildHeroHeader(context, catalog, showSidebar),
                    if (!showSidebar) ...[
                      const SizedBox(height: 16),
                      _buildControlsPanel(context, catalog),
                      AppSpacing.gapMedium,
                    ] else
                      const SizedBox(height: 18),
                    if (display.chapters.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Container(
                              width: 34,
                              height: 2,
                              color: AppTheme.accentColor,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              _searchTerm.trim().isNotEmpty
                                  ? 'LEITURA FILTRADA'
                                  : 'CAPÍTULOS OFICIAIS',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.mediumGrayColor,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    if (display.chapters.isNotEmpty) const SizedBox(height: 14),
                    for (final chapter in display.chapters) ...[
                      _buildChapterBlock(chapter),
                      AppSpacing.gapMedium,
                    ],
                    if (display.documents.isNotEmpty)
                      AppCard(
                        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DOCUMENTOS OFICIAIS',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.mediumGrayColor,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            for (final document in display.documents) ...[
                              RulesSectionPanel(
                                key: ValueKey<String>(document.id),
                                title: document.officialTitle,
                                content: document.content,
                                expanded: _expandedIds.contains(document.id),
                                onChanged: (expanded) => _handleExpansion(document.id, expanded),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebar(
    RulesCatalog catalog, {
    required bool scrollableWithinCard,
    VoidCallback? onCategorySelected,
    VoidCallback? onItemSelected,
  }) {
    final menuGroups = _buildVisibleMenuGroups(catalog);
    final body = Column(
      children: [
        if (menuGroups.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              'Nenhum item do sumário corresponde à busca.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else
          for (final group in menuGroups) ...[
            _SidebarGroup(
              key: Key('rules-menu-category-${group.id}'),
              title: group.title,
              icon: _categoryIcons[group.id] ?? Icons.menu_book_outlined,
              isSelected:
                  _selectedCategoryId == group.id &&
                  _selectedChapterId == null &&
                  _selectedDocumentId == null,
              onTap: () {
                setState(() {
                  _selectedCategoryId = group.id;
                  _selectedChapterId = null;
                  _selectedDocumentId = null;
                });
                onCategorySelected?.call();
              },
              children: [
                for (final item in group.items)
                  _SidebarItem(
                    key: Key('rules-menu-item-${item.id}'),
                    title: item.label,
                    isSelected:
                        (_selectedChapterId != null && _selectedChapterId == item.id) ||
                        (_selectedDocumentId != null && _selectedDocumentId == item.id),
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = group.id;
                        if (item.kind == _SidebarMenuItemKind.chapter) {
                          _selectedChapterId = item.id;
                          _selectedDocumentId = null;
                        } else {
                          _selectedDocumentId = item.id;
                          _selectedChapterId = null;
                        }
                      });
                      onItemSelected?.call();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 10),
          ],
      ],
    );

    return AppCard(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu_book_outlined,
                    color: AppTheme.accentColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ÍNDICE OFICIAL',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.1,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Sumário lateral',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.whiteColor,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            key: const Key('rules-search-field'),
            controller: _searchController,
            onChanged: (value) => setState(() => _searchTerm = value),
            decoration: InputDecoration(
              hintText: 'Buscar por texto oficial, numeração ou seção',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchTerm.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchTerm = '');
                      },
                      icon: const Icon(Icons.close),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'CONTEÚDO',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
              color: AppTheme.mediumGrayColor,
            ),
          ),
          const SizedBox(height: 16),
          if (scrollableWithinCard)
            Expanded(child: SingleChildScrollView(child: body))
          else
            body,
        ],
      ),
    );
  }

  List<_SidebarMenuGroupData> _buildMenuGroups(RulesCatalog catalog) {
    return catalog.categories.map((category) {
      final items = <_SidebarMenuItemData>[];

      if (category.id == 'rotation-positions') {
        final chapter = catalog.chapters.firstWhere((item) => item.officialNumber == '7');
        items.add(
          _SidebarMenuItemData(
            id: chapter.id,
            label: '${chapter.officialNumber} ${chapter.officialTitle}',
            kind: _SidebarMenuItemKind.chapter,
          ),
        );
      } else if (category.id == 'game-structure') {
        for (final chapter in catalog.chapters.where(
          (item) => item.officialNumber == '7' || item.officialNumber == '8',
        )) {
          items.add(
            _SidebarMenuItemData(
              id: chapter.id,
              label: '${chapter.officialNumber} ${chapter.officialTitle}',
              kind: _SidebarMenuItemKind.chapter,
            ),
          );
        }
      } else {
        for (final chapter in catalog.chapters.where((item) => item.categoryId == category.id)) {
          items.add(
            _SidebarMenuItemData(
              id: chapter.id,
              label: '${chapter.officialNumber} ${chapter.officialTitle}',
              kind: _SidebarMenuItemKind.chapter,
            ),
          );
        }
      }

      if (category.id == 'supplemental') {
        for (final document in catalog.documents.where((item) => item.categoryId == category.id)) {
          items.insert(
            items.length.clamp(0, items.length),
            _SidebarMenuItemData(
              id: document.id,
              label: document.officialTitle,
              kind: _SidebarMenuItemKind.document,
            ),
          );
        }
      }

      return _SidebarMenuGroupData(
        id: category.id,
        title: category.title,
        items: items,
      );
    }).toList(growable: false);
  }

  List<_SidebarMenuGroupData> _buildVisibleMenuGroups(RulesCatalog catalog) {
    final menuGroups = _buildMenuGroups(catalog);
    final normalizedQuery = _normalizeForSearch(_searchTerm.trim());
    if (normalizedQuery.isEmpty) {
      return menuGroups;
    }

    final visibleGroups = <_SidebarMenuGroupData>[];
    for (final group in menuGroups) {
      final groupMatches = _normalizeForSearch(group.title).contains(normalizedQuery);
      final matchingItems = group.items.where((item) {
        return _normalizeForSearch(item.label).contains(normalizedQuery);
      }).toList(growable: false);

      if (!groupMatches && matchingItems.isEmpty) {
        continue;
      }

      visibleGroups.add(
        _SidebarMenuGroupData(
          id: group.id,
          title: group.title,
          items: groupMatches ? group.items : matchingItems,
        ),
      );
    }

    return visibleGroups;
  }

  Future<void> _openSidebarSheet(RulesCatalog catalog) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: _buildSidebar(
              catalog,
              scrollableWithinCard: false,
              onCategorySelected: () => Navigator.of(context).pop(),
              onItemSelected: () => Navigator.of(context).pop(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChapterBlock(_VisibleChapter chapter) {
    final theme = Theme.of(context);

    return AppCard(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor,
                  AppTheme.secondaryBlueColor,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    chapter.officialNumber,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.whiteColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    chapter.officialTitle,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          for (final section in chapter.sections) ...[
            RulesSectionPanel(
              key: ValueKey<String>(section.id),
              label: section.officialNumber,
              title: section.officialTitle,
              subtitle: chapter.officialTitle,
              content: section.content,
              expanded: _expandedIds.contains(section.id),
              onChanged: (expanded) => _handleExpansion(section.id, expanded),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  _VisibleContent _buildCategoryDisplay(RulesCatalog catalog, String categoryId) {
    final chapters = <_VisibleChapter>[];
    final documents = <RulesDocument>[];
    final supplementalChapters = catalog.chapters.where((chapter) => chapter.categoryId == categoryId);

    if (categoryId == 'rotation-positions') {
      final chapter = catalog.chapters.firstWhere((item) => item.officialNumber == '7');
      chapters.add(
        _VisibleChapter(
          id: chapter.id,
          officialNumber: chapter.officialNumber,
          officialTitle: chapter.officialTitle,
          sections: chapter.sections.where((section) {
            return const {'7.4', '7,5', '7.6', '7,7'}.contains(section.officialNumber);
          }).toList(growable: false),
        ),
      );
    } else if (categoryId == 'game-structure') {
      final chapter7 = catalog.chapters.firstWhere((item) => item.officialNumber == '7');
      final chapter8 = catalog.chapters.firstWhere((item) => item.officialNumber == '8');
      chapters.add(
        _VisibleChapter(
          id: chapter7.id,
          officialNumber: chapter7.officialNumber,
          officialTitle: chapter7.officialTitle,
          sections: chapter7.sections.where((section) {
            return const {'7.1', '7.2', '7.3'}.contains(section.officialNumber);
          }).toList(growable: false),
        ),
      );
      chapters.add(
        _VisibleChapter(
          id: chapter8.id,
          officialNumber: chapter8.officialNumber,
          officialTitle: chapter8.officialTitle,
          sections: chapter8.sections,
        ),
      );
    } else {
      chapters.addAll(
        supplementalChapters.map(
          (chapter) => _VisibleChapter(
            id: chapter.id,
            officialNumber: chapter.officialNumber,
            officialTitle: chapter.officialTitle,
            sections: chapter.sections,
          ),
        ),
      );
    }

    if (categoryId == 'supplemental') {
      documents.addAll(catalog.documents.where((document) => document.categoryId == categoryId));
    }

    return _VisibleContent.from(chapters: chapters, documents: documents);
  }

  _VisibleContent _buildCurrentDisplay(RulesCatalog catalog) {
    if (_searchTerm.trim().isNotEmpty) {
      return _buildSearchDisplay(catalog, _searchTerm);
    }

    if (_selectedChapterId == null) {
      if (_selectedDocumentId == null) {
        return _buildCategoryDisplay(catalog, _selectedCategoryId);
      }

      final document = catalog.documents.firstWhere((item) => item.id == _selectedDocumentId);
      return _VisibleContent.from(
        chapters: const [],
        documents: [document],
      );
    }

    final chapter = catalog.chapters.firstWhere((item) => item.id == _selectedChapterId);
    return _VisibleContent.from(
      chapters: [
        _VisibleChapter(
          id: chapter.id,
          officialNumber: chapter.officialNumber,
          officialTitle: chapter.officialTitle,
          sections: chapter.sections,
        ),
      ],
      documents: const [],
    );
  }

  _VisibleContent _buildSearchDisplay(RulesCatalog catalog, String query) {
    final normalizedQuery = _normalizeForSearch(query);
    final matchedChapters = <_VisibleChapter>[];
    final matchedDocuments = <RulesDocument>[];

    for (final chapter in catalog.chapters) {
      final matchedSections = chapter.sections.where((section) {
        return _normalizeForSearch(
          '${chapter.officialNumber} ${chapter.officialTitle} ${section.searchText}',
        ).contains(normalizedQuery);
      }).toList(growable: false);

      if (matchedSections.isNotEmpty) {
        matchedChapters.add(
          _VisibleChapter(
            id: chapter.id,
            officialNumber: chapter.officialNumber,
            officialTitle: chapter.officialTitle,
            sections: matchedSections,
          ),
        );
      }
    }

    for (final document in catalog.documents) {
      if (_normalizeForSearch(document.searchText).contains(normalizedQuery)) {
        matchedDocuments.add(document);
      }
    }

    return _VisibleContent.from(
      chapters: matchedChapters,
      documents: matchedDocuments,
    );
  }

  void _handleExpansion(String id, bool expanded) {
    setState(() {
      if (expanded) {
        _expandedIds.add(id);
      } else {
        _expandedIds.remove(id);
      }
    });
  }

  String _normalizeForSearch(String value) {
    return removeDiacritics(value).toLowerCase();
  }

  Widget _buildHeroHeader(
    BuildContext context,
    RulesCatalog catalog,
    bool showSidebar,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor,
            AppTheme.secondaryBlueColor,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Row(
                children: [
                  Container(
                    width: 34,
                    height: 2,
                    color: AppTheme.accentColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'MANUAL TÉCNICO',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Regras Oficiais',
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppTheme.whiteColor,
                  fontSize: 34,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  'Aprovado no 39º Congresso Mundial da FIVB de 2024.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.whiteColor.withValues(alpha: 0.88),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _HeroStatChip(
                    label: catalog.sourceTitle,
                    icon: Icons.verified_outlined,
                  ),
                  _HeroStatChip(
                    label: '${catalog.chapters.length} capítulos',
                    icon: Icons.view_agenda_outlined,
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildControlsPanel(BuildContext context, RulesCatalog catalog) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppTheme.secondaryBlueColor.withValues(alpha: 0.16),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: const Key('rules-open-sidebar'),
          onTap: () => _openSidebarSheet(catalog),
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryBlueColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu_open,
                    size: 20,
                    color: AppTheme.secondaryBlueColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Abrir sumário lateral',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class _VisibleContent {
  const _VisibleContent({
    required this.chapters,
    required this.documents,
  });

  factory _VisibleContent.from({
    required List<_VisibleChapter> chapters,
    required List<RulesDocument> documents,
  }) {
    return _VisibleContent(
      chapters: chapters,
      documents: documents,
    );
  }

  final List<_VisibleChapter> chapters;
  final List<RulesDocument> documents;
}

class _VisibleChapter {
  const _VisibleChapter({
    required this.id,
    required this.officialNumber,
    required this.officialTitle,
    required this.sections,
  });

  final String id;
  final String officialNumber;
  final String officialTitle;
  final List<RulesSection> sections;
}

class _SidebarMenuGroupData {
  const _SidebarMenuGroupData({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<_SidebarMenuItemData> items;
}

class _SidebarMenuItemData {
  const _SidebarMenuItemData({
    required this.id,
    required this.label,
    required this.kind,
  });

  final String id;
  final String label;
  final _SidebarMenuItemKind kind;
}

enum _SidebarMenuItemKind {
  chapter,
  document,
}

class _SidebarGroup extends StatelessWidget {
  const _SidebarGroup({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.children,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withValues(alpha: 0.03) : AppTheme.lightGrayColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppTheme.accentColor : const Color(0xFFD9E2EC),
          width: isSelected ? 1.4 : 1,
        ),
      ),
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.accentColor.withValues(alpha: 0.18)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: AppTheme.primaryColor, size: 18),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (children.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: Column(children: children),
            ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
        onPressed: onTap,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          foregroundColor: isSelected ? AppTheme.primaryColor : AppTheme.textColor,
          backgroundColor: isSelected
              ? AppTheme.accentColor.withValues(alpha: 0.18)
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          isSelected ? Icons.arrow_right_alt : Icons.subdirectory_arrow_right,
          size: 18,
        ),
        label: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

class _HeroStatChip extends StatelessWidget {
  const _HeroStatChip({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.accentColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.whiteColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RulesErrorState extends StatelessWidget {
  const _RulesErrorState({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screen,
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Regras', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(message, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
