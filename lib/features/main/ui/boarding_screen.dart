import 'package:flutter/material.dart';
import 'package:gtr/core/utils/app_constants.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<String> images = ["car1", "car2", "car3"];
  final List<String> titles = [
    "Discover the Perfect Car\n for Every Journey",
    "Book Your Rental Easily in Just a Few\n Steps",
    "Pick Up Your Car and\n Start Driving",
  ];
  final List<String> descriptions = [
    "Explore a wide selection of vehicles designed\n to match your travel needs",
    "Choose your dates, location, and car with a smooth booking\n experience.",
    "Quick pickups, easy returns, and a hassle\n free rental process.",
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage < images.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [Expanded(child: _buildPageView())]),
      ),
      bottomNavigationBar: _buildBottomButtons(),
    );
  }

  Widget _buildPageView() {
    return PageView.builder(
      controller: _controller,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: screenPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeroImage(index),
              const SizedBox(height: 16),
              _buildPageIndicator(),
              const SizedBox(height: 8),
              _buildTextContent(index),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeroImage(int index) {
    return LocalImage(
      img: images[index],
      type: "png",
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      borderRadius: 24,
    );
  }

  Widget _buildPageIndicator() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: const Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(100)),
      child: SmoothPageIndicator(
        controller: _controller,
        count: images.length,
        effect: const WormEffect(dotHeight: 8, dotWidth: 8, spacing: 4),
      ),
    );
  }

  Widget _buildTextContent(int index) {
    return Column(
      children: [
        CustomText(text: titles[index], fontWeight: FontWeight.w800, fontSize: 18, maxLines: 2, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        CustomText(text: descriptions[index], color: Theme.of(context).hintColor, fontSize: 12, maxLines: 2, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildBottomButtons() {
    return SafeArea(
      child: Padding(
        padding: screenPadding.copyWith(bottom: 24),
        child: Row(
          children: [
            Flexible(
              child: CustomButton(
                onTap: () {},
                title: "Skip",
                color: const Color(0xFFF7F7F7),
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: CustomButton(onTap: _onNextPressed, title: "Next"),
            ),
          ],
        ),
      ),
    );
  }
}
