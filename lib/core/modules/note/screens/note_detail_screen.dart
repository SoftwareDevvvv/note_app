import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

// Sample data - in real app, this would come from props or state management
class Note {
  final int id;
  final String title;
  final String content;
  final List<NoteTag> tags;
  final String date;
  final bool isFavorited;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.date,
    required this.isFavorited,
  });
}

class NoteTag {
  final String text;
  final TagColor color;

  const NoteTag({
    required this.text,
    required this.color,
  });
}

// Sample notes data
const List<Note> sampleNotes = [
  Note(
    id: 1,
    title: "Morning Routine Ideas",
    content:
        "Wake up at 6 AM, drink water, meditation for 10 minutes, light stretching, healthy breakfast with fruits and oats. Remember to set intentions for the day!",
    tags: [
      NoteTag(text: "Health", color: TagColor.green),
      NoteTag(text: "Morning", color: TagColor.yellow),
    ],
    date: "Today",
    isFavorited: true,
  ),
  Note(
    id: 2,
    title: "Weekend Adventure Planning",
    content:
        "Visit the local farmers market, try that new hiking trail near the lake, picnic lunch with homemade sandwiches, maybe catch sunset at the viewpoint.",
    tags: [
      NoteTag(text: "Adventure", color: TagColor.blue),
      NoteTag(text: "Weekend", color: TagColor.purple),
    ],
    date: "2 days ago",
    isFavorited: false,
  ),
  Note(
    id: 3,
    title: "Gift Ideas for Mom",
    content:
        "Handmade photo album with family memories, her favorite lavender candles, cooking class voucher, cozy reading nook setup with soft cushions.",
    tags: [
      NoteTag(text: "Family", color: TagColor.pink),
      NoteTag(text: "Gifts", color: TagColor.purple),
    ],
    date: "1 week ago",
    isFavorited: true,
  ),
  Note(
    id: 4,
    title: "Study Notes - Japanese",
    content:
        "今日は いい天気ですね (It's nice weather today). Practice: greetings, numbers 1-20, basic particles は、を、に. Review hiragana flashcards before bed.",
    tags: [
      NoteTag(text: "Study", color: TagColor.blue),
      NoteTag(text: "Japanese", color: TagColor.pink),
    ],
    date: "3 days ago",
    isFavorited: false,
  ),
];

class NoteDetailScreen extends StatefulWidget {
  final int noteId;

  const NoteDetailScreen({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note note;
  late bool isFavorited;

  @override
  void initState() {
    super.initState();
    // Find the note by ID, fallback to first note
    note = sampleNotes.firstWhere(
      (n) => n.id == widget.noteId,
      orElse: () => sampleNotes.first,
    );
    isFavorited = note.isFavorited;
  }

  void _handleBack() {
    Navigator.of(context).pop();
  }

  void _handleEdit() {
    // TODO: Implement edit functionality
    print("Edit note: ${widget.noteId}");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit functionality coming soon!'),
        backgroundColor: ShibaNoteTheme.primaryColor,
      ),
    );
  }

  void _handleDelete() {
    // TODO: Implement delete functionality
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ShibaNoteTheme.cardColor,
          title: const Text(
            'Delete Note',
            style: TextStyle(
              color: ShibaNoteTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this note? This action cannot be undone.',
            style: TextStyle(
              color: ShibaNoteTheme.textSecondary,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(color: ShibaNoteTheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to home
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note deleted'),
                    backgroundColor: ShibaNoteTheme.destructiveColor,
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: ShibaNoteTheme.destructiveColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorited = !isFavorited;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text(isFavorited ? 'Added to favorites' : 'Removed from favorites'),
        backgroundColor: ShibaNoteTheme.primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShibaNoteTheme.backgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints:
              const BoxConstraints(maxWidth: 400), // max-w-md equivalent
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: _handleBack,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: ShibaNoteTheme.cardColor.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 16,
                            color: ShibaNoteTheme.textSecondary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              color: ShibaNoteTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Buttons
                  Row(
                    children: [
                      // Edit Button
                      GestureDetector(
                        onTap: _handleEdit,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ShibaNoteTheme.cardColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  ShibaNoteTheme.borderColor.withOpacity(0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: ShibaNoteTheme.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Delete Button
                      GestureDetector(
                        onTap: _handleDelete,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: ShibaNoteTheme.cardColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  ShibaNoteTheme.borderColor.withOpacity(0.3),
                            ),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            size: 16,
                            color: ShibaNoteTheme.destructiveColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Note Content Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24), // p-6
                decoration: BoxDecoration(
                  color: ShibaNoteTheme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ShibaNoteTheme.borderColor.withOpacity(0.3),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title and Actions
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            note.title,
                            style: const TextStyle(
                              fontSize: 24, // text-2xl
                              fontWeight: FontWeight.bold,
                              color: ShibaNoteTheme.foregroundColor,
                              height: 1.2, // leading-tight
                            ),
                          ),
                        ),
                        const SizedBox(width: 12), // gap-3

                        // Favorite Button
                        GestureDetector(
                          onTap: _toggleFavorite,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isFavorited
                                  ? ShibaNoteTheme.destructiveColor
                                      .withOpacity(0.1)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20, // h-5 w-5
                              color: isFavorited
                                  ? ShibaNoteTheme.destructiveColor
                                  : ShibaNoteTheme.mutedForeground,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Separator
                    Container(
                      height: 1,
                      color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                    ),

                    const SizedBox(height: 16),

                    // Content
                    Text(
                      note.content,
                      style: const TextStyle(
                        color: ShibaNoteTheme.foregroundColor,
                        fontSize: 16,
                        height: 1.6, // leading-relaxed
                      ),
                    ),

                    // Tags Section
                    if (note.tags.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Tags',
                        style: TextStyle(
                          fontSize: 14, // text-sm
                          fontWeight: FontWeight.w500,
                          color: ShibaNoteTheme.mutedForeground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8, // gap-2
                        runSpacing: 8,
                        children: note.tags
                            .map((tag) => ShibaNoteTag(
                                  text: tag.text,
                                  color: tag.color,
                                ))
                            .toList(),
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Separator
                    Container(
                      height: 1,
                      color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                    ),

                    const SizedBox(height: 16),

                    // Metadata
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 16, // h-4 w-4
                          color: ShibaNoteTheme.mutedForeground,
                        ),
                        const SizedBox(width: 8), // gap-2
                        Text(
                          'Created ${note.date}',
                          style: const TextStyle(
                            fontSize: 14, // text-sm
                            color: ShibaNoteTheme.mutedForeground,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(), // Push content to top
            ],
          ),
        ),
      ),
    );
  }
}
