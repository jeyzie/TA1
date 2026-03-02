import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'recipe.dart'; // ← adjust path if needed
import 'favorite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simple in-memory favorite tracking (using recipe title as key)
  final Map<String, bool> _favorites = {};
  String _searchQuery = '';
  String _selectedCategory = 'All';

  bool _isFavorite(String title) => _favorites[title] ?? false;

  void _toggleFavorite(String title) {
    setState(() {
      _favorites[title] = !(_favorites[title] ?? false);
    });
  }

  bool _matchesSearch(String title, String description) {
    if (_searchQuery.isEmpty) return true;
    final query = _searchQuery.toLowerCase();
    return title.toLowerCase().contains(query) ||
        description.toLowerCase().contains(query);
  }

  String _getCategory(String title) {
    final titleLower = title.toLowerCase();
    if (titleLower.contains('pork') || titleLower.contains('adobo')) return 'Pork';
    if (titleLower.contains('beef') || titleLower.contains('caldereta')) return 'Beef';
    if (titleLower.contains('chicken')) return 'Chicken';
    if (titleLower.contains('tofu') || titleLower.contains('vegetable')) return 'Vegetable';
    if (titleLower.contains('fish') || titleLower.contains('tilapia') || titleLower.contains('bangus')) return 'Fish';
    return 'All';
  }

  bool _matchesCategory(String title) {
    if (_selectedCategory == 'All') return true;
    return _getCategory(title) == _selectedCategory;
  }

  bool _matchesFilters(String title, String description) {
    return _matchesSearch(title, description) && _matchesCategory(title);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('dd MMMM yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 238, 217),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 238, 217),
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/logo.png',
                width: 60,
                height: 60,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.restaurant_menu,
                  size: 60,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  today,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
            onPressed: () {
              final allRecipes = [
                {'title': 'Pork Adobo', 'imageUrl': 'assets/images/Pork-Adobo.jpg', 'desc': 'Classic Filipino pork stewed in soy sauce, vinegar, garlic, and spices.', 'duration': '17 minutes', 'ingredients': ['2 lbs. pork shoulder cubed', '4 bay leaves', '½ cup soy sauce', '½ cup white vinegar', '7 ½ ounces lemon lime soda', '2 tablespoons oyster sauce', '2 teaspoons peppercorn crushed', '2 heads garlic', '1 onion', '¼ cup cooking oil'], 'steps': ['Slice the garlic into thin pieces. Set aside.', 'Start making the garlic chips by heating the cooking oil in pan. Add all the garlic. Continue cooking using low heat while stirring occasionally until the garlic turns golden brown and crispy.', 'Separate the oil from the garlic. Set aside.', 'Pour 3 tablespoons of garlic-infused oil on the same pan. Sauté the onion until it starts to caramelize.', 'Add pork. Cook until the outer part turns medium brown in color.', 'Add soy sauce, white vinegar, oyster sauce, lemon lime soda, and water. Let boil.', 'Add cracked peppercorn, bay leaves, and half of the garlic chips. Cover the pan and continue cooking in low heat for 1 hour or until the pork gets tender.', 'Remove the cover of the pan. Continue cooking until the sauce completely evaporates.', 'Transfer to a serving plate. Serve with warm rice.', 'Garnish with chopped parsley and remaining garlic chips.', 'Share and enjoy!']},
                {'title': 'Air Fryer Tilapia', 'imageUrl': 'assets/images/Fried tilapia with lemons.jpg', 'desc': 'Crispy fried tilapia, golden and crunchy outside, juicy inside.', 'duration': '20 minutes', 'ingredients': ['Tilapia fillets – Mild white fish', 'Olive oil – Just enough to coat', 'Paprika – Color and warmth', 'Garlic powder', 'Onion powder', 'Salt', 'Ground black pepper', 'Lemon wedges'], 'steps': ['Season the Tilapia.', 'Pat the fillets dry on both sides with paper towels', 'Mix the paprika, garlic powder, onion powder, salt, and pepper', 'Brush olive oil on both sides of each fillet', 'Rub the spice mix all over. Get the sides too', 'Preheat to 400°F', 'Lay the fillets in the basket. Single layer, no overlapping', 'Cook 7 to 10 minutes. Check at 7. Flake easily with a fork']},
                {'title': 'Ginataang Bangus', 'imageUrl': 'assets/images/how-to-cook-ginataang-bangus.jpg', 'desc': 'A flavorful dish of crispy boneless bangus in creamy coconut milk sauce with garlic, ginger, chili, and stir-fried string beans, served hot with rice.', 'duration': '20 minutes', 'ingredients': ['Bangus (boneless)', 'Maggi Magic Sarap', 'All purpose flour', 'Coconut milk', 'String beans', 'Thai chili peppers', 'Onion', 'Ginger', 'Garlic', 'Shrimp paste', 'Cooking oil', 'Fish sauce', 'Ground black pepper'], 'steps': ['Season the boneless bangus pieces with Maggi Magic Sarap', 'Dredge each piece of fish in all purpose flour', 'Heat the cooking oil and fry the bangus until both sides turn light to medium brown', 'Stir fry the string beans for about 90 seconds', 'Saute the garlic until it starts to brown', 'Add the onion and ginger, then continue cooking until the onion softens', 'Stir in the shrimp paste and Thai chili peppers', 'Pour in the coconut milk and bring everything to a gentle boil', 'Gently place the fried bangus and string beans into the coconut milk sauce', 'Lower the heat and simmer for about 5 minutes']},
                {'title': 'Creamy Garlic Parmesan Chicken Pasta', 'imageUrl': 'assets/images/creamy garlic.jpg', 'desc': 'Creamy pasta dishes like this have become one of my favorite meals to cook at home', 'duration': '30 minutes', 'ingredients': ['300 g pasta (fettuccine or penne)', '400 g chicken breast, sliced', '4 cloves garlic, minced', '1 cup heavy cream', '½ cup parmesan cheese, grated', '1 cup chicken broth', '2 tbsp butter', 'Salt and pepper to taste', 'Fresh parsley for garnish'], 'steps': ['Cook pasta according to package instructions. Drain and set aside.', 'Season chicken with salt and pepper. Sauté in butter until golden and cooked through.', 'Add garlic and cook 1 minute until fragrant.', 'Pour in chicken broth and cream. Simmer 5 minutes.', 'Stir in parmesan until sauce thickens.', 'Add cooked pasta. Toss to coat. Garnish with parsley.']},
                {'title': 'Chicken Adobo', 'imageUrl': 'assets/images/Easy-Chicken-Adobo-Recipe.jpg', 'desc': 'Easy Chicken Adobo is a straightforward adobong manok recipe...', 'duration': '15 minutes', 'ingredients': ['2 lbs. Chicken cut into serving pieces', '1 piece Knorr Chicken Cube', '1 head garlic, crushed', '1 piece onion, chopped', '6 pieces dried bay leaves', '1 tablespoon whole peppercorn', '½ cup soy sauce', '5 tablespoons white vinegar', '1 ½ tablespoons dark brown sugar', '2 cups water', '3 tablespoons cooking oil', 'Salt to taste'], 'steps': ['Heat oil in a cooking pot. Saute garlic and onion until the garlic turns light brown', 'Add chicken pieces. Cook until the chicken turns light brown', 'Pour water, soy sauce, and vinegar. Let boil', 'Add Knorr Chicken Cube, whole peppercorn, and dried bay leaves. Cover and cook for 15 minutes', 'Turn the chicken pieces over. Cover and continue to cook for another 15 minutes', 'Add dark brown sugar and season with salt', 'Transfer to a serving bowl. Serve. Share and enjoy!']},
                {'title': 'Pork Sinigang', 'imageUrl': 'assets/images/sinigang-baboy-7.jpg', 'desc': 'Pork sinigang is undoubtedly a favorite in many Filipino households...', 'duration': '30 minutes', 'ingredients': ['2 lbs. Pork belly, cubed', '66 g. Knorr Sinigang sa Sampaloc Mix with Gabi', '2 pieces talong, sliced', '8 pieces okra', '18 pieces string beans', '5 ounces daikon radish', '1 bunch kangkong', '1 piece onion, wedged', '2 pieces tomato, wedged', '6 pieces shishito pepper', '8 cups water', 'Fish sauce and ground black pepper to taste', '3 tablespoons cooking oil'], 'steps': ['Heat oil in a cooking pot. Saute onion until layers separate. Add half of the tomato', 'Add pork belly and brown while adding fish sauce', 'Pour water. Cover the pot and let the liquid boil', 'Add Knorr Sinigang sa Sampaloc with Gabi. Cook for 30 minutes', 'Add labanos. Cover and continue cooking for 30 minutes', 'Add eggplant, string beans, and okra. Cook for 5 minutes', 'Add kangkong stalks and remaining tomato. Cook for 3 minutes', 'Season with fish sauce and ground black pepper']},
                {'title': 'Pulutan Style Beef Caldereta', 'imageUrl': 'assets/images/beef-caldereta.jpg', 'desc': 'A rich and hearty Filipino-style beef stew featuring tender beef neck bones...', 'duration': '23 minutes', 'ingredients': ['4 lbs beef neck bone, chopped', '1 piece Knorr Beef Cube', '1 1/2 tablespoons soy sauce', '2 cups water', '1 piece green bell pepper, sliced', '1 piece red bell pepper, sliced', '1 piece potato, cubed', '1 piece carrot, sliced', '8 ounces tomato sauce', '3 tablespoons peanut butter', '1 tablespoon liver spread', '5 pieces Thai chili pepper, chopped', '1 piece onion, chopped', '5 cloves garlic, crushed', 'Salt and ground black pepper to taste', '3 tablespoons cooking oil'], 'steps': ['Heat oil in a cooking pot. Saute onion and garlic until onion softens', 'Add beef. Saute until the outer part turns light brown', 'Add soy sauce. Pour tomato sauce and water. Let boil', 'Add Knorr Beef Cube. Cover and cook for 30 minutes', 'Pan-fry carrot and potato until it browns. Set aside', 'Add chili pepper, liver spread, and peanut butter. Stir', 'Add bell peppers, fried potato, and carrot. Cover the pot. Continue cooking for 5 to 7 minutes', 'Season with salt and ground black pepper. Serve']},
                {'title': 'Sizzling Tofu Sisig', 'imageUrl': 'assets/images/tofu sisig.jpg', 'desc': 'Sisig lovers will be surprised to find that all the flavors they love in the classic dish can be found in this sizzling tofu sisig rendition!', 'duration': '20 minutes', 'ingredients': ['19 oz firm tofu', '1 red onion, chopped', '2 tablespoons red bell pepper, chopped', '2 tablespoons liver spread', '½ cup green onion, chopped', '¼ cup cooking oil'], 'steps': ['Prepare the tofu. Squeeze the liquid out by pressing against a flat surface', 'Freeze overnight in a resealable bag. Thaw and press again', 'Heat the oil in a pan. Fry the tofu until golden brown and crispy', 'Fry the opposite side. Remove and let cool. Chop into small pieces', 'Saute onion until it softens. Add tofu and liver spread. Cook for 1 minute', 'Add the bell pepper and dressing mixture. Stir until all ingredients are coated', 'Heat a metal plate and add butter. Transfer the tofu sisig into the plate', 'Serve as an appetizer or a main dish. Share and enjoy!']},
              ];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoriteScreen(
                    favorites: _favorites,
                    onToggleFavorite: _toggleFavorite,
                    recipes: allRecipes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'What would you like to cook today?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 227, 183),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Popular Recipes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (_matchesFilters('Pork Adobo',
                        'Classic Filipino pork stewed in soy sauce, vinegar, garlic, and spices.'))
                      Row(
                        children: [
                          _buildPopularCard(
                            context,
                            title: 'Pork Adobo',
                            imageUrl: 'assets/images/Pork-Adobo.jpg',
                            desc:
                                'Classic Filipino pork stewed in soy sauce, vinegar, garlic, and spices.',
                            duration: '17 minutes',
                            ingredients: [
                              '2 lbs. pork shoulder cubed',
                              '4 bay leaves',
                              '½ cup soy sauce',
                              '½ cup white vinegar',
                              '7 ½ ounces lemon lime soda',
                              '2 tablespoons oyster sauce',
                              '2 teaspoons peppercorn crushed',
                              '2 heads garlic',
                              '1 onion',
                              '¼ cup cooking oil'
                            ],
                            steps: [
                              'Slice the garlic into thin pieces. Set aside.',
                              'Start making the garlic chips by heating the cooking oil in pan. Add all the garlic. Continue cooking using low heat while stirring occasionally until the garlic turns golden brown and crispy.',
                              'Separate the oil from the garlic. Set aside. Note: the oil is now garlic infused and can be used to cook other dishes in the future.',
                              'Pour 3 tablespoons of garlic-infused oil on the same pan. Sauté the onion until it starts to caramelize.',
                              'Add pork. Cook until the outer part turns medium brown in color.',
                              'Add soy sauce, white vinegar, oyster sauce, lemon lime soda, and water. Let boil.',
                              'Add cracked peppercorn, bay leaves, and half of the garlic chips. Cover the pan and continue cooking in low heat for 1 hour or until the pork gets tender.',
                              'Remove the cover of the pan. Continue cooking until the sauce completely evaporates.',
                              'Transfer to a serving plate. Serve with warm rice.',
                              'Garnish with chopped parsley and remaining garlic chips.',
                              'Share and enjoy!',
                            ],
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    if (_matchesFilters('Air Fryer Tilapia',
                        'Crispy fried tilapia, golden and crunchy outside, juicy inside.'))
                      Row(
                        children: [
                          _buildPopularCard(
                            context,
                            title: 'Air Fryer Tilapia',
                            imageUrl: 'assets/images/Fried tilapia with lemons.jpg',
                            desc:
                                'Crispy fried tilapia, golden and crunchy outside, juicy inside.',
                            duration: '20 minutes',
                            ingredients: [
                              'Tilapia fillets – Mild white fish, works with any seasoning you throw at it.',
                              'Olive oil – Just enough to coat.',
                              'Paprika – Color and a little warmth.',
                              'Garlic powder – I prefer this over fresh garlic in the air fryer because fresh garlic burns at high heat.',
                              'Onion powder – Mild sweetness.',
                              'Salt – Do not skip it. Tilapia without salt tastes like nothing.',
                              'Ground black pepper – Just a bit.',
                              'Lemon wedges – Squeezed on right before you eat.',
                            ],
                            steps: [
                              'Season the Tilapia.',
                              'Pat the fillets dry on both sides with paper towels. I usually go through two or three towels per batch.',
                              'Mix the paprika, garlic powder, onion powder, salt, and pepper in a small bowl.',
                              'Brush olive oil on both sides of each fillet.',
                              'Rub the spice mix all over. Get the sides too, not just the flat surfaces.',
                              'Oil first, then spices. I have seen people do it the other way and wonder why the seasoning falls off.',
                              'Air Fry the Tilapia.',
                              'Preheat to 400°F. Two minutes is enough.',
                              'Lay the fillets in the basket. Single layer, no overlapping.',
                              'Cook 7 to 10 minutes. Check at 7. You want the fish to flake easily with a fork. Internal temp should hit 145°F.',
                              'Move them to a plate, squeeze lemon on top, and serve with rice.',
                              'I can fit three fillets in my basket. Four if I really squeeze them in, but then the ones in the middle do not cook right. Two batches is better.',
                            ],
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    if (_matchesFilters('Ginataang Bangus',
                        'A flavorful dish of crispy boneless bangus in creamy coconut milk sauce with garlic, ginger, chili, and stir-fried string beans, served hot with rice.'))
                      _buildPopularCard(
                        context,
                        title: 'Ginataang Bangus',
                        imageUrl: 'assets/images/how-to-cook-ginataang-bangus.jpg',
                        desc:
                            'A flavorful dish of crispy boneless bangus in creamy coconut milk sauce with garlic, ginger, chili, and stir-fried string beans, served hot with rice.',
                        duration: '20 minutes',
                        ingredients: [
                          'Bangus (boneless) – Milkfish is the main protein in this dish, and boneless cuts make preparation and eating easier.',
                          'Maggi Magic Sarap – An all purpose seasoning that enhances the natural flavor of the fish before frying.',
                          'All purpose flour – Creates a thin coating on the fish that holds up in the sauce.',
                          'Coconut milk – The rich, creamy base of the sauce.',
                          'String beans – Cut into short lengths and stir fried for a fresh, crunchy contrast.',
                          'Thai chili peppers – Bring a gentle heat that complements the coconut milk.',
                          'Onion – The sweet base of the aromatics.',
                          'Ginger – Gives warmth and helps cut through the richness of the coconut milk.',
                          'Garlic – The aromatic foundation of the sauce.',
                          'Shrimp paste – The source of deep, salty umami in this dish.',
                          'Cooking oil – Used for frying the fish and sauteing the aromatics.',
                          'Fish sauce – For final seasoning.',
                          'Ground black pepper – A finishing touch for subtle warmth.',
                        ],
                        steps: [
                          'Season and Fry the Bangus.',
                          'Season the boneless bangus pieces with Maggi Magic Sarap and set aside for a few minutes.',
                          'Dredge each piece of fish in all purpose flour, making sure it is evenly coated on all sides.',
                          'Heat the cooking oil in a pan over medium heat and fry the bangus until both sides turn light to medium brown.',
                          'Remove the fried fish from the pan and set aside on a plate.',
                          'Fry in batches so each piece has enough space to brown evenly. Crowding the pan will steam the fish instead of frying it.',
                          'Stir Fry the String Beans.',
                          'Using about 2 tablespoons of the oil left in the pan, stir fry the string beans for about 90 seconds.',
                          'Remove from the pan and set aside.',
                          'The string beans should still have a snap to them. They will continue cooking briefly once they go into the sauce.',
                          'Saute the Aromatics and Build the Sauce.',
                          'Add another 2 tablespoons of oil to the same pan and saute the garlic until it starts to brown.',
                          'Add the onion and ginger, then continue cooking until the onion softens.',
                          'Stir in the shrimp paste and Thai chili peppers, and saute for about 30 seconds.',
                          'Pour in the coconut milk and bring everything to a gentle boil.',
                          'Simmer and Serve.',
                          'Gently place the fried bangus and stir fried string beans into the coconut milk sauce.',
                          'Lower the heat and simmer for about 5 minutes, allowing the fish to absorb the flavors of the sauce.',
                          'Season with fish sauce and ground black pepper to taste.',
                          'Transfer to a serving plate and serve hot with steamed white rice.',
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'All'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/all.png',
                        label: 'All',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'All',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'Pork'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/pork.png',
                        label: 'Pork',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'Pork',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'Beef'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/beef.png',
                        label: 'Beef',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'Beef',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'Chicken'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/chicken.png',
                        label: 'Chicken',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'Chicken',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'Vegetable'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/vegetable.png',
                        label: 'Vegetable',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'Vegetable',
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedCategory = 'Fish'),
                      child: CategoryCircle(
                        imagepath: 'assets/icon/fish.png',
                        label: 'Fish',
                        color: const Color.fromARGB(255, 255, 165, 63),
                        isSelected: _selectedCategory == 'Fish',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Featured Recipes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Featured cards with favorite button - filtered by search
              if (_matchesFilters('Creamy Garlic Parmesan Chicken Pasta',
                  'Creamy pasta dishes like this have become one of my favorite meals to cook at home'))
                Column(
                  children: [
                    _buildFeaturedCard(
                      context,
                      title: 'Creamy Garlic Parmesan Chicken Pasta',
                      imageUrl: 'assets/images/creamy garlic.jpg',
                      desc:
                          'Creamy pasta dishes like this have become one of my favorite meals to cook at home',
                      duration: '30 minutes',
                      ingredients: [
                        '300 g pasta (fettuccine or penne)',
                        '400 g chicken breast, sliced',
                        '4 cloves garlic, minced',
                        '1 cup heavy cream',
                        '½ cup parmesan cheese, grated',
                        '1 cup chicken broth',
                        '2 tbsp butter',
                        'Salt and pepper to taste',
                        'Fresh parsley for garnish',
                      ],
                      steps: [
                        'Cook pasta according to package instructions. Drain and set aside.',
                        'Season chicken with salt and pepper. Sauté in butter until golden and cooked through.',
                        'Add garlic and cook 1 minute until fragrant.',
                        'Pour in chicken broth and cream. Simmer 5 minutes.',
                        'Stir in parmesan until sauce thickens.',
                        'Add cooked pasta. Toss to coat. Garnish with parsley.',
                      ],
                      isFavorite:
                          _isFavorite('Creamy Garlic Parmesan Chicken Pasta'),
                      onFavoriteToggle: () => _toggleFavorite(
                          'Creamy Garlic Parmesan Chicken Pasta'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              if (_matchesFilters('Chicken Adobo',
                  'Easy Chicken Adobo is a straightforward adobong manok recipe...'))
                Column(
                  children: [
                    _buildFeaturedCard(
                      context,
                      title: 'Chicken Adobo',
                      imageUrl: 'assets/images/Easy-Chicken-Adobo-Recipe.jpg',
                      desc:
                          'Easy Chicken Adobo is a straightforward adobong manok recipe...',
                      duration: '15 minutes',
                      ingredients: [
                        '2 lbs. Chicken cut into serving pieces.',
                        '1 piece Knorr Chicken Cube.',
                        '1 head garlic, crushed.',
                        '1 piece onion, chopped.',
                        '6 pieces dried bay leaves.',
                        '1 tablespoon whole peppercorn.',
                        '½ cup soy sauce.',
                        '5 tablespoons white vinegar.',
                        '1 ½ tablespoons dark brown sugar.',
                        '2 cups water.',
                        '3 tablespoons cooking oil.',
                        'Salt to taste.',
                      ],
                      steps: [
                        'Heat oil in a cooking pot. Saute garlic and onion until the garlic turns light brown and the onion softens.',
                        'Add chicken pieces. Cook until the chicken turns light brown.',
                        'Pour water, soy sauce, and vinegar. Let boil.',
                        'Add Knorr Chicken Cube, whole peppercorn, and dried bay leaves. Stir. Cover the pot and cook in medium heat for 15 minutes.',
                        'Turn the chicken pieces over. Cover and continue to cook for another 15 minutes.',
                        'Add dark brown sugar and season with salt.',
                        'Transfer to a serving bowl. Serve. Share and enjoy!',
                      ],
                      isFavorite: _isFavorite('Chicken Adobo'),
                      onFavoriteToggle: () => _toggleFavorite('Chicken Adobo'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              if (_matchesFilters('Pork Sinigang',
                  'Pork sinigang is undoubtedly a favorite in many Filipino households...'))
                Column(
                  children: [
                    _buildFeaturedCard(
                      context,
                      title: 'Pork Sinigang',
                      imageUrl: 'assets/images/sinigang-baboy-7.jpg',
                      desc:
                          'Pork sinigang is undoubtedly a favorite in many Filipino households...',
                      duration: '30 minutes',
                      ingredients: [
                        '2 lbs. Pork belly, cubed.',
                        '66 g. Knorr Sinigang sa Sampaloc Mix with Gabi.',
                        '2 pieces talong, sliced.',
                        '8 pieces okra.',
                        '18 pieces string beans, cut into 2-inch pieces.',
                        '5 ounces daikon radish (labanos), sliced.',
                        '1 bunch kangkong.',
                        '1 piece onion, wedged.',
                        '2 pieces tomato, wedged.',
                        '6 pieces shishito pepper.',
                        '8 cups water.',
                        'Fish sauce and ground black pepper to taste.',
                        '3 tablespoons cooking oil.',
                      ],
                      steps: [
                        'Heat oil in a cooking pot. Saute onion until layers separate. Add half of the tomato. Saute for 2 minutes.',
                        'Add pork belly. Continue sauteeing until the pork browns while adding around 1 tablespoon fish sauce.',
                        'Pour water. Cover the pot and let the liquid boil.',
                        'Add Knorr Sinigang sa Sampaloc with Gabi. Cover and adjust heat between low to medium. Cook for 30 minutes or until the pork gets tender.',
                        'Add labanos. Cover and continue cooking for 30 minutes.',
                        'Add eggplant, string beans, and okra. Cook for 5 minutes.',
                        'Add kangkong stalks and remaining tomato. Cook for 3 minutes.',
                        'Season with fish sauce (as needed) and ground black pepper.',
                      ],
                      isFavorite: _isFavorite('Pork Sinigang'),
                      onFavoriteToggle: () => _toggleFavorite('Pork Sinigang'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              if (_matchesFilters('Pulutan Style Beef Caldereta',
                  'A rich and hearty Filipino-style beef stew featuring tender beef neck bones...'))
                Column(
                  children: [
                    _buildFeaturedCard(
                      context,
                      title: 'Pulutan Style Beef Caldereta',
                      imageUrl: 'assets/images/beef-caldereta.jpg',
                      desc:
                          'A rich and hearty Filipino-style beef stew featuring tender beef neck bones...',
                      duration: '23 minutes',
                      ingredients: [
                        '4 lbs beef neck bone, chopped.',
                        '1 piece Knorr Beef Cube.',
                        '1 1/2 tablespoons soy sauce.',
                        '2 cups water.',
                        '1 piece green bell pepper, sliced.',
                        '1 piece red bell pepper, sliced.',
                        '1 piece potato, cubed.',
                        '1 piece carrot, sliced.',
                        '8 ounces tomato sauce.',
                        '3 tablespoons peanut butter.',
                        '1 tablespoon liver spread.',
                        '5 pieces Thai chili pepper, chopped.',
                        '1 piece onion, chopped.',
                        '5 cloves garlic, crushed.',
                        'Salt and ground black pepper to taste.',
                        '3 tablespoons cooking oil.',
                      ],
                      steps: [
                        'Heat oil in a cooking pot. Saute onion and garlic until onion softens.',
                        'Add beef. Saute until the outer part turns light brown.',
                        'Add soy sauce. Pour tomato sauce and water. Let boil.',
                        'Add Knorr Beef Cube. Cover the pressure cooker. Cook for 30 minutes.',
                        'Pan-fry carrot and potato until it browns. Set aside.',
                        'Add chili pepper, liver spread, and peanut butter. Stir.',
                        'Add bell peppers, fried potato, and carrot. Cover the pot. Continue cooking for 5 to 7 minutes.',
                        'Season with salt and ground black pepper. Serve.',
                      ],
                      isFavorite: _isFavorite('Pulutan Style Beef Caldereta'),
                      onFavoriteToggle: () =>
                          _toggleFavorite('Pulutan Style Beef Caldereta'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              if (_matchesFilters('Sizzling Tofu Sisig',
                  'Sisig lovers will be surprised to find that all the flavors they love in the classic dish can be found in this sizzling tofu sisig rendition!'))
                Column(
                  children: [
                    _buildFeaturedCard(
                      context,
                      title: 'Sizzling Tofu Sisig',
                      imageUrl: 'assets/images/tofu sisig.jpg',
                      desc:
                          'Sisig lovers will be surprised to find that all the flavors they love in the classic dish can be found in this sizzling tofu sisig rendition!',
                      duration: '20 minutes',
                      ingredients: [
                        '19 oz firm tofu.',
                        '1 red onion, chopped.',
                        '2 tablespoons red bell pepper, chopped.',
                        '2 tablespoons liver spread.',
                        '½ cup green onion, chopped.',
                        '¼ cup cooking oil.',
                      ],
                      steps: [
                        'Prepare the tofu. Squeeze the liquid out by pressing against a flat surface. Zip it inside a resealable bag and freeze overnight. Thaw the tofu and press again to remove the remaining liquid.',
                        'Heat the oil in a pan. Fry the tofu until golden brown and crispy. Do the same step on the opposite side. Remove tofu from the pan and let it cool down. Chop into small pieces.',
                        'Make the dressing by combining all the dressing ingredients in a bowl. Mix well. Set aside.',
                        'Saute onion until it softens. Add tofu and liver spread. Cook for 1 minute.',
                        'Add the bell pepper and dressing mixture. Stir until all ingredients are coated. Set aside.',
                        'Heat a metal plate (sizzling plate) and add butter. Transfer the tofu sisig into the metal plate.',
                        'Serve as an appetizer or a main dish. Share and enjoy!',
                      ],
                      isFavorite: _isFavorite('Sizzling Tofu Sisig'),
                      onFavoriteToggle: () => _toggleFavorite('Sizzling Tofu Sisig'),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopularCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required String desc,
    required String duration,
    required List<String> ingredients,
    required List<String> steps,
  }) {
    return InkWell(
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
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: PopularRecipeCard(
        imageUrl: imageUrl,
        title: title,
        isFavorite: _isFavorite(title),
        onFavoriteToggle: () => _toggleFavorite(title),
      ),
    );
  }

  Widget _buildFeaturedCard(
    BuildContext context, {
    required String title,
    required String imageUrl,
    required String desc,
    required String duration,
    required List<String> ingredients,
    required List<String> steps,
    required bool isFavorite,
    required VoidCallback onFavoriteToggle,
  }) {
    return InkWell(
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
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
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
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(  // ← changed to .asset (most of your images are local)
                    imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 60),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    duration,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 253, 61, 3),
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              desc,
              style: const TextStyle(color: Color.fromARGB(255, 245, 121, 6), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularRecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const PopularRecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imageUrl,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
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
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 20,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(title,
            style:
                const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      ],
    );
  }
}

class CategoryCircle extends StatelessWidget {
  final String imagepath;
  final String label;
  final Color color;
  final bool isSelected;

  const CategoryCircle({
    super.key,
    required this.imagepath,
    required this.label,
    required this.color,
    this.isSelected = false,
  });

@override
Widget build(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(right: 16), // ← reduced to 16 to avoid overflow
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: isSelected ? 3 : 0,
            ),
          ),
          child: Transform.scale(
            scale: isSelected ? 1.11 : 1.0, // slight zoom when selected
            child: CircleAvatar(
              radius: 29, // good size — adjust to 30 or 34 if needed
              backgroundColor: isSelected 
                  ? color // full color when selected
                  : color.withOpacity(0.08), // very light when not selected
              child: ClipOval(
                child: Image.asset(
                  imagepath,
                  width: 48,
                  height: 48,
                  fit: BoxFit.none, // ← best for icons (no cropping)
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      color: isSelected ? Colors.white : color,
                      size: 32,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? color : Colors.black87,
          ),
        ),
      ],
    ),
  );
}
}