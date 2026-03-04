import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String duration;
  final List<String> ingredients;
  final List<String> steps;

  const RecipeDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.ingredients,
    required this.steps,
  });

  Widget _buildImage() {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return Image.network(
        imageUrl,
        width: double.infinity,
        height: 260,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imageFallback(),
      );
    } else if (imageUrl.isNotEmpty) {
      return Image.asset(
        imageUrl,
        width: double.infinity,
        height: 260,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _imageFallback(),
      );
    }
    return _imageFallback();
  }

  Widget _imageFallback() => Container(
        height: 260,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, size: 60),
      );

  @override
  Widget build(BuildContext context) {
    // context.watch rebuilds this widget whenever FavoritesProvider changes
    final favProvider = context.watch<FavoritesProvider>();
    final isFavorite = favProvider.isFavorite(title);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      body: CustomScrollView(
        slivers: [
          // ── Hero image + app bar ───────────────────────────────────────
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black87,
            actions: [
              IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(isFavorite),
                    color: Colors.redAccent,
                  ),
                ),
                onPressed: () => context
                    .read<FavoritesProvider>()
                    .toggleFavorite(title),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImage(),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + duration
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.timer_outlined,
                                size: 14, color: Color(0xFFFF3D03)),
                            const SizedBox(width: 4),
                            Text(
                              duration,
                              style: const TextStyle(
                                color: Color(0xFFFF3D03),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Favorite Button ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => context
                          .read<FavoritesProvider>()
                          .toggleFavorite(title),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      label: Text(
                        isFavorite ? 'Saved to Favorites' : 'Add to Favorites',
                        style: TextStyle(
                          color: isFavorite ? Colors.red : Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(
                          color: isFavorite
                              ? Colors.red.shade300
                              : Colors.grey.shade400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: isFavorite
                            ? Colors.red.withOpacity(0.06)
                            : Colors.transparent,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  _sectionDivider(),
                  const SizedBox(height: 20),

                  // Ingredients
                  _sectionTitle('🛒 Ingredients'),
                  const SizedBox(height: 12),
                  ...ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFFFA53F),
                                  fontWeight: FontWeight.bold)),
                          Expanded(
                            child: Text(ingredient,
                                style: const TextStyle(
                                    fontSize: 15, height: 1.4)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),
                  _sectionDivider(),
                  const SizedBox(height: 20),

                  // Steps
                  _sectionTitle('👨‍🍳 Steps'),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            margin: const EdgeInsets.only(right: 12, top: 2),
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFA53F),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(entry.value,
                                style: const TextStyle(
                                    fontSize: 15, height: 1.5)),
                          ),
                        ],
                      ),
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

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );

  Widget _sectionDivider() => Container(
        height: 1,
        color: Colors.orange.withOpacity(0.2),
      );
}