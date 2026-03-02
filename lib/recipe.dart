import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const RecipeDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.duration,
    required this.ingredients,
    required this.steps,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  Widget _buildImage(String url) {
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return Image.network(
        url,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 250,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 60),
        ),
      );
    } else if (url.isNotEmpty) {
      return Image.asset(
        url,
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 250,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, size: 60),
        ),
      );
    } else {
      return Container(
        height: 250,
        color: Colors.grey[300],
        child: const Icon(Icons.broken_image, size: 60),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.redAccent,
            ),
            onPressed: onFavoriteToggle,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image - support both asset and network images
            _buildImage(imageUrl),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Short description
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 32),

                  // Ingredients
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...ingredients.map(
                    (ingredient) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        '• $ingredient',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Steps
                  const Text(
                    'Steps',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ...steps.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final step = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          '${index + 1}. $step',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

               
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}