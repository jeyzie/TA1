import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'favorites_provider.dart';
import 'recipe.dart';
import 'favorite.dart';

// ─── All Recipes Data ─────────────────────────────────────────────────────────
final List<Map<String, dynamic>> allRecipes = [
  {
    'title': 'Pork Adobo',
    'imageUrl': 'assets/images/Pork-Adobo.jpg',
    'desc': 'Classic Filipino pork stewed in soy sauce, vinegar, garlic, and spices.',
    'duration': '17 minutes',
    'category': 'Pork',
    'ingredients': [
      '2 lbs. pork shoulder cubed', '4 bay leaves', '½ cup soy sauce',
      '½ cup white vinegar', '7 ½ ounces lemon lime soda',
      '2 tablespoons oyster sauce', '2 teaspoons peppercorn crushed',
      '2 heads garlic', '1 onion', '¼ cup cooking oil',
    ],
    'steps': [
      'Slice the garlic into thin pieces. Set aside.',
      'Start making the garlic chips by heating the cooking oil in pan. Add all the garlic. Continue cooking using low heat while stirring occasionally until the garlic turns golden brown and crispy.',
      'Separate the oil from the garlic. Set aside.',
      'Pour 3 tablespoons of garlic-infused oil on the same pan. Sauté the onion until it starts to caramelize.',
      'Add pork. Cook until the outer part turns medium brown in color.',
      'Add soy sauce, white vinegar, oyster sauce, lemon lime soda, and water. Let boil.',
      'Add cracked peppercorn, bay leaves, and half of the garlic chips. Cover the pan and continue cooking in low heat for 1 hour or until the pork gets tender.',
      'Remove the cover of the pan. Continue cooking until the sauce completely evaporates.',
      'Transfer to a serving plate. Serve with warm rice.',
      'Garnish with chopped parsley and remaining garlic chips.',
      'Share and enjoy!',
    ],
  },
  {
    'title': 'Air Fryer Tilapia',
    'imageUrl': 'assets/images/Fried tilapia with lemons.jpg',
    'desc': 'Crispy fried tilapia, golden and crunchy outside, juicy inside.',
    'duration': '20 minutes',
    'category': 'Fish',
    'ingredients': [
      'Tilapia fillets', 'Olive oil', 'Paprika', 'Garlic powder',
      'Onion powder', 'Salt', 'Ground black pepper', 'Lemon wedges',
    ],
    'steps': [
      'Pat the fillets dry on both sides with paper towels.',
      'Mix the paprika, garlic powder, onion powder, salt, and pepper in a small bowl.',
      'Brush olive oil on both sides of each fillet.',
      'Rub the spice mix all over. Get the sides too.',
      'Preheat air fryer to 400°F.',
      'Lay the fillets in the basket in a single layer, no overlapping.',
      'Cook 7 to 10 minutes. Check at 7. Fish should flake easily with a fork.',
      'Squeeze lemon on top and serve with rice.',
    ],
  },
  {
    'title': 'Ginataang Bangus',
    'imageUrl': 'assets/images/how-to-cook-ginataang-bangus.jpg',
    'desc': 'Crispy boneless bangus in creamy coconut milk sauce with garlic, ginger, chili, and string beans.',
    'duration': '20 minutes',
    'category': 'Fish',
    'ingredients': [
      'Bangus (boneless)', 'Maggi Magic Sarap', 'All purpose flour',
      'Coconut milk', 'String beans', 'Thai chili peppers', 'Onion',
      'Ginger', 'Garlic', 'Shrimp paste', 'Cooking oil',
      'Fish sauce', 'Ground black pepper',
    ],
    'steps': [
      'Season the boneless bangus pieces with Maggi Magic Sarap.',
      'Dredge each piece of fish in all purpose flour.',
      'Heat the cooking oil and fry the bangus until both sides turn light to medium brown.',
      'Remove the fried fish and set aside.',
      'Stir fry the string beans for about 90 seconds. Remove and set aside.',
      'Saute the garlic until it starts to brown.',
      'Add the onion and ginger, then continue cooking until the onion softens.',
      'Stir in the shrimp paste and Thai chili peppers.',
      'Pour in the coconut milk and bring to a gentle boil.',
      'Gently place the fried bangus and string beans into the sauce.',
      'Lower the heat and simmer for about 5 minutes.',
      'Season with fish sauce and ground black pepper. Serve hot with rice.',
    ],
  },
  {
    'title': 'Creamy Garlic Parmesan Chicken Pasta',
    'imageUrl': 'assets/images/creamy garlic.jpg',
    'desc': 'Rich and creamy pasta with golden chicken, garlic, and parmesan cheese.',
    'duration': '30 minutes',
    'category': 'Chicken',
    'ingredients': [
      '300 g pasta (fettuccine or penne)', '400 g chicken breast, sliced',
      '4 cloves garlic, minced', '1 cup heavy cream',
      '½ cup parmesan cheese, grated', '1 cup chicken broth',
      '2 tbsp butter', 'Salt and pepper to taste', 'Fresh parsley for garnish',
    ],
    'steps': [
      'Cook pasta according to package instructions. Drain and set aside.',
      'Season chicken with salt and pepper. Sauté in butter until golden and cooked through.',
      'Add garlic and cook 1 minute until fragrant.',
      'Pour in chicken broth and cream. Simmer 5 minutes.',
      'Stir in parmesan until sauce thickens.',
      'Add cooked pasta. Toss to coat. Garnish with parsley.',
    ],
  },
  {
    'title': 'Chicken Adobo',
    'imageUrl': 'assets/images/Easy-Chicken-Adobo-Recipe.jpg',
    'desc': 'A straightforward adobong manok cooked in soy sauce, vinegar, and spices.',
    'duration': '15 minutes',
    'category': 'Chicken',
    'ingredients': [
      '2 lbs. Chicken cut into serving pieces', '1 piece Knorr Chicken Cube',
      '1 head garlic, crushed', '1 piece onion, chopped',
      '6 pieces dried bay leaves', '1 tablespoon whole peppercorn',
      '½ cup soy sauce', '5 tablespoons white vinegar',
      '1 ½ tablespoons dark brown sugar', '2 cups water',
      '3 tablespoons cooking oil', 'Salt to taste',
    ],
    'steps': [
      'Heat oil in a cooking pot. Saute garlic and onion until the garlic turns light brown.',
      'Add chicken pieces. Cook until the chicken turns light brown.',
      'Pour water, soy sauce, and vinegar. Let boil.',
      'Add Knorr Chicken Cube, whole peppercorn, and dried bay leaves. Cover and cook for 15 minutes.',
      'Turn the chicken pieces over. Cover and continue to cook for another 15 minutes.',
      'Add dark brown sugar and season with salt.',
      'Transfer to a serving bowl. Serve and enjoy!',
    ],
  },
  {
    'title': 'Pork Sinigang',
    'imageUrl': 'assets/images/sinigang-baboy-7.jpg',
    'desc': 'A beloved Filipino sour tamarind soup with tender pork belly and fresh vegetables.',
    'duration': '30 minutes',
    'category': 'Pork',
    'ingredients': [
      '2 lbs. Pork belly, cubed',
      '66 g. Knorr Sinigang sa Sampaloc Mix with Gabi',
      '2 pieces eggplant, sliced', '8 pieces okra',
      '18 pieces string beans', '5 ounces daikon radish, sliced',
      '1 bunch kangkong', '1 piece onion, wedged',
      '2 pieces tomato, wedged', '6 pieces shishito pepper',
      '8 cups water', 'Fish sauce and ground black pepper to taste',
      '3 tablespoons cooking oil',
    ],
    'steps': [
      'Heat oil in a cooking pot. Saute onion until layers separate. Add half of the tomato.',
      'Add pork belly. Brown while adding around 1 tablespoon fish sauce.',
      'Pour water. Cover the pot and let the liquid boil.',
      'Add Knorr Sinigang sa Sampaloc with Gabi. Cook for 30 minutes until pork is tender.',
      'Add radish. Cover and continue cooking for 10 minutes.',
      'Add eggplant, string beans, and okra. Cook for 5 minutes.',
      'Add kangkong stalks and remaining tomato. Cook for 3 minutes.',
      'Season with fish sauce and ground black pepper.',
    ],
  },
  {
    'title': 'Pulutan Style Beef Caldereta',
    'imageUrl': 'assets/images/beef-caldereta.jpg',
    'desc': 'A rich Filipino beef stew with tender neck bones, peanut butter, and bell peppers.',
    'duration': '23 minutes',
    'category': 'Beef',
    'ingredients': [
      '4 lbs beef neck bone, chopped', '1 piece Knorr Beef Cube',
      '1 ½ tablespoons soy sauce', '2 cups water',
      '1 piece green bell pepper, sliced', '1 piece red bell pepper, sliced',
      '1 piece potato, cubed', '1 piece carrot, sliced',
      '8 ounces tomato sauce', '3 tablespoons peanut butter',
      '1 tablespoon liver spread', '5 pieces Thai chili pepper, chopped',
      '1 piece onion, chopped', '5 cloves garlic, crushed',
      'Salt and ground black pepper to taste', '3 tablespoons cooking oil',
    ],
    'steps': [
      'Heat oil in a cooking pot. Saute onion and garlic until onion softens.',
      'Add beef. Saute until the outer part turns light brown.',
      'Add soy sauce. Pour tomato sauce and water. Let boil.',
      'Add Knorr Beef Cube. Cover and cook for 30 minutes.',
      'Pan-fry carrot and potato until browned. Set aside.',
      'Add chili pepper, liver spread, and peanut butter. Stir.',
      'Add bell peppers, fried potato, and carrot. Cover and cook for 5 to 7 minutes.',
      'Season with salt and ground black pepper. Serve.',
    ],
  },
  {
    'title': 'Sizzling Tofu Sisig',
    'imageUrl': 'assets/images/tofu sisig.jpg',
    'desc': 'All the bold flavors of classic sisig — in a sizzling, crispy tofu version!',
    'duration': '20 minutes',
    'category': 'Vegetable',
    'ingredients': [
      '19 oz firm tofu', '1 red onion, chopped',
      '2 tablespoons red bell pepper, chopped',
      '2 tablespoons liver spread',
      '½ cup green onion, chopped', '¼ cup cooking oil',
    ],
    'steps': [
      'Squeeze the liquid out of the tofu by pressing against a flat surface.',
      'Freeze overnight in a resealable bag. Thaw and press again to remove remaining liquid.',
      'Heat the oil in a pan. Fry the tofu until golden brown and crispy on both sides.',
      'Remove from pan, let cool, then chop into small pieces.',
      'Saute onion until it softens. Add tofu and liver spread. Cook for 1 minute.',
      'Add the bell pepper and dressing mixture. Stir until all ingredients are coated.',
      'Heat a metal sizzling plate and add butter. Transfer the tofu sisig onto the plate.',
      'Serve as an appetizer or main dish. Enjoy!',
    ],
  },
];

// ─── HomeScreen ───────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _searchResults {
    final q = _searchQuery.toLowerCase();
    return allRecipes.where((r) {
      final title = (r['title'] as String).toLowerCase();
      final desc = (r['desc'] as String).toLowerCase();
      return title.contains(q) || desc.contains(q);
    }).toList();
  }

  List<Map<String, dynamic>> get _featuredFiltered {
    return allRecipes.skip(3).where((r) {
      final category = r['category'] as String;
      return _selectedCategory == 'All' || category == _selectedCategory;
    }).toList();
  }

  void _openRecipe(BuildContext context, Map<String, dynamic> r) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(
          title: r['title'],
          imageUrl: r['imageUrl'],
          description: r['desc'],
          duration: r['duration'],
          ingredients: List<String>.from(r['ingredients']),
          steps: List<String>.from(r['steps']),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('dd MMMM yyyy').format(DateTime.now());
    final isSearching = _searchQuery.isNotEmpty;
    final searchResults = _searchResults;

    // Read provider — this widget rebuilds whenever favorites change
    final favProvider = context.watch<FavoritesProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFEED),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/logo.png',
                width: 56,
                height: 56,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.restaurant_menu,
                  size: 56,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'RecipeBook App',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  today,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FavoriteScreen(recipes: allRecipes),
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // ── Header & Search ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What would you like\nto cook today?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search recipes...',
                      prefixIcon:
                          const Icon(Icons.search, color: Colors.grey),
                      suffixIcon: isSearching
                          ? IconButton(
                              icon: const Icon(Icons.close,
                                  color: Colors.grey),
                              onPressed: () => _searchController.clear(),
                            )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFFFFE3B7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ── SEARCH MODE ──────────────────────────────────────────────
          if (isSearching) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  searchResults.isEmpty
                      ? 'No results for "$_searchQuery"'
                      : '${searchResults.length} recipe${searchResults.length == 1 ? '' : 's'} found',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            if (searchResults.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.search_off,
                          size: 72, color: Colors.grey.shade300),
                      const SizedBox(height: 16),
                      Text('No recipes found',
                          style: TextStyle(
                              fontSize: 18, color: Colors.grey.shade400)),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final r = searchResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _RecipeListCard(
                          recipe: r,
                          isFavorite:
                              favProvider.isFavorite(r['title']),
                          onFavoriteToggle: () => context
                              .read<FavoritesProvider>()
                              .toggleFavorite(r['title']),
                          onTap: () => _openRecipe(context, r),
                        ),
                      );
                    },
                    childCount: searchResults.length,
                  ),
                ),
              ),
          ]

          // ── HOME MODE ────────────────────────────────────────────────
          else ...[
            // Popular Recipes
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('Popular Recipes',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 14),
                  itemCount: allRecipes.take(3).length,
                  itemBuilder: (context, index) {
                    final r = allRecipes[index];
                    return _PopularCard(
                      recipe: r,
                      isFavorite: favProvider.isFavorite(r['title']),
                      onFavoriteToggle: () => context
                          .read<FavoritesProvider>()
                          .toggleFavorite(r['title']),
                      onTap: () => _openRecipe(context, r),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Categories
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('Categories',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final cat in [
                      ('All', 'assets/icon/all.png'),
                      ('Pork', 'assets/icon/pork.png'),
                      ('Beef', 'assets/icon/beef.png'),
                      ('Chicken', 'assets/icon/chicken.png'),
                      ('Vegetable', 'assets/icon/vegetable.png'),
                      ('Fish', 'assets/icon/fish.png'),
                    ])
                      GestureDetector(
                        onTap: () => setState(
                            () => _selectedCategory = cat.$1),
                        child: _CategoryCircle(
                          imagePath: cat.$2,
                          label: cat.$1,
                          isSelected: _selectedCategory == cat.$1,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),

            // Featured Recipes
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text('Featured Recipes',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final r = _featuredFiltered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: _FeaturedCard(
                        recipe: r,
                        isFavorite:
                            favProvider.isFavorite(r['title']),
                        onFavoriteToggle: () => context
                            .read<FavoritesProvider>()
                            .toggleFavorite(r['title']),
                        onTap: () => _openRecipe(context, r),
                      ),
                    );
                  },
                  childCount: _featuredFiltered.length,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Popular Card ─────────────────────────────────────────────────────────────
class _PopularCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _PopularCard({
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    recipe['imageUrl'],
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 160,
                      height: 160,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              recipe['title'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Featured Card ────────────────────────────────────────────────────────────
class _FeaturedCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _FeaturedCard({
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
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
                    recipe['imageUrl'],
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 60),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.45),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
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
                        child: Text(recipe['title'],
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          recipe['duration'],
                          style: const TextStyle(
                            color: Color(0xFFFF3D03),
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(recipe['desc'],
                      style: const TextStyle(
                          color: Color(0xFFF57906), fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Search Result List Card ──────────────────────────────────────────────────
class _RecipeListCard extends StatelessWidget {
  final Map<String, dynamic> recipe;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onTap;

  const _RecipeListCard({
    required this.recipe,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: Image.asset(
                recipe['imageUrl'],
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 110,
                  height: 110,
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe['title'],
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(recipe['desc'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, color: Color(0xFFF57906))),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(recipe['duration'],
                        style: const TextStyle(
                          color: Color(0xFFFF3D03),
                          fontWeight: FontWeight.w600,
                          fontSize: 11,
                        )),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onFavoriteToggle,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey.shade400,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Category Circle ──────────────────────────────────────────────────────────
class _CategoryCircle extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  static const _activeColor = Color(0xFFFFA53F);

  const _CategoryCircle({
    required this.imagePath,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? _activeColor : Colors.transparent,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 29,
              backgroundColor:
                  isSelected ? _activeColor : _activeColor.withOpacity(0.1),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 46,
                  height: 46,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.image_not_supported,
                    color: isSelected ? Colors.white : _activeColor,
                    size: 28,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? _activeColor : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}