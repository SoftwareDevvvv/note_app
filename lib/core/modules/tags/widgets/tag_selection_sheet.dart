import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../models/tag_model.dart';

class TagSelectionBottomSheet extends StatefulWidget {
  final List<String> selectedTagIds;
  final Function(List<String>) onTagsChanged;

  const TagSelectionBottomSheet({
    Key? key,
    required this.selectedTagIds,
    required this.onTagsChanged,
  }) : super(key: key);

  @override
  State<TagSelectionBottomSheet> createState() => _TagSelectionBottomSheetState();
}

class _TagSelectionBottomSheetState extends State<TagSelectionBottomSheet> {
  List<String> _selectedTagIds = [];
  List<TagModel> _allTags = [];
  final TextEditingController _searchController = TextEditingController();
  List<TagModel> _filteredTags = [];

  @override
  void initState() {
    super.initState();
    _selectedTagIds = List.from(widget.selectedTagIds);
    _allTags = TagService.getAllTags();
    _filteredTags = List.from(_allTags);
  }

  void _filterTags(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTags = List.from(_allTags);
      } else {
        _filteredTags = _allTags
            .where((tag) =>
                tag.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _toggleTag(String tagId) {
    setState(() {
      if (_selectedTagIds.contains(tagId)) {
        _selectedTagIds.remove(tagId);
      } else {
        _selectedTagIds.add(tagId);
      }
    });
  }

  void _showCreateTagDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateTagDialog(
        onTagCreated: (tag) {
          setState(() {
            _allTags = TagService.getAllTags();
            _filteredTags = List.from(_allTags);
            _selectedTagIds.add(tag.id);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: ShibaNoteTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: ShibaNoteTheme.borderColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Select Tags',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ShibaNoteTheme.textPrimary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onTagsChanged(_selectedTagIds);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Done',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ShibaNoteTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: ShibaNoteTheme.textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search tags...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    onChanged: _filterTags,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Create new tag button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showCreateTagDialog,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Create New Tag'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ShibaNoteTheme.primaryColor,
                side: const BorderSide(color: ShibaNoteTheme.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tags list
          Expanded(
            child: _filteredTags.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 48,
                          color: ShibaNoteTheme.mutedForeground.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _searchController.text.isEmpty
                              ? 'No tags available'
                              : 'No tags found',
                          style: TextStyle(
                            color: ShibaNoteTheme.mutedForeground.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _filteredTags.length,
                    itemBuilder: (context, index) {
                      final tag = _filteredTags[index];
                      final isSelected = _selectedTagIds.contains(tag.id);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _toggleTag(tag.id),
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ShibaNoteTheme.primaryColor.withOpacity(0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? ShibaNoteTheme.primaryColor.withOpacity(0.3)
                                      : ShibaNoteTheme.borderColor.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Checkbox
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? ShibaNoteTheme.primaryColor
                                          : Colors.transparent,
                                      border: Border.all(
                                        color: isSelected
                                            ? ShibaNoteTheme.primaryColor
                                            : ShibaNoteTheme.borderColor,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: isSelected
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 14,
                                          )
                                        : null,
                                  ),

                                  const SizedBox(width: 12),

                                  // Tag
                                  ShibaNoteTag(
                                    text: tag.name,
                                    color: tag.color,
                                  ),

                                  const Spacer(),

                                  // Tag count (placeholder)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: ShibaNoteTheme.mutedColor,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '3 notes', // Placeholder count
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: ShibaNoteTheme.mutedForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Bottom padding
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class CreateTagDialog extends StatefulWidget {
  final Function(TagModel) onTagCreated;

  const CreateTagDialog({
    Key? key,
    required this.onTagCreated,
  }) : super(key: key);

  @override
  State<CreateTagDialog> createState() => _CreateTagDialogState();
}

class _CreateTagDialogState extends State<CreateTagDialog> {
  final TextEditingController _nameController = TextEditingController();
  TagColor _selectedColor = TagColor.blue;
  String? _errorText;

  void _createTag() {
    final name = _nameController.text.trim();
    
    if (name.isEmpty) {
      setState(() {
        _errorText = 'Tag name is required';
      });
      return;
    }

    if (name.length > 20) {
      setState(() {
        _errorText = 'Tag name must be 20 characters or less';
      });
      return;
    }

    if (TagService.tagNameExists(name)) {
      setState(() {
        _errorText = 'Tag with this name already exists';
      });
      return;
    }

    final tag = TagModel(
      id: TagService.generateId(),
      name: name,
      color: _selectedColor,
      createdAt: DateTime.now(),
    );

    TagService.addTag(tag);
    widget.onTagCreated(tag);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ShibaNoteTheme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Create New Tag',
        style: TextStyle(
          color: ShibaNoteTheme.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name input
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Tag name',
              hintText: 'Enter tag name',
              errorText: _errorText,
              filled: true,
              fillColor: Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ShibaNoteTheme.borderColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: ShibaNoteTheme.borderColor.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: ShibaNoteTheme.primaryColor,
                  width: 2,
                ),
              ),
            ),
            maxLength: 20,
            onChanged: (value) {
              if (_errorText != null) {
                setState(() {
                  _errorText = null;
                });
              }
            },
          ),

          const SizedBox(height: 16),

          // Color selection
          const Text(
            'Color',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ShibaNoteTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: TagColor.values.map((color) {
              final isSelected = _selectedColor == color;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedColor = color;
                  });
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getTagBackgroundColor(color),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? ShibaNoteTheme.primaryColor
                          : ShibaNoteTheme.borderColor.withOpacity(0.5),
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : null,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancel',
            style: TextStyle(color: ShibaNoteTheme.textSecondary),
          ),
        ),
        ElevatedButton(
          onPressed: _createTag,
          style: ElevatedButton.styleFrom(
            backgroundColor: ShibaNoteTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Create'),
        ),
      ],
    );
  }

  Color _getTagBackgroundColor(TagColor color) {
    switch (color) {
      case TagColor.pink:
        return ShibaNoteTheme.tagPink;
      case TagColor.blue:
        return ShibaNoteTheme.tagBlue;
      case TagColor.green:
        return ShibaNoteTheme.tagGreen;
      case TagColor.purple:
        return ShibaNoteTheme.tagPurple;
      case TagColor.yellow:
        return ShibaNoteTheme.tagYellow;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
