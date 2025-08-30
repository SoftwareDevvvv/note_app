import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../tags/models/tag_model.dart';
import '../../tags/widgets/tag_selection_sheet.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _contentFocusNode = FocusNode();
  
  bool _isFavorited = false;
  List<String> _selectedTagIds = [];

  @override
  void initState() {
    super.initState();
    // Auto-focus title when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _titleFocusNode.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _showTagSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TagSelectionBottomSheet(
        selectedTagIds: _selectedTagIds,
        onTagsChanged: (selectedIds) {
          setState(() {
            _selectedTagIds = selectedIds;
          });
        },
      ),
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

  Color _getTagForegroundColor(TagColor color) {
    switch (color) {
      case TagColor.pink:
        return ShibaNoteTheme.tagPinkForeground;
      case TagColor.blue:
        return ShibaNoteTheme.tagBlueForeground;
      case TagColor.green:
        return ShibaNoteTheme.tagGreenForeground;
      case TagColor.purple:
        return ShibaNoteTheme.tagPurpleForeground;
      case TagColor.yellow:
        return ShibaNoteTheme.tagYellowForeground;
    }
  }

  void _saveNote() {
    // Handle save functionality here
    // For now, just navigate back
    Navigator.of(context).pop();
    
    // Show a brief success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Note saved successfully!'),
        duration: Duration(seconds: 2),
        backgroundColor: ShibaNoteTheme.primaryColor,
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
            // Custom Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              decoration: const BoxDecoration(
                color: ShibaNoteTheme.backgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x1A000000), // Very subtle border
                    width: 1,
                  ),
                ),
              ),
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
                          'New Note',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ShibaNoteTheme.textPrimary,
                                fontSize: 20,
                                letterSpacing: -0.25,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Create something wonderful',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ShibaNoteTheme.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ),

                  // Favorite Toggle
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isFavorited = !_isFavorited;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _isFavorited 
                            ? ShibaNoteTheme.destructiveColor.withOpacity(0.1)
                            : ShibaNoteTheme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isFavorited
                              ? ShibaNoteTheme.destructiveColor.withOpacity(0.3)
                              : ShibaNoteTheme.borderColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited 
                            ? ShibaNoteTheme.destructiveColor 
                            : ShibaNoteTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Input
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ShibaNoteTheme.borderColor.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _titleController,
                        focusNode: _titleFocusNode,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: ShibaNoteTheme.textPrimary,
                          height: 1.3,
                        ),
                        decoration: InputDecoration(
                          hintText: '💡 Note title',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: ShibaNoteTheme.textSecondary.withOpacity(0.7),
                            height: 1.3,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Content Input
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: ShibaNoteTheme.borderColor.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: _contentController,
                        focusNode: _contentFocusNode,
                        maxLines: null,
                        minLines: 8,
                        style: const TextStyle(
                          fontSize: 16,
                          color: ShibaNoteTheme.textPrimary,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write your thoughts here...\n\nThis is your space to capture ideas, memories, plans, or anything that matters to you.',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: ShibaNoteTheme.textSecondary.withOpacity(0.6),
                            height: 1.5,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          filled: true,
                          fillColor: Colors.transparent,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Tags Section
                    Row(
                      children: [
                        Text(
                          'Tags',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ShibaNoteTheme.textPrimary,
                                fontSize: 16,
                              ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _showTagSelection,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: ShibaNoteTheme.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: ShibaNoteTheme.primaryColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: ShibaNoteTheme.primaryColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Add Tags',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Selected Tags Display
                    if (_selectedTagIds.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: TagService.getTagsByIds(_selectedTagIds).map((tag) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedTagIds.remove(tag.id);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getTagBackgroundColor(tag.color),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _getTagBackgroundColor(tag.color).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tag.name,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: _getTagForegroundColor(tag.color),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.close,
                                    size: 14,
                                    color: _getTagForegroundColor(tag.color).withOpacity(0.7),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ] else ...[
                      // Empty state
                      GestureDetector(
                        onTap: _showTagSelection,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.local_offer_outlined,
                                color: ShibaNoteTheme.textSecondary.withOpacity(0.6),
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to add tags',
                                style: TextStyle(
                                  color: ShibaNoteTheme.textSecondary.withOpacity(0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Actions Footer
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: ShibaNoteTheme.backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Color(0x1A000000), // Very subtle border
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  // Cancel Button
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: ShibaNoteTheme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ShibaNoteTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Save Button
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: _saveNote,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: ShibaNoteTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.check,
                              color: ShibaNoteTheme.primaryForeground,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Save Note',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: ShibaNoteTheme.primaryForeground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
