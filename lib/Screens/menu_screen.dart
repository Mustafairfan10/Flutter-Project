import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../generated/l10n.dart'; // Import localization
import 'cart_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late VideoPlayerController _videoController;

  final List<String> carouselImages = [
    'https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/04/24/22/12/asparagus-2258013_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/12/05/food-2059852_1280.jpg',
  ];

  final List<Map<String, dynamic>> menuItems = [
    {
      'name': 'Pizza Margherita',
      'price': 8.5,
      'image':
          'https://cdn.pixabay.com/photo/2017/12/10/14/47/pizza-3010062_960_720.jpg',
    },
    {
      'name': 'Veggie Burger',
      'price': 6.0,
      'image':
          'https://cdn.pixabay.com/photo/2017/04/24/22/12/asparagus-2258013_960_720.jpg',
    },
    {
      'name': 'Pasta Carbonara',
      'price': 7.0,
      'image':
          'https://cdn.pixabay.com/photo/2017/02/12/12/05/food-2059852_1280.jpg',
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _videoController =
        VideoPlayerController.asset('assets/videos/foodbackground.mp4')
          ..initialize().then((_) {
            _videoController.setLooping(true);
            _videoController.setVolume(0);
            _videoController.play();
            setState(() {});
          });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void addToCart(Map<String, dynamic> item) {
    setState(() {
      cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} ${S.of(context).addedToCart}')),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartScreen(cart: cart)),
    ).then((_) {
      setState(() {}); // Refresh state on return
    });
  }

  Widget buildCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            itemCount: carouselImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  carouselImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(carouselImages.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              width: _currentPage == index ? 12 : 8,
              height: _currentPage == index ? 12 : 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.deepOrange : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = S.of(context); // get localization here

    return Scaffold(
      // Background video
      body: Stack(
        children: [
          _videoController.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                )
              : Container(color: Colors.black),
          Container(color: Colors.black.withOpacity(0.5)),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 12),
                buildCarousel(),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: menuItems.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final item = menuItems[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item['image'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            item['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            '\$${item['price'].toStringAsFixed(2)}',
                          ),
                          trailing: ElevatedButton(
                            onPressed: () => addToCart(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            child: Text(loc.add),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(loc.menu),
        backgroundColor: Colors.deepOrange,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: navigateToCart,
              ),
              if (cart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${cart.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
