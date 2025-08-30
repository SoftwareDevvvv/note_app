import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

// Sample trash data structure
class TrashedNote {
  final int id;
  final String title;
  final String content;
  final List<String> tags;
  final String date;
  final bool isFavorited;
  final bool isImportant;

  TrashedNote({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.date,
    this.isFavorited = false,
    this.isImportant = false,
  });
}

class TrashScreen extends StatefulWidget {
  const TrashScreen({Key? key}) : super(key: key);

  @override
  State<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  // Sample trash data
  List<TrashedNote> notes = [
    TrashedNote(
      id: 101,
      title: "Old Shopping List",
      content: "Milk, bread, eggs, cheese, apples. Don't forget to check expiry dates!",
      tags: ["Shopping"],
      date: "Deleted 2 days ago",
    ),
    TrashedNote(
      id: 102,
      title: "Random Thoughts",
      content: "Sometimes I wonder if dogs think about what humans are thinking about...",
      tags: ["Random"],
      date: "Deleted 1 week ago",
    ),
  ];

  void handleRestore(int noteId) {
    setState(() {
      notes = notes.where((note) => note.id != noteId).toList();
    });
    // TODO: Actually restore the note to main notes
    print("Restored note: $noteId");
  }

  void handlePermanentDelete(int noteId) {
    setState(() {
      notes = notes.where((note) => note.id != noteId).toList();
    });
    print("Permanently deleted note: $noteId");
  }

  void handleEmptyTrash() {
    setState(() {
      notes = [];
    });
    print("Emptied trash");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShibaNoteTheme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
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
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Trash',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: ShibaNoteTheme.textPrimary,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            '${notes.length} deleted notes',
                            style: const TextStyle(
                              fontSize: 14,
                              color: ShibaNoteTheme.mutedForeground,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (notes.isNotEmpty)
                      IconButton(
                        onPressed: handleEmptyTrash,
                        icon: const Icon(
                          Icons.delete_forever,
                          color: ShibaNoteTheme.destructiveColor,
                          size: 20,
                        ),
                        padding: const EdgeInsets.all(4),
                      ),
                  ],
                ),

                const SizedBox(height: 24),

                // Notes or Empty State
                notes.isNotEmpty ? _buildNotesList() : _buildEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    return Column(
      children: notes.map((note) => _buildTrashNoteCard(note)).toList(),
    );
  }

  Widget _buildTrashNoteCard(TrashedNote note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ShibaNoteTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ShibaNoteTheme.borderColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Note Content (using same structure as ShibaNoteCard)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: ShibaNoteTheme.foregroundColor,
                      fontSize: 16,
                      height: 1.25,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (note.isImportant || note.isFavorited)
                  Row(
                    children: [
                      if (note.isImportant)
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: ShibaNoteTheme.primaryColor,
                        ),
                      if (note.isFavorited) ...[
                        if (note.isImportant) const SizedBox(width: 4),
                        const Icon(
                          Icons.favorite,
                          size: 16,
                          color: ShibaNoteTheme.destructiveColor,
                        ),
                      ],
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Content
            Text(
              note.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: ShibaNoteTheme.mutedForeground,
                height: 1.6,
                fontFamily: 'Nunito',
              ),
            ),

            if (note.tags.isNotEmpty) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: note.tags.map((tag) {
                  final colorIndex = tag.hashCode % TagColors.backgroundColors.length;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: TagColors.backgroundColors[colorIndex],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: TagColors.foregroundColors[colorIndex],
                        fontFamily: 'Nunito',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 12),

            // Date
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 12,
                  color: ShibaNoteTheme.mutedForeground,
                ),
                const SizedBox(width: 4),
                Text(
                  note.date,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ShibaNoteTheme.mutedForeground,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Separator
            Container(
              height: 1,
              color: ShibaNoteTheme.borderColor.withOpacity(0.2),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Restore Button
                TextButton.icon(
                  onPressed: () => handleRestore(note.id),
                  icon: const Icon(
                    Icons.restore,
                    size: 16,
                    color: ShibaNoteTheme.textSecondary,
                  ),
                  label: const Text(
                    'Restore',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ShibaNoteTheme.textSecondary,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),

                const SizedBox(width: 8),

                // Delete Forever Button
                TextButton.icon(
                  onPressed: () => handlePermanentDelete(note.id),
                  icon: const Icon(
                    Icons.delete_forever,
                    size: 16,
                    color: ShibaNoteTheme.destructiveColor,
                  ),
                  label: const Text(
                    'Delete Forever',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ShibaNoteTheme.destructiveColor,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ShibaNoteTheme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ShibaNoteTheme.borderColor.withOpacity(0.5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(
            Icons.delete_outline,
            size: 48,
            color: ShibaNoteTheme.mutedForeground,
          ),
          SizedBox(height: 16),
          Text(
            'Trash is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ShibaNoteTheme.textPrimary,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Deleted notes will appear here',
            style: TextStyle(
              fontSize: 14,
              color: ShibaNoteTheme.mutedForeground,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }
}
