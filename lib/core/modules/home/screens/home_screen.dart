import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/sidebar.dart';
import '../../note/screens/add_note_screen.dart';
import '../../note/screens/note_detail_screen.dart';
import '../../search/screens/search_screen.dart';
// Import your theme file

class ShibaNoteHomeScreen extends StatelessWidget {
  const ShibaNoteHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add the sidebar as a drawer
      drawer: const ShibaNoteSidebar(),
      // Remove manual backgroundColor - let theme handle it
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            const ShibaNoteAppBar(),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Recent Notes Section
                    const ShibaNoteSectionHeader(title: 'Recent Notes'),
                    const SizedBox(height: 16),

                    // Note Cards - Simplified with only favorites
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 1),
                          ),
                        );
                      },
                      child: const ShibaNoteCard(
                        title: 'Morning Routine Ideas',
                        content:
                            'Wake up at 6 AM, drink water, meditation for 10 minutes, light stretching, healthy breakfast with fruits and oats. Remember to set intentions for the day!',
                        tags: [
                          NoteTag(text: 'Health', color: TagColor.green),
                          NoteTag(text: 'Morning', color: TagColor.yellow),
                        ],
                        timeAgo: 'Today',
                        isFavorited: true,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 2),
                          ),
                        );
                      },
                      child: const ShibaNoteCard(
                        title: 'Weekend Adventure Planning',
                        content:
                            'Visit the local farmers market, try that new hiking trail near the lake, picnic lunch with homemade sandwiches, maybe catch sunset at the viewpoint.',
                        tags: [
                          NoteTag(text: 'Adventure', color: TagColor.blue),
                          NoteTag(text: 'Weekend', color: TagColor.purple),
                        ],
                        timeAgo: '2 days ago',
                        isFavorited: false,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const NoteDetailScreen(noteId: 3),
                          ),
                        );
                      },
                      child: const ShibaNoteCard(
                        title: 'Gift Ideas for Mom',
                        content:
                            'Handmade photo album with family memories, her favorite lavender candles, cooking class voucher, cozy reading nook setup with soft cushions.',
                        tags: [
                          NoteTag(text: 'Family', color: TagColor.pink),
                          NoteTag(text: 'Gifts', color: TagColor.purple),
                        ],
                        timeAgo: '1 week ago',
                        isFavorited: true,
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShibaNoteAppBar extends StatelessWidget {
  const ShibaNoteAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: const BoxDecoration(
        color: ShibaNoteTheme.backgroundColor,
      ),
      child: Row(
        children: [
          // Menu Icon
          Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                // Open the drawer/sidebar
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                child: const Icon(
                  LucideIcons.menu,
                  color: ShibaNoteTheme.textPrimary,
                  size: 24,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // App Title and Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ShiboNote',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ShibaNoteTheme.textPrimary,
                        fontSize: 24,
                        letterSpacing: -0.25,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cute notes, organized',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ShibaNoteTheme.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),

          // Search Icon
          GestureDetector(
            onTap: () {
              // Navigate to search screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: const Icon(
                LucideIcons.search,
                color: ShibaNoteTheme.textSecondary,
                size: 24,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // Add Button - Matching your design exactly
          GestureDetector(
            onTap: () {
              // Navigate to add note screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNoteScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ShibaNoteTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.add,
                    color: ShibaNoteTheme.primaryForeground,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Add',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: ShibaNoteTheme.primaryForeground,
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
    );
  }
}

class ShibaNoteSectionHeader extends StatelessWidget {
  final String title;

  const ShibaNoteSectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: ShibaNoteTheme.textPrimary,
            fontSize: 20,
            letterSpacing: 0,
          ),
    );
  }
}

class NoteTag {
  final String text;
  final TagColor color;

  const NoteTag({
    required this.text,
    required this.color,
  });
}

class ShibaNoteCard extends StatelessWidget {
  final String title;
  final String content;
  final List<NoteTag> tags;
  final String timeAgo;
  final bool isFavorited;

  const ShibaNoteCard({
    Key? key,
    required this.title,
    required this.content,
    required this.tags,
    required this.timeAgo,
    this.isFavorited = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16), // p-4 equivalent (not p-6)
      decoration: BoxDecoration(
        color: ShibaNoteTheme.cardColor,
        borderRadius: BorderRadius.circular(16), // rounded-lg
        // TSX: border-border/50 and hover:border-primary/20
        border: Border.all(
          color:
              ShibaNoteTheme.borderColor.withOpacity(0.5), // border-border/50
          width: 1,
        ),
        // More subtle shadow like CSS shadow-sm
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000), // Very subtle shadow
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and icons - TSX: flex items-start justify-between gap-2
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w500, // Lighter to match web font-semibold
                    color:
                        ShibaNoteTheme.foregroundColor, // text-card-foreground
                    fontSize: 16, // text-base
                    height: 1.25, // leading-tight
                  ),
                ),
              ),
              const SizedBox(width: 8), // gap-2

              // Heart icon - only favorites now ❤️
              if (isFavorited)
                const Icon(
                  Icons.favorite,
                  color: ShibaNoteTheme
                      .destructiveColor, // fill-destructive text-destructive
                  size: 16, // h-4 w-4
                ),
            ],
          ),

          const SizedBox(height: 12), // space-y-3

          // Content - TSX: text-sm text-muted-foreground line-clamp-3 leading-relaxed
          Text(
            content,
            style: const TextStyle(
              color: ShibaNoteTheme.mutedForeground, // text-muted-foreground
              fontSize: 14, // text-sm
              height: 1.6, // leading-relaxed
            ),
            maxLines: 3, // line-clamp-3
            overflow: TextOverflow.ellipsis,
          ),

          // Tags - TSX: flex flex-wrap gap-1.5
          if (tags.isNotEmpty) ...[
            const SizedBox(height: 12), // space-y-3
            Wrap(
              spacing: 6, // gap-1.5 equivalent
              runSpacing: 6,
              children: tags
                  .map((tag) => ShibaNoteTag(
                        text: tag.text,
                        color: tag.color,
                      ))
                  .toList(),
            ),
          ],

          const SizedBox(height: 12), // space-y-3 + pt-1

          // Date - TSX: flex items-center gap-1 text-xs text-muted-foreground pt-1
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: ShibaNoteTheme.mutedForeground, // text-muted-foreground
                size: 12, // h-3 w-3
              ),
              const SizedBox(width: 4), // gap-1
              Text(
                timeAgo,
                style: const TextStyle(
                  color:
                      ShibaNoteTheme.mutedForeground, // text-muted-foreground
                  fontSize: 12, // text-xs
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
