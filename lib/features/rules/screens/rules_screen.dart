import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/sport_mode.dart';
import '../../../services/sport_mode_service.dart';
import '../../../utils/app_spacing.dart';
import '../../../widgets/app_page_scaffold.dart';
import '../../../widgets/dashboard_profile_bottom_navigation.dart';
import '../data/rules_catalog_repository.dart';
import '../models/rules_models.dart';
import '../widgets/rules_section_panel.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({
    super.key,
    this.showScaffold = true,
    this.repository = const RulesCatalogRepository(),
    this.initialSearchTerm = '',
    this.sportMode,
  });

  final bool showScaffold;
  final RulesCatalogRepository repository;
  final String initialSearchTerm;
  final SportMode? sportMode;

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  static const List<String> _categoryOrder = [
    'fundamentals',
    'system-points',
    'game-structure',
    'rotation-positions',
    'ball-contacts',
    'net-invasions',
    'serve',
    'attack',
    'block',
    'libero',
    'penalties',
    'arbitration',
    'annexes',
  ];

  late final Future<RulesCatalog> _catalogFuture;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<String> _expandedIds = <String>{};

  String _selectedCategoryId = 'fundamentals';
  String? _selectedChapterId;
  String? _selectedDocumentId;
  String _searchTerm = '';

  static const Map<String, IconData> _categoryIcons = {
    'fundamentals': Icons.stadium_outlined,
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
    'arbitration': Icons.gavel_outlined,
    'annexes': Icons.menu_book_outlined,
  };

  static const Map<String, Set<String>> _specialCategoryChapterNumbers = {
    'rotation-positions': {'7'},
    'game-structure': {'7', '8', '15', '16', '17', '18'},
  };

  @override
  void initState() {
    super.initState();
    _catalogFuture = widget.repository.load(
      sportMode: widget.sportMode ??
          SportModeService.instance.currentMode ??
          SportMode.court,
    );
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
          return const _RulesErrorState(
            message:
                'Não foi possível carregar o catálogo local das regras oficiais.',
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
      backgroundColor: AppTheme.colorsOf(context).surface,
      bottomNavigationBar: widget.showScaffold
          ? const DashboardProfileBottomNavigation(
              currentRoute: AppRoutes.rules,
            )
          : null,
      child: content,
    );
  }

  Widget _buildCatalogView(BuildContext context, RulesCatalog catalog) {
    final isEmptyCatalog = _isEmptyCatalog(catalog);
    final display = _buildCurrentDisplay(catalog);
    final isShowingSelectedChapter =
        _searchTerm.trim().isEmpty && _selectedChapterId != null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final showSidebar = constraints.maxWidth >= 1120;

        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.colorsOf(context).surface,
                AppTheme.colorsOf(context).surfaceContainerLow,
              ],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showSidebar)
                SizedBox(
                  width: 288,
                  height: constraints.maxHeight,
                  child: _buildSideNav(catalog),
                ),
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: EdgeInsets.fromLTRB(
                    showSidebar ? 28 : 20,
                    showSidebar ? 18 : 12,
                    showSidebar ? 28 : 20,
                    showSidebar ? 40 : 104,
                  ),
                  children: [
                    if (showSidebar) _buildDesktopTopNav(),
                    _buildHeroHeader(
                      context,
                      catalog,
                      showSidebar,
                      isEmptyCatalog: isEmptyCatalog,
                    ),
                    if (!showSidebar) ...[
                      const SizedBox(height: 16),
                      _buildControlsPanel(context, catalog),
                    ],
                    const SizedBox(height: 24),
                    _buildChapterHeading(context, catalog, display),
                    const SizedBox(height: 18),
                    if (isEmptyCatalog) ...[
                      _buildEmptyCatalogCard(context),
                      const SizedBox(height: 20),
                    ],
                    for (final chapter in display.chapters) ...[
                      _buildChapterBlock(
                        context,
                        chapter,
                        showChapterTitle: !isShowingSelectedChapter,
                      ),
                      const SizedBox(height: 22),
                    ],
                    if (display.documents.isNotEmpty) ...[
                      _buildDocumentsBlock(context, display.documents),
                      const SizedBox(height: 20),
                    ],
                    _buildWatermarkFooter(context, display),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopTopNav() {
    final colors = AppTheme.colorsOf(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                colors.primaryDetail.withValues(alpha: 0.09),
                Colors.transparent,
              ],
            ),
          ),
          child: Wrap(
            spacing: 28,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _TopNavLink(
                label: 'Regras',
                isActive: true,
                style: theme.textTheme.titleMedium!,
              ),
              _TopNavLink(
                label: 'Casos',
                isActive: false,
                style: theme.textTheme.titleMedium!,
              ),
              _TopNavLink(
                label: 'Diretrizes',
                isActive: false,
                style: theme.textTheme.titleMedium!,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroHeader(
      BuildContext context, RulesCatalog catalog, bool showSidebar,
      {required bool isEmptyCatalog}) {
    final colors = AppTheme.colorsOf(context);
    final theme = Theme.of(context);
    final sportMode = _effectiveSportMode;

    return Container(
      padding: EdgeInsets.fromLTRB(
        showSidebar ? 28 : 22,
        24,
        showSidebar ? 28 : 22,
        28,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.surface,
            colors.surfaceContainerLow,
          ],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                    height: 1, color: colors.accent.withValues(alpha: 0.35)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Manual Técnico',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.accent,
                    fontSize: showSidebar ? 14 : 12,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    height: 1, color: colors.accent.withValues(alpha: 0.35)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            isEmptyCatalog
                ? 'Regras de ${sportMode.shortLabel}'
                : 'Regras Oficiais',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: colors.onSurface,
              fontSize: showSidebar ? 40 : 34,
              height: 1.02,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            isEmptyCatalog
                ? 'Estrutura pronta para receber o conteúdo oficial da modalidade.'
                : 'Aprovado no 39º Congresso Mundial da FIVB de 2024.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.primaryDetail.withValues(alpha: 0.9),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 18),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _HeroMetaChip(
                  label: isEmptyCatalog
                      ? 'Edição em preparação'
                      : 'Edição ${catalog.sourceTitle}',
                  icon: Icons.verified_outlined,
                ),
                const SizedBox(width: 12),
                _HeroMetaChip(
                  label: isEmptyCatalog
                      ? 'Layout compartilhado'
                      : '${catalog.chapters.length} capítulos oficiais',
                  icon: Icons.menu_book_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlsPanel(BuildContext context, RulesCatalog catalog) {
    return _PressableCard(
      key: const Key('rules-open-sidebar'),
      onTap: () => _openSidebarSheet(catalog),
      child: Row(
        children: [
          _LeadingIconBox(icon: Icons.menu_book_outlined),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Navegação do Documento',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        letterSpacing: 1.2,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Índice de Regras',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: AppTheme.colorsOf(context).accent,
          ),
        ],
      ),
    );
  }

  Widget _buildChapterHeading(
    BuildContext context,
    RulesCatalog catalog,
    _VisibleContent display,
  ) {
    final colors = AppTheme.colorsOf(context);
    final selectedChapter =
        display.chapters.isEmpty ? null : display.chapters.first;
    final isShowingSelectedChapter =
        _searchTerm.trim().isEmpty && _selectedChapterId != null;
    final title = _isEmptyCatalog(catalog)
        ? 'Conteúdo em preparação'
        : _searchTerm.trim().isNotEmpty
            ? 'Resultados da busca'
            : isShowingSelectedChapter && selectedChapter != null
                ? 'Capítulo ${selectedChapter.displayOfficialNumber}: '
                    '${selectedChapter.officialTitle}'
                : _titleForCategory(catalog, _selectedCategoryId);

    final badge = _isEmptyCatalog(catalog)
        ? 'Em preparação'
        : _searchTerm.trim().isNotEmpty
            ? '${display.chapters.length + display.documents.length} itens'
            : _selectedChapterId != null
                ? 'Leitura técnica'
                : 'Índice oficial';

    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: colors.onSurface,
                ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colors.surfaceContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            badge.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  letterSpacing: 1.1,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildChapterBlock(
    BuildContext context,
    _VisibleChapter chapter, {
    bool showChapterTitle = true,
  }) {
    final colors = AppTheme.colorsOf(context);
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showChapterTitle) ...[
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Capítulo ${chapter.displayOfficialNumber}: ${chapter.officialTitle}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 24,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
              ],
              for (var index = 0; index < chapter.sections.length; index++) ...[
                RulesSectionPanel(
                  key: ValueKey<String>(chapter.sections[index].id),
                  label: chapter.sections[index].displayOfficialNumber,
                  title: chapter.sections[index].officialTitle,
                  content: chapter.sections[index].content,
                  expanded: _expandedIds.contains(chapter.sections[index].id),
                  media: chapter.sections[index].media,
                  onChanged: (expanded) =>
                      _handleExpansion(chapter.sections[index].id, expanded),
                ),
                if (index != chapter.sections.length - 1)
                  const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        const SizedBox(height: 18),
        _buildChapterWatermark(context, chapter),
      ],
    );
  }

  Widget _buildDocumentsBlock(
    BuildContext context,
    List<RulesDocument> documents,
  ) {
    final colors = AppTheme.colorsOf(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documentos oficiais',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          for (var index = 0; index < documents.length; index++) ...[
            RulesSectionPanel(
              key: ValueKey<String>(documents[index].id),
              title: documents[index].officialTitle,
              content: documents[index].content,
              expanded: _expandedIds.contains(documents[index].id),
              onChanged: (expanded) =>
                  _handleExpansion(documents[index].id, expanded),
            ),
            if (index != documents.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyCatalogCard(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Conteúdo em preparação',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            'O layout do módulo já está pronto para o vôlei de praia, mas o conteúdo normativo será preenchido em uma próxima etapa.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildChapterWatermark(BuildContext context, _VisibleChapter chapter) {
    final colors = AppTheme.colorsOf(context);
    return SizedBox(
      height: 112,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: Text(
                'FIVB',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 110,
                      fontWeight: FontWeight.w900,
                      color: colors.onSurface,
                    ),
              ),
            ),
          ),
          Text(
            'Fim do Capítulo ${chapter.displayOfficialNumber}',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colors.onSurfaceVariant,
                  letterSpacing: 3,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildWatermarkFooter(BuildContext context, _VisibleContent display) {
    if (display.chapters.isNotEmpty) {
      return const SizedBox.shrink();
    }

    final colors = AppTheme.colorsOf(context);
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          IgnorePointer(
            child: Opacity(
              opacity: 0.05,
              child: Text(
                'FIVB',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 110,
                      fontWeight: FontWeight.w900,
                      color: colors.onSurface,
                    ),
              ),
            ),
          ),
          Text(
            'Fim da seção',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  letterSpacing: 3,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideNav(RulesCatalog catalog) {
    final colors = AppTheme.colorsOf(context);
    final menuGroups = _buildVisibleMenuGroups(catalog);

    return Material(
      color: colors.surface.withValues(alpha: 0.88),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            right:
                BorderSide(color: colors.subtleBorder.withValues(alpha: 0.5)),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ScoutSet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: colors.accent,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      _LeadingIconBox(icon: Icons.sports_volleyball),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Índice de Regras',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Edição ${catalog.sourceTitle}',
                              style: Theme.of(context).textTheme.labelSmall,
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
                    hintText: 'Buscar por numeração, regra ou seção',
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
                Expanded(
                  child: menuGroups.isEmpty
                      ? Center(
                          child: Text(
                            'Nenhum item do índice corresponde à busca.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView(
                          children: [
                            for (final group in menuGroups) ...[
                              _SideNavGroup(
                                key: Key('rules-menu-category-${group.id}'),
                                title: group.title,
                                icon:
                                    _categoryIcons[group.id] ?? Icons.menu_book,
                                isSelected: _selectedCategoryId == group.id &&
                                    _selectedChapterId == null &&
                                    _selectedDocumentId == null,
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryId = group.id;
                                    _selectedChapterId = null;
                                    _selectedDocumentId = null;
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              for (final item in group.items) ...[
                                _SideNavItem(
                                  key: Key('rules-menu-item-${item.id}'),
                                  title: item.label,
                                  icon:
                                      item.kind == _SidebarMenuItemKind.chapter
                                          ? Icons.chevron_right
                                          : Icons.description_outlined,
                                  isSelected: (_selectedChapterId == item.id) ||
                                      (_selectedDocumentId == item.id),
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryId = group.id;
                                      if (item.kind ==
                                          _SidebarMenuItemKind.chapter) {
                                        _selectedChapterId = item.id;
                                        _selectedDocumentId = null;
                                      } else {
                                        _selectedDocumentId = item.id;
                                        _selectedChapterId = null;
                                      }
                                    });
                                  },
                                ),
                                const SizedBox(height: 8),
                              ],
                              const SizedBox(height: 6),
                            ],
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openSidebarSheet(RulesCatalog catalog) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.colorsOf(context).surface,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final colors = AppTheme.colorsOf(context);
            final menuGroups = _buildVisibleMenuGroups(catalog);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Índice de Regras',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Navegação do Documento',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: colors.onSurfaceVariant,
                            letterSpacing: 1.4,
                          ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      key: const Key('rules-search-field-mobile'),
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _searchTerm = value);
                        setSheetState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: 'Buscar regra',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchTerm.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() => _searchTerm = '');
                                  setSheetState(() {});
                                },
                                icon: const Icon(Icons.close),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final group in menuGroups) ...[
                            _SideNavGroup(
                              key: Key('rules-menu-category-${group.id}'),
                              title: group.title,
                              icon: _categoryIcons[group.id] ?? Icons.menu_book,
                              isSelected: _selectedCategoryId == group.id &&
                                  _selectedChapterId == null &&
                                  _selectedDocumentId == null,
                              onTap: () {
                                setState(() {
                                  _selectedCategoryId = group.id;
                                  _selectedChapterId = null;
                                  _selectedDocumentId = null;
                                });
                                Navigator.of(context).pop();
                              },
                            ),
                            const SizedBox(height: 8),
                            for (final item in group.items) ...[
                              _SideNavItem(
                                key: Key('rules-menu-item-${item.id}'),
                                title: item.label,
                                icon: item.kind == _SidebarMenuItemKind.chapter
                                    ? Icons.chevron_right
                                    : Icons.description_outlined,
                                isSelected: (_selectedChapterId == item.id) ||
                                    (_selectedDocumentId == item.id),
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryId = group.id;
                                    if (item.kind ==
                                        _SidebarMenuItemKind.chapter) {
                                      _selectedChapterId = item.id;
                                      _selectedDocumentId = null;
                                    } else {
                                      _selectedDocumentId = item.id;
                                      _selectedChapterId = null;
                                    }
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              const SizedBox(height: 8),
                            ],
                            const SizedBox(height: 6),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<_SidebarMenuGroupData> _buildMenuGroups(RulesCatalog catalog) {
    final groupsById = <String, _SidebarMenuGroupData>{};

    for (final category in catalog.categories) {
      final items = <_SidebarMenuItemData>[];

      for (final chapter in _chaptersForCategory(catalog, category.id)) {
        items.add(
          _SidebarMenuItemData(
            id: chapter.id,
            label: '${chapter.displayOfficialNumber} ${chapter.officialTitle}',
            kind: _SidebarMenuItemKind.chapter,
          ),
        );
      }

      if (category.id == 'annexes') {
        for (final document in catalog.documents
            .where((item) => item.categoryId == category.id)) {
          items.add(
            _SidebarMenuItemData(
              id: document.id,
              label: document.officialTitle,
              kind: _SidebarMenuItemKind.document,
            ),
          );
        }
      }

      groupsById[category.id] = _SidebarMenuGroupData(
        id: category.id,
        title: category.title,
        items: items,
      );
    }

    final orderedGroups = <_SidebarMenuGroupData>[];
    for (final categoryId in _categoryOrder) {
      final group = groupsById.remove(categoryId);
      if (group != null) {
        orderedGroups.add(group);
      }
    }

    orderedGroups.addAll(groupsById.values);
    return orderedGroups;
  }

  List<_SidebarMenuGroupData> _buildVisibleMenuGroups(RulesCatalog catalog) {
    final menuGroups = _buildMenuGroups(catalog);
    final normalizedQuery = _normalizeForSearch(_searchTerm.trim());
    if (normalizedQuery.isEmpty) {
      return menuGroups;
    }

    final visibleGroups = <_SidebarMenuGroupData>[];
    for (final group in menuGroups) {
      final groupMatches =
          _normalizeForSearch(group.title).contains(normalizedQuery);
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

  _VisibleContent _buildCurrentDisplay(RulesCatalog catalog) {
    if (_isEmptyCatalog(catalog)) {
      return const _VisibleContent(chapters: [], documents: []);
    }

    if (_searchTerm.trim().isNotEmpty) {
      return _buildSearchDisplay(catalog, _searchTerm);
    }

    if (_selectedChapterId == null) {
      if (_selectedDocumentId == null) {
        return _buildCategoryDisplay(catalog, _selectedCategoryId);
      }

      final document = catalog.documents
          .firstWhere((item) => item.id == _selectedDocumentId);
      return _VisibleContent.from(
        chapters: const [],
        documents: [document],
      );
    }

    final chapter =
        catalog.chapters.firstWhere((item) => item.id == _selectedChapterId);
    return _VisibleContent.from(
      chapters: [
        _VisibleChapter(
          id: chapter.id,
          officialNumber: chapter.displayOfficialNumber,
          officialTitle: chapter.officialTitle,
          sections: chapter.sections,
        ),
      ],
      documents: const [],
    );
  }

  _VisibleContent _buildCategoryDisplay(
      RulesCatalog catalog, String categoryId) {
    final chapters = <_VisibleChapter>[];
    final documents = <RulesDocument>[];
    chapters.addAll(
      _chaptersForCategory(catalog, categoryId)
          .map((chapter) => _visibleChapterForCategory(categoryId, chapter)),
    );

    if (categoryId == 'annexes') {
      documents.addAll(catalog.documents
          .where((document) => document.categoryId == categoryId));
    }

    return _VisibleContent.from(chapters: chapters, documents: documents);
  }

  _VisibleContent _buildSearchDisplay(RulesCatalog catalog, String query) {
    final normalizedQuery = _normalizeForSearch(query);
    final matchedChapters = <_VisibleChapter>[];
    final matchedDocuments = <RulesDocument>[];

    for (final chapter in catalog.chapters) {
      final matchedSections = chapter.sections.where((section) {
        return _normalizeForSearch(
          '${chapter.displayOfficialNumber} ${chapter.officialTitle} ${section.searchText}',
        ).contains(normalizedQuery);
      }).toList(growable: false);

      if (matchedSections.isNotEmpty) {
        matchedChapters.add(
          _VisibleChapter(
            id: chapter.id,
            officialNumber: chapter.displayOfficialNumber,
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

  bool _isEmptyCatalog(RulesCatalog catalog) {
    return catalog.categories.isEmpty &&
        catalog.chapters.isEmpty &&
        catalog.documents.isEmpty;
  }

  SportMode get _effectiveSportMode =>
      widget.sportMode ??
      SportModeService.instance.currentMode ??
      SportMode.court;

  String _titleForCategory(RulesCatalog catalog, String categoryId) {
    return catalog.categoryById(categoryId).title;
  }

  List<RulesChapter> _chaptersForCategory(
      RulesCatalog catalog, String categoryId) {
    final specialNumbers = _specialCategoryChapterNumbers[categoryId];
    if (specialNumbers == null) {
      return catalog.chapters
          .where((chapter) => chapter.categoryId == categoryId)
          .toList(growable: false);
    }

    return catalog.chapters
        .where((chapter) => specialNumbers.contains(chapter.officialNumber))
        .toList(growable: false);
  }

  _VisibleChapter _visibleChapterForCategory(
    String categoryId,
    RulesChapter chapter,
  ) {
    final sections = switch ((categoryId, chapter.officialNumber)) {
      ('rotation-positions', '7') => chapter.sections.where((section) {
          return const {'7.4', '7.5', '7.6', '7.7'}
              .contains(section.officialNumber);
        }).toList(growable: false),
      ('game-structure', '7') => chapter.sections.where((section) {
          return const {'7.1', '7.2', '7.3'}.contains(section.officialNumber);
        }).toList(growable: false),
      _ => chapter.sections,
    };

    return _VisibleChapter(
      id: chapter.id,
      officialNumber: chapter.displayOfficialNumber,
      officialTitle: chapter.officialTitle,
      sections: sections,
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

  String get displayOfficialNumber => officialNumber.replaceAll(',', '.');
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

class _TopNavLink extends StatelessWidget {
  const _TopNavLink({
    required this.label,
    required this.isActive,
    required this.style,
  });

  final String label;
  final bool isActive;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return Text(
      label,
      style: style.copyWith(
        color: isActive ? colors.accent : colors.onSurfaceVariant,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _HeroMetaChip extends StatelessWidget {
  const _HeroMetaChip({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colors.accent),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: colors.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeadingIconBox extends StatelessWidget {
  const _LeadingIconBox({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, color: colors.accent),
    );
  }
}

class _PressableCard extends StatefulWidget {
  const _PressableCard({
    required this.child,
    required this.onTap,
    super.key,
  });

  final Widget child;
  final VoidCallback onTap;

  @override
  State<_PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<_PressableCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.01 : 1,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: _hovered
                    ? colors.surfaceContainer
                    : colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

class _SideNavGroup extends StatelessWidget {
  const _SideNavGroup({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primaryDetail.withValues(alpha: 0.16)
                : colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              right: BorderSide(
                color: isSelected ? colors.accent : Colors.transparent,
                width: 4,
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isSelected ? colors.accent : colors.onSurfaceVariant),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: isSelected ? colors.accent : colors.onSurface,
                        letterSpacing: 0.6,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SideNavItem extends StatelessWidget {
  const _SideNavItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.colorsOf(context);
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.surfaceContainer
                  : colors.surfaceContainerLow.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? colors.accent : colors.onSurfaceVariant,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isSelected
                              ? colors.onSurface
                              : colors.onSurfaceVariant,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
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

class _RulesErrorState extends StatelessWidget {
  const _RulesErrorState({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.screen,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.colorsOf(context).surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
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
