import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../note/screens/note_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

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
              decoration: const BoxDecoration(
                color: ShibaNoteTheme.backgroundColor,
              ),
              child: Row(
                children: [
                  // Back Button - Consistent with add_note_screen
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
                          'Favorites',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: ShibaNoteTheme.textPrimary,
                                fontSize: 24,
                                letterSpacing: -0.25,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Your starred notes',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ShibaNoteTheme.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Favorite Notes
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 1),
                          ),
                        );
                      },
                      child: ShibaNoteCard(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NoteDetailScreen(noteId: 1),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Morning Routine Ideas',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: ShibaNoteTheme.foregroundColor,
                                      fontSize: 16,
                                      height: 1.25,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.favorite,
                                  color: ShibaNoteTheme.destructiveColor,
                                  size: 16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Wake up at 6 AM, drink water, meditation for 10 minutes, light stretching, healthy breakfast with fruits and oats. Remember to set intentions for the day!',
                              style: const TextStyle(
                                color: ShibaNoteTheme.mutedForeground,
                                fontSize: 14,
                                height: 1.6,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: [
                                ShibaNoteTag(text: 'Health', color: TagColor.green),
                                ShibaNoteTag(text: 'Morning', color: TagColor.yellow),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: ShibaNoteTheme.mutedForeground,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Today',
                                  style: const TextStyle(
                                    color: ShibaNoteTheme.mutedForeground,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ShibaNoteCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 3),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Gift Ideas for Mom',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.foregroundColor,
                                    fontSize: 16,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.favorite,
                                color: ShibaNoteTheme.destructiveColor,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Handmade photo album with family memories, her favorite lavender candles, cooking class voucher, cozy reading nook setup with soft cushions.',
                            style: const TextStyle(
                              color: ShibaNoteTheme.mutedForeground,
                              fontSize: 14,
                              height: 1.6,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              ShibaNoteTag(text: 'Family', color: TagColor.pink),
                              ShibaNoteTag(text: 'Gifts', color: TagColor.purple),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: ShibaNoteTheme.mutedForeground,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '1 week ago',
                                style: const TextStyle(
                                  color: ShibaNoteTheme.mutedForeground,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    ShibaNoteCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 4),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Book Recommendations',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.foregroundColor,
                                    fontSize: 16,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.favorite,
                                color: ShibaNoteTheme.destructiveColor,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'The Seven Husbands of Evelyn Hugo, Atomic Habits, The Midnight Library, Project Hail Mary, Educated by Tara Westover.',
                            style: const TextStyle(
                              color: ShibaNoteTheme.mutedForeground,
                              fontSize: 14,
                              height: 1.6,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              ShibaNoteTag(text: 'Books', color: TagColor.blue),
                              ShibaNoteTag(text: 'Reading', color: TagColor.purple),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: ShibaNoteTheme.mutedForeground,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '3 days ago',
                                style: const TextStyle(
                                  color: ShibaNoteTheme.mutedForeground,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    ShibaNoteCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 5),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Travel Bucket List',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: ShibaNoteTheme.foregroundColor,
                                    fontSize: 16,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.favorite,
                                color: ShibaNoteTheme.destructiveColor,
                                size: 16,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Japan cherry blossom season, Northern Lights in Iceland, Safari in Kenya, Italian countryside in Tuscany, New Zealand road trip.',
                            style: const TextStyle(
                              color: ShibaNoteTheme.mutedForeground,
                              fontSize: 14,
                              height: 1.6,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: [
                              ShibaNoteTag(text: 'Travel', color: TagColor.green),
                              ShibaNoteTag(text: 'Dreams', color: TagColor.yellow),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: ShibaNoteTheme.mutedForeground,
                                size: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '2 weeks ago',
                                style: const TextStyle(
                                  color: ShibaNoteTheme.mutedForeground,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Empty state message (when no favorites exist)
                    // You could conditionally show this when the list is empty
                    // _buildEmptyState(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Optional: Empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Icon(
            Icons.favorite_outline,
            size: 64,
            color: ShibaNoteTheme.mutedForeground.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No favorite notes yet',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: ShibaNoteTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the heart icon on notes to add them to your favorites',
            style: const TextStyle(
              fontSize: 14,
              color: ShibaNoteTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
