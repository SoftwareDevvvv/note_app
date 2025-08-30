import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../models/tag_model.dart';
import '../widgets/tag_selection_sheet.dart';

class TagManagementScreen extends StatefulWidget {
  const TagManagementScreen({Key? key}) : super(key: key);

  @override
  State<TagManagementScreen> createState() => _TagManagementScreenState();
}

class _TagManagementScreenState extends State<TagManagementScreen> {
  List<TagModel> _tags = [];
  final TextEditingController _searchController = TextEditingController();
  List<TagModel> _filteredTags = [];

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  void _loadTags() {
    setState(() {
      _tags = TagService.getAllTags();
      _filteredTags = List.from(_tags);
    });
  }

  void _filterTags(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredTags = List.from(_tags);
      } else {
        _filteredTags = _tags
            .where((tag) =>
                tag.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _showCreateTagDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateTagDialog(
        onTagCreated: (tag) {
          _loadTags();
        },
      ),
    );
  }

  void _showEditTagDialog(TagModel tag) {
    showDialog(
      context: context,
      builder: (context) => EditTagDialog(
        tag: tag,
        onTagUpdated: (updatedTag) {
          _loadTags();
        },
      ),
    );
  }

  void _showDeleteConfirmation(TagModel tag) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ShibaNoteTheme.cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Tag',
          style: TextStyle(
            color: ShibaNoteTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to delete "${tag.name}"? This action cannot be undone.',
          style: const TextStyle(color: ShibaNoteTheme.textSecondary),
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
            onPressed: () {
              TagService.deleteTag(tag.id);
              Navigator.of(context).pop();
              _loadTags();
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tag "${tag.name}" deleted'),
                  backgroundColor: ShibaNoteTheme.destructiveColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ShibaNoteTheme.destructiveColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShibaNoteTheme.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: ShibaNoteTheme.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manage Tags',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ShibaNoteTheme.textPrimary,
                                fontSize: 24,
                                letterSpacing: -0.25,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Create, edit, and organize your tags',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ShibaNoteTheme.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Add button
                  GestureDetector(
                    onTap: _showCreateTagDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'New',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
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

            const SizedBox(height: 24),

            // Tags list
            Expanded(
              child: _filteredTags.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _searchController.text.isEmpty
                                ? Icons.local_offer_outlined
                                : Icons.search_off,
                            size: 64,
                            color: ShibaNoteTheme.mutedForeground.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'No tags yet'
                                : 'No tags found',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ShibaNoteTheme.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchController.text.isEmpty
                                ? 'Create your first tag to get started'
                                : 'Try adjusting your search',
                            style: TextStyle(
                              fontSize: 14,
                              color: ShibaNoteTheme.textSecondary.withOpacity(0.8),
                            ),
                          ),
                          if (_searchController.text.isEmpty) ...[
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: _showCreateTagDialog,
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text('Create Tag'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ShibaNoteTheme.primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                            ),
                          ],
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredTags.length,
                      itemBuilder: (context, index) {
                        final tag = _filteredTags[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ShibaNoteCard(
                            child: Row(
                              children: [
                                // Tag
                                ShibaNoteTag(
                                  text: tag.name,
                                  color: tag.color,
                                ),

                                const SizedBox(width: 16),

                                // Tag info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Created ${_getRelativeTime(tag.createdAt)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: ShibaNoteTheme.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: ShibaNoteTheme.mutedColor,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          '3 notes', // Placeholder
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: ShibaNoteTheme.mutedForeground,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Actions
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Edit button
                                    GestureDetector(
                                      onTap: () => _showEditTagDialog(tag),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: ShibaNoteTheme.primaryColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: ShibaNoteTheme.primaryColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 8),

                                    // Delete button
                                    GestureDetector(
                                      onTap: () => _showDeleteConfirmation(tag),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: ShibaNoteTheme.destructiveColor.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color: ShibaNoteTheme.destructiveColor,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  String _getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class EditTagDialog extends StatefulWidget {
  final TagModel tag;
  final Function(TagModel) onTagUpdated;

  const EditTagDialog({
    Key? key,
    required this.tag,
    required this.onTagUpdated,
  }) : super(key: key);

  @override
  State<EditTagDialog> createState() => _EditTagDialogState();
}

class _EditTagDialogState extends State<EditTagDialog> {
  late TextEditingController _nameController;
  late TagColor _selectedColor;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.tag.name);
    _selectedColor = widget.tag.color;
  }

  void _updateTag() {
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

    if (TagService.tagNameExists(name, excludeId: widget.tag.id)) {
      setState(() {
        _errorText = 'Tag with this name already exists';
      });
      return;
    }

    final updatedTag = widget.tag.copyWith(
      name: name,
      color: _selectedColor,
    );

    TagService.updateTag(updatedTag);
    widget.onTagUpdated(updatedTag);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ShibaNoteTheme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Edit Tag',
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
          onPressed: _updateTag,
          style: ElevatedButton.styleFrom(
            backgroundColor: ShibaNoteTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Update'),
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
