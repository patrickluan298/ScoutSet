class RulesSectionMedia {
  const RulesSectionMedia({
    this.imageAsset,
    this.caption,
    this.alt,
  });

  factory RulesSectionMedia.fromJson(Map<String, dynamic> json) {
    return RulesSectionMedia(
      imageAsset: json['imageAsset'] as String?,
      caption: json['caption'] as String?,
      alt: json['alt'] as String?,
    );
  }

  final String? imageAsset;
  final String? caption;
  final String? alt;
}

class RulesCategory {
  const RulesCategory({
    required this.id,
    required this.title,
    required this.description,
  });

  factory RulesCategory.fromJson(Map<String, dynamic> json) {
    return RulesCategory(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  final String id;
  final String title;
  final String description;
}

class RulesSection {
  const RulesSection({
    required this.id,
    required this.officialNumber,
    required this.officialTitle,
    required this.content,
    this.media,
  });

  factory RulesSection.fromJson(Map<String, dynamic> json) {
    return RulesSection(
      id: json['id'] as String,
      officialNumber: json['officialNumber'] as String,
      officialTitle: json['officialTitle'] as String,
      content: json['content'] as String,
      media: json['media'] == null
          ? null
          : RulesSectionMedia.fromJson(json['media'] as Map<String, dynamic>),
    );
  }

  final String id;
  final String officialNumber;
  final String officialTitle;
  final String content;
  final RulesSectionMedia? media;

  String get displayOfficialNumber => officialNumber.replaceAll(',', '.');
  String get searchText =>
      '$officialNumber $displayOfficialNumber $officialTitle $content';
}

class RulesChapter {
  const RulesChapter({
    required this.id,
    required this.officialNumber,
    required this.officialTitle,
    required this.categoryId,
    required this.sections,
  });

  factory RulesChapter.fromJson(Map<String, dynamic> json) {
    return RulesChapter(
      id: json['id'] as String,
      officialNumber: json['officialNumber'] as String,
      officialTitle: json['officialTitle'] as String,
      categoryId: json['categoryId'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((item) => RulesSection.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final String id;
  final String officialNumber;
  final String officialTitle;
  final String categoryId;
  final List<RulesSection> sections;

  String get displayOfficialNumber => officialNumber.replaceAll(',', '.');

  RulesChapter copyWith({
    String? id,
    String? officialNumber,
    String? officialTitle,
    String? categoryId,
    List<RulesSection>? sections,
  }) {
    return RulesChapter(
      id: id ?? this.id,
      officialNumber: officialNumber ?? this.officialNumber,
      officialTitle: officialTitle ?? this.officialTitle,
      categoryId: categoryId ?? this.categoryId,
      sections: sections ?? this.sections,
    );
  }
}

class RulesDocument {
  const RulesDocument({
    required this.id,
    required this.officialTitle,
    required this.categoryId,
    required this.content,
  });

  factory RulesDocument.fromJson(Map<String, dynamic> json) {
    return RulesDocument(
      id: json['id'] as String,
      officialTitle: json['officialTitle'] as String,
      categoryId: json['categoryId'] as String,
      content: json['content'] as String,
    );
  }

  final String id;
  final String officialTitle;
  final String categoryId;
  final String content;

  String get searchText => '$officialTitle $content';
}

class RulesCatalog {
  const RulesCatalog({
    required this.sourceTitle,
    required this.categories,
    required this.chapters,
    required this.documents,
  });

  factory RulesCatalog.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;

    return RulesCatalog(
      sourceTitle: (source?['title'] as String?) ?? '',
      categories: (json['categories'] as List<dynamic>)
          .map((item) => RulesCategory.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      chapters: (json['chapters'] as List<dynamic>)
          .map((item) => RulesChapter.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
      documents: (json['documents'] as List<dynamic>)
          .map((item) => RulesDocument.fromJson(item as Map<String, dynamic>))
          .toList(growable: false),
    );
  }

  final String sourceTitle;
  final List<RulesCategory> categories;
  final List<RulesChapter> chapters;
  final List<RulesDocument> documents;

  RulesCategory categoryById(String id) {
    return categories.firstWhere((category) => category.id == id);
  }
}
