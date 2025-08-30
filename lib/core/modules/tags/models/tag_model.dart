import '../../../theme/app_theme.dart';

class TagModel {
  final String id;
  final String name;
  final TagColor color;
  final DateTime createdAt;

  TagModel({
    required this.id,
    required this.name,
    required this.color,
    required this.createdAt,
  });

  TagModel copyWith({
    String? id,
    String? name,
    TagColor? color,
    DateTime? createdAt,
  }) {
    return TagModel(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color.index,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json['id'],
      name: json['name'],
      color: TagColor.values[json['color']],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

// Mock data service for tags
class TagService {
  static List<TagModel> _tags = [
    TagModel(
      id: '1',
      name: 'Health',
      color: TagColor.green,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
    ),
    TagModel(
      id: '2',
      name: 'Work',
      color: TagColor.blue,
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
    ),
    TagModel(
      id: '3',
      name: 'Family',
      color: TagColor.pink,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    TagModel(
      id: '4',
      name: 'Ideas',
      color: TagColor.purple,
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
    ),
    TagModel(
      id: '5',
      name: 'Travel',
      color: TagColor.yellow,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  static List<TagModel> getAllTags() {
    return List.from(_tags);
  }

  static TagModel? getTagById(String id) {
    try {
      return _tags.firstWhere((tag) => tag.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<TagModel> getTagsByIds(List<String> ids) {
    return _tags.where((tag) => ids.contains(tag.id)).toList();
  }

  static void addTag(TagModel tag) {
    _tags.add(tag);
  }

  static void updateTag(TagModel updatedTag) {
    final index = _tags.indexWhere((tag) => tag.id == updatedTag.id);
    if (index != -1) {
      _tags[index] = updatedTag;
    }
  }

  static void deleteTag(String id) {
    _tags.removeWhere((tag) => tag.id == id);
  }

  static bool tagNameExists(String name, {String? excludeId}) {
    return _tags.any((tag) => 
        tag.name.toLowerCase() == name.toLowerCase() && 
        tag.id != excludeId);
  }

  static String generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
