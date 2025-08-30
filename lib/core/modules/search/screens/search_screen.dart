import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _queryController = TextEditingController();
  final FocusNode _queryFocusNode = FocusNode();

  List<String> _selectedTags = [];
  bool _onlyFavorites = false;
  String _dateRange = 'all';

  final List<String> _availableTags = [
    'Health',
    'Study',
    'Family',
    'Work',
    'Adventure',
    'Ideas',
    'Morning',
    'Weekend',
    'Books',
    'Cooking'
  ];

  @override
  void initState() {
    super.initState();
    // Auto-focus search input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _queryFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    _queryFocusNode.dispose();
    super.dispose();
  }

  void _handleSearch() {
    // Handle search functionality here
    print('Search: ${_queryController.text}');
    print('Tags: $_selectedTags');
    print('Only Favorites: $_onlyFavorites');
    print('Date Range: $_dateRange');

    Navigator.of(context).pop();
  }

  void _clearFilters() {
    setState(() {
      _queryController.clear();
      _selectedTags.clear();
      _onlyFavorites = false;
      _dateRange = 'all';
    });
  }

  void _addTag(String tag) {
    if (!_selectedTags.contains(tag)) {
      setState(() {
        _selectedTags.add(tag);
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _selectedTags.remove(tag);
    });
  }

  bool get _hasActiveFilters =>
      _queryController.text.isNotEmpty ||
      _selectedTags.isNotEmpty ||
      _onlyFavorites ||
      _dateRange != 'all';

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
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x1A000000),
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
                          'Search Notes',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: ShibaNoteTheme.textPrimary,
                                fontSize: 20,
                                letterSpacing: -0.25,
                              ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Find your thoughts quickly',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Input
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Search query',
                          style: TextStyle(
                            color: ShibaNoteTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color:
                                  ShibaNoteTheme.borderColor.withOpacity(0.08),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _queryController,
                            focusNode: _queryFocusNode,
                            decoration: const InputDecoration(
                              hintText: 'Search in titles and content...',
                              hintStyle: TextStyle(
                                color: ShibaNoteTheme.textSecondary,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(12),
                              filled: true,
                              fillColor: Colors.transparent,
                            ),
                            style: const TextStyle(
                              color: ShibaNoteTheme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Separator
                    Container(
                      height: 1,
                      color: ShibaNoteTheme.borderColor.withOpacity(0.2),
                    ),

                    const SizedBox(height: 24),

                    // Filters Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Filters',
                          style: TextStyle(
                            color: ShibaNoteTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Quick Filters
                        GestureDetector(
                          onTap: () =>
                              setState(() => _onlyFavorites = !_onlyFavorites),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: _onlyFavorites
                                  ? ShibaNoteTheme.primaryColor
                                  : ShibaNoteTheme.cardColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: _onlyFavorites
                                    ? ShibaNoteTheme.primaryColor
                                    : ShibaNoteTheme.borderColor
                                        .withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              'Favorites only',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _onlyFavorites
                                    ? ShibaNoteTheme.primaryForeground
                                    : ShibaNoteTheme.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Date Range
                        const Text(
                          'Date Range',
                          style: TextStyle(
                            color: ShibaNoteTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Column(
                          children:
                              ['all', 'today', 'week', 'month'].map((range) {
                            final isSelected = _dateRange == range;
                            String label;
                            switch (range) {
                              case 'all':
                                label = 'All time';
                                break;
                              case 'today':
                                label = 'Today';
                                break;
                              case 'week':
                                label = 'Week';
                                break;
                              case 'month':
                                label = 'Month';
                                break;
                              default:
                                label = range;
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: GestureDetector(
                                onTap: () => setState(() => _dateRange = range),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ShibaNoteTheme.primaryColor
                                        : ShibaNoteTheme.cardColor,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? ShibaNoteTheme.primaryColor
                                          : ShibaNoteTheme.borderColor
                                              .withOpacity(0.3),
                                    ),
                                  ),
                                  child: Text(
                                    label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? ShibaNoteTheme.primaryForeground
                                          : ShibaNoteTheme.textSecondary,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 20),

                        // Tag Filters
                        const Text(
                          'Filter by tags',
                          style: TextStyle(
                            color: ShibaNoteTheme.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Available tags
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _availableTags.map((tag) {
                            final isSelected = _selectedTags.contains(tag);
                            return GestureDetector(
                              onTap: () =>
                                  isSelected ? _removeTag(tag) : _addTag(tag),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? ShibaNoteTheme.primaryColor
                                          .withOpacity(0.2)
                                      : ShibaNoteTheme.cardColor,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? ShibaNoteTheme.primaryColor
                                        : ShibaNoteTheme.borderColor
                                            .withOpacity(0.3),
                                  ),
                                ),
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    color: isSelected
                                        ? ShibaNoteTheme.primaryColor
                                        : ShibaNoteTheme.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        // Selected tags display
                        if (_selectedTags.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'Selected tags',
                            style: TextStyle(
                              color: ShibaNoteTheme.textPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            children: _selectedTags.map((tag) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: ShibaNoteTheme.primaryColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      tag,
                                      style: const TextStyle(
                                        color: ShibaNoteTheme.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () => _removeTag(tag),
                                      child: const Text(
                                        '✕',
                                        style: TextStyle(
                                          color: ShibaNoteTheme.primaryColor,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: const BoxDecoration(
                color: ShibaNoteTheme.backgroundColor,
                border: Border(
                  top: BorderSide(
                    color: Color(0x1A000000),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _handleSearch,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: ShibaNoteTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Search',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ShibaNoteTheme.primaryForeground,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (_hasActiveFilters) ...[
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _clearFilters,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
                        decoration: BoxDecoration(
                          color: ShibaNoteTheme.cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: ShibaNoteTheme.borderColor.withOpacity(0.3),
                          ),
                        ),
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: ShibaNoteTheme.textSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
