import 'package:flutter/material.dart';
import 'recipe.dart';

/// A screen that displays favorite recipes as styled cards.
class FavoriteScreen extends StatefulWidget {
  final Map<String, bool> favorites;
  final void Function(String title) onToggleFavorite;
  final List<Map<String, dynamic>> recipes;

  const FavoriteScreen({
    super.key,
    required this.favorites,
    required this.onToggleFavorite,
    required this.recipes,
  });

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final favTitles = widget.favorites.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList(growable: false);

    final favRecipes = <Map<String, dynamic>>[];
    for (final t in favTitles) {
      final match = widget.recipes
          .cast<Map<String, dynamic>?>()
          .firstWhere((r) => r != null && r['title'] == t, orElse: () => null);
      if (match != null) favRecipes.add(match);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: const Color.fromARGB(255, 255, 238, 217),
        elevation: 0,
      ),
      body: favRecipes.isEmpty
          ? const Center(child: Text('No favorites yet.'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favRecipes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final r = favRecipes[index];
                final title = r['title'] as String? ?? 'Unknown';
                final imageUrl = r['imageUrl'] as String? ?? '';
                final desc = r['desc'] as String? ?? '';
                final duration = r['duration'] as String? ?? '';
                final ingredients = (r['ingredients'] is List)
                    ? List<String>.from(r['ingredients'])
                    : <String>[];
                final steps = (r['steps'] is List)
                    ? List<String>.from(r['steps'])
                    : <String>[];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RecipeDetailScreen(
                          title: title,
                          imageUrl: imageUrl,
                          description: desc,
                          duration: duration,
                          ingredients: ingredients,
                          steps: steps,
                          isFavorite: widget.favorites[title] == true,
                          onFavoriteToggle: () {
                            widget.onToggleFavorite(title);
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: imageUrl.isNotEmpty
                                  ? Image.asset(
                                      imageUrl,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        height: 180,
                                        color: Colors.grey[300],
                                        child: const Icon(Icons.broken_image, size: 48),
                                      ),
                                    )
                                  : Container(
                                      height: 180,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.broken_image, size: 48),
                                    ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    widget.favorites[title] == true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: widget.favorites[title] == true
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                  onPressed: () {
                                    widget.onToggleFavorite(title);
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (duration.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  duration,
                                  style: TextStyle(
                                      color: Colors.deepOrange.shade800,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        if (desc.isNotEmpty)
                          Text(
                            desc,
                            style: const TextStyle(color: Colors.grey),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}