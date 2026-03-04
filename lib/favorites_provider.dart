import 'package:flutter/material.dart';

/// FavoritesProvider holds the favorites state for the entire app.
/// Any widget can read or update favorites without passing data manually
/// through constructors — this is the core benefit of Provider.
class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favorites = {};

  /// Returns true if the given recipe title is favorited
  bool isFavorite(String title) => _favorites.contains(title);

  /// Returns all currently favorited titles
  Set<String> get favorites => Set.unmodifiable(_favorites);

  /// Toggles the favorite status of a recipe
  void toggleFavorite(String title) {
    if (_favorites.contains(title)) {
      _favorites.remove(title);
    } else {
      _favorites.add(title);
    }
    // Tells all listening widgets to rebuild with the new state
    notifyListeners();
  }
}