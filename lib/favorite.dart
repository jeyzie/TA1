import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';
import 'recipe.dart';
import 'home.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recipes;

  const FavoriteScreen({
    super.key,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    // Rebuilds whenever favorites change
    final favProvider = context.watch<FavoritesProvider>();
    final favRecipes = recipes
        .where((r) => favProvider.isFavorite(r['title'] as String))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: const Color(0xFFFFFEED),
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: favRecipes.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border,
                      size: 72, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text('No favorites yet',
                      style: TextStyle(
                          fontSize: 18, color: Colors.grey.shade400)),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the heart on any recipe to save it here',
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.shade400),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: favRecipes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final r = favRecipes[index];
                final title = r['title'] as String;
                final isFav = favProvider.isFavorite(title);

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RecipeDetailScreen(
                        title: title,
                        imageUrl: r['imageUrl'],
                        description: r['desc'],
                        duration: r['duration'],
                        ingredients: List<String>.from(r['ingredients']),
                        steps: List<String>.from(r['steps']),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
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
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.asset(
                                r['imageUrl'],
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 180,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.broken_image,
                                      size: 48),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: () => context
                                    .read<FavoritesProvider>()
                                    .toggleFavorite(title),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.45),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFav ? Colors.red : Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(title,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: Text(r['duration'],
                                        style: const TextStyle(
                                          color: Color(0xFFFF3D03),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(r['desc'],
                                  style: const TextStyle(
                                      color: Color(0xFFF57906),
                                      fontSize: 13)),
                            ],
                          ),
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