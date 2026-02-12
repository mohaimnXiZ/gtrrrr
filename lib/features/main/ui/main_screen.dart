import 'package:flutter/material.dart';
import 'package:gtr/features/favorite/ui/favorite_screen.dart';
import 'package:gtr/features/home/ui/home_screen.dart';
import 'package:gtr/features/profile/ui/profile_screen.dart';
import 'package:gtr/features/search/ui/search_screen.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/app_constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  final PageController _pageController = PageController();
  int _pageIndex = 0;
  final double kRailBreakpoint = 900;

  /// Triggered when the user taps a Nav item
  void _onNavTap(int index) {
    if (_pageIndex == index) return;

    setState(() {
      _pageIndex = index;
    });

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }

  /// Triggered when the PageView scrolls (manually or via animation)
  void _onPageChanged(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavItems() => const [
    BottomNavigationBarItem(icon: Icon(Iconsax.home), activeIcon: Icon(Iconsax.home_15), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Iconsax.heart), activeIcon: Icon(Iconsax.heart5), label: "Fav"),
    BottomNavigationBarItem(icon: Icon(Iconsax.search_normal), label: "Search"),
    BottomNavigationBarItem(icon: Icon(Iconsax.frame_1), activeIcon: Icon(Iconsax.frame5), label: "Profile"),
  ];

  List<NavigationRailDestination> _railDestinations() => const [
    NavigationRailDestination(icon: Icon(Iconsax.home), selectedIcon: Icon(Iconsax.home_15), label: Text("Home")),
    NavigationRailDestination(icon: Icon(Iconsax.heart), selectedIcon: Icon(Iconsax.heart5), label: Text("Fav")),
    NavigationRailDestination(icon: Icon(Iconsax.search_normal), label: Text("Search")),
    NavigationRailDestination(icon: Icon(Iconsax.frame_1), selectedIcon: Icon(Iconsax.frame5), label: Text("Profile")),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool showRail = constraints.maxWidth >= kRailBreakpoint;

        return Scaffold(
          body: Row(
            children: [
              if (showRail) _buildNavigationRail(context),
              Expanded(
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      children: _screens,
                    ),
                    if (!showRail) _buildBottomNav(context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Positioned(
      bottom: 16, // Increased slightly for better visual balance
      left: 24,
      right: 24,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(100),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 20,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Theme(
              data: Theme.of(context).copyWith(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                currentIndex: _pageIndex,
                onTap: _onNavTap,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Theme.of(context).colorScheme.onSurface,
                selectedLabelStyle: const TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.normal),
                items: _bottomNavItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRail(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
      ),
      child: NavigationRail(
        selectedIndex: _pageIndex,
        onDestinationSelected: _onNavTap,
        labelType: NavigationRailLabelType.all,
        backgroundColor: Theme.of(context).colorScheme.surface,
        indicatorColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor, size: 26),
        unselectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onSurface, size: 24),
        selectedLabelTextStyle: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        unselectedLabelTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        destinations: _railDestinations(),
      ),
    );
  }
}