import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/icon.dart';
import 'package:gtr/core/widgets/icon_button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/responsive_grid.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:gtr/features/home/component/product_card.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> carData = [
    {
      'carName':
          'Teaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasla Model 3',
      'carImage': 'car8',
      'carLogo': 'car-logo',
      'dailyPrice': '\$95',
      'monthlyPrice': '\$2,400',
      'tags': ['Electric', 'Autopilot', 'Premium Audio'],
      'oldPrice': "false",
    },
    {
      'carName': 'Range Rover Sport',
      'carImage': 'car7',
      'carLogo': 'car-logo',
      'dailyPrice': '\$250',
      'monthlyPrice': '\$6,200',
      'tags': ['Luxury', '4x4', 'Sunroof'],
      'oldPrice': "false",
    },
    {
      'carName': 'Toyota Camry',
      'carImage': 'car6',
      'carLogo': 'car-logo',
      'dailyPrice': '\$45',
      'monthlyPrice': '\$1,100',
      'tags': ['Economic', 'Reliable', 'Hybrid'],
      'oldPrice': "5000",
    },
    {
      'carName':
          'Poraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaasche 911 Carrera',
      'carImage': 'car7',
      'carLogo': 'car-logo',
      'dailyPrice': '\$450',
      'monthlyPrice': '\$11,000',
      'tags': ['Sport', 'Turbo', 'Exotic'],
      'oldPrice': "false",
    },
    {
      'carName': 'Mercedes-Benz G-Wagon',
      'carImage': 'car8',
      'carLogo': 'car-logo',
      'dailyPrice': '\$60aaaaaaaaaaaaaaaaaaaaaaaaaaaa0',
      'monthlyPrice': '\$15,5aaaaa00',
      'tags': ['Prestige', 'V8', 'Iconic'],
      'oldPrice': "false",
    },
    {
      'carName': 'BMW 5 Series',
      'carImage': 'car7',
      'carLogo': 'car-logo',
      'dailyPrice': '\$110',
      'monthlyPrice': '\$2,900',
      'tags': ['Business', 'Leather', 'Smooth'],
      'oldPrice': "200aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0",
    },
    {
      'carName': 'Ford Mustang GT',
      'carImage': 'car6',
      'carLogo': 'car-logo',
      'dailyPrice': '\$130',
      'monthlyPrice': '\$3,200',
      'tags': [
        'Muscle',
        'V8',
        'Fast',
        'memememe',
        "meme",
        'memememememe',
        'mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm',
        'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk',
        'lllllllllllllllllllllllllllllllllllllllllllllll',
        "oooooooooooooooooooooooooooooooooooooooooooooooooooooooooo",
        'lllllllllllllllllllllllllllllllllllllllllllllllllll',
      ],
      'oldPrice': "2000000000000000000000000000000000000000000000000000000000000000",
    },
    {
      'carName': 'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaudi Q7',
      'carImage': 'car8',
      'carLogo': 'car-logo',
      'dailyPrice':
          '\$16aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0',
      'monthlyPrice':
          '\$4,1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00',
      'tags': [
        'Famaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaily',
        '7-Seaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaater',
        'Quaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaattro',
      ],
      'oldPrice': "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    },
    {
      'carName': 'Jeep Wrangler',
      'carImage': 'car7',
      'carLogo': 'car-logo',
      'dailyPrice': '\$85',
      'monthlyPrice': '\$2,100',
      'tags': ['Adventure', 'Convertible', 'Offroad'],
      'oldPrice': "500",
    },
    {
      'carName': 'Hyundai Elantra',
      'carImage': 'car6',
      'carLogo': 'car-logo',
      'dailyPrice': '\$40',
      'monthlyPrice': '\$950',
      'tags': ['Compact', 'Budget', 'Fuel Efficient'],
      'oldPrice': "70",
    },
    {
      'carName': 'Nissan Patrol',
      'carImage': 'car6',
      'carLogo': 'car-logo',
      'dailyPrice': '\$180',
      'monthlyPrice': '\$4,800',
      'tags': ['Desert King', 'Spacious', 'Powerful'],
      'oldPrice': "false",
    },
    {
      'carName': 'Lexus ES 350',
      'carImage': 'car4',
      'carLogo': 'car-logo',
      'dailyPrice': '\$90',
      'monthlyPrice': '\$2,300',
      'tags': ['Comfort', 'Quiet', 'Premium'],
      'oldPrice': "false",
    },
  ];
  final GlobalKey _stationaryKey = GlobalKey();
  final GlobalKey _movingKey = GlobalKey();
  final TextEditingController _search = TextEditingController();
  double _stationaryHeight = 0;
  double _movingHeight = 0;
  bool _isMeasured = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderBox? sBox = _stationaryKey.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? mBox = _movingKey.currentContext?.findRenderObject() as RenderBox?;

      if (sBox != null && mBox != null) {
        setState(() {
          _stationaryHeight = sBox.size.height;
          _movingHeight = mBox.size.height;
          _isMeasured = true;
        });
      }
    });
  }

  Widget _buildStationaryPart() {
    return Container(
      key: _stationaryKey,
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(53),
                  child: CustomIcon(icon: Iconsax.location, color: Colors.white),
                ),
                SizedBox(width: 12),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Location", color: Colors.white),
                      CustomText(text: "🇦🇪  AED", fontWeight: FontWeight.w800, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white.withAlpha(53),
                  child: CustomIcon(icon: Iconsax.notification, color: Colors.white),
                ),
                SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    context.push('/profile');
                  },
                  child: LocalImage(img: "avatar", type: "png", size: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovingPart() {
    return Container(
      key: _movingKey,
      child: Column(
        children: [
          Padding(
            padding: screenPadding,
            child: CustomField(
              controller: _search,
              hintText: "Search",
              hintColor: Colors.white,
              textColor: Colors.white,
              borderColor: Colors.white,
              focusedBorderColor: Colors.white,
              cursorColor: Colors.white,
              borderRadius: 100,
              icon: "search",
              textInputAction: TextInputAction.search,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(10, (index) {
                final bool isLastItem = index == 9;
                return Padding(
                  padding: EdgeInsets.only(left: index == 0 ? 16 : 8, right: isLastItem ? 16 : 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      if (isLastItem) {
                        context.push('/all-categories');
                      } else {}
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 68,
                          height: 68,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(53),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: isLastItem
                              ? const Text(
                                  "All",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              : LocalImage(img: "car-logo", type: "svg", size: 36),
                        ),
                        const SizedBox(height: 8),
                        CustomText(text: isLastItem ? "View All" : "Mercedes", color: Colors.white),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;

    if (!_isMeasured) {
      return Scaffold(
        backgroundColor: themeColor,
        body: Offstage(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [_buildStationaryPart(), _buildMovingPart()],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: themeColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: SlidingAppBarDelegate(
                stationaryHeight: _stationaryHeight,
                movingHeight: _movingHeight,
                stationaryChild: _buildStationaryPart(),
                movingChild: _buildMovingPart(),
                statusBarHeight: MediaQuery.of(context).padding.top,
                backgroundColor: themeColor,
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ResponsiveGrid(
                      forHomeScreen: true,
                      itemCount: carData.length,
                      itemBuilder: (BuildContext context, index) {
                        final car = carData[index];
                        return ProductCard(
                          carName: car['carName'],
                          carImage: car['carImage'],
                          carLogo: car['carLogo'],
                          dailyPrice: car['dailyPrice'],
                          monthlyPrice: car['monthlyPrice'],
                          tags: List<String>.from(car['tags']),
                          onDetailsTap: () {},
                          onPhoneTap: () {},
                          onWhatsappTap: () {},
                          oldPrice: car['oldPrice'] == "false" ? null : car['oldPrice'],
                        );
                      },
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- DELEGATE ---

class SlidingAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double stationaryHeight;
  final double movingHeight;
  final Widget stationaryChild;
  final Widget movingChild;
  final double statusBarHeight;
  final Color backgroundColor;

  SlidingAppBarDelegate({
    required this.stationaryHeight,
    required this.movingHeight,
    required this.stationaryChild,
    required this.movingChild,
    required this.statusBarHeight,
    required this.backgroundColor,
  });

  @override
  double get minExtent => stationaryHeight + statusBarHeight;

  @override
  double get maxExtent => stationaryHeight + movingHeight + statusBarHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double movingPartY = stationaryHeight + statusBarHeight - shrinkOffset;

    return ClipRect(
      child: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            Positioned(top: movingPartY, left: 0, right: 0, child: movingChild),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                color: backgroundColor,
                child: stationaryChild,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SlidingAppBarDelegate oldDelegate) {
    return oldDelegate.stationaryHeight != stationaryHeight || oldDelegate.movingHeight != movingHeight;
  }
}
