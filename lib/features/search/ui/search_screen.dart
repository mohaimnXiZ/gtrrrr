import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/core/widgets/button.dart';
import 'package:gtr/core/widgets/local_image.dart';
import 'package:gtr/core/widgets/responsive_grid.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/core/widgets/text_fields.dart';
import 'package:gtr/features/search/component/filter_tile.dart';
import 'package:gtr/features/search/component/search_product_card.dart';
import 'package:gtr/features/search/component/sheet_builder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late final sheetBuilder = SheetBuilder(context: context, setState: setState);
  List<String> _selectedBrands = [];
  List<String> _selectedModels = [];
  List<String> _selectedTypes = [];

  String _selectedMaxYear = "";
  String _selectedMinYear = "";

  String _selectedInteriorColor = "";
  String _selectedExteriorColor = "";

  List<Widget> cars = [
    SearchProductCard(
      carName: "Rollsqpoewipoqiepoqiwpoipoqwipoiqwpoiqpowiepoqwi Royce Ghost Series 2",
      carImage: "car6",
      price: "2300",
      hp: "55eqwoeiqpowiepoqwiepoiqwepoqwi0",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car7",
      price: "232300",
      hp: "1250",
      transmission: "autom llll atic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royc fddfdfdfd e Ghost Series 2",
      carImage: "car6",
      price: "230ssdsds0",
      hp: "55aaa0",
      transmission: "automatic",
      seatCount: "57",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName:
          "Rolls Royce Ghaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaost Series 2",
      carImage: "car6",
      price: "23sdsdssds00",
      hp: "5aaaaaaaa50",
      transmission: "automssssssssssssssssatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car8",
      price: "2300",
      hp: "550",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car7",
      price: "2300",
      hp: "550",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car6",
      price: "2300",
      hp: "550",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car8",
      price: "2300",
      hp: "550",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
    SearchProductCard(
      carName: "Rolls Royce Ghost Series 2",
      carImage: "car6",
      price: "2300",
      hp: "550",
      transmission: "automatic",
      seatCount: "4",
      onBookTap: () {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomField(
                            controller: _searchController,
                            borderRadius: 100,
                            borderColor: Theme.of(context).colorScheme.outline,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            prefixWidget: Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: LocalImage(
                                img: "search",
                                type: "svg",
                                fit: BoxFit.contain,
                                size: 18,
                                color: Colors.black,
                              ),
                            ),
                            hintText: "search",
                          ),
                        ),
                        const SizedBox(width: 18),
                        _buildFilterButton(context),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const LocalImage(img: "car-logo", type: "svg", size: 36),
                                  ),
                                  const SizedBox(height: 8),
                                  const CustomText(text: "Mercedes", fontSize: 12),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. The Product Grid
            // We use SliverPadding to manage side margins for the whole grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              sliver: SliverToBoxAdapter(
                child: ResponsiveGrid(
                  forSearchScreen: true,
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return cars[index];
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () => _handleSheetNavigation(context),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          border: Border.all(width: 1, color: Theme.of(context).colorScheme.outline),
        ),
        child: const LocalImage(img: "filter", type: "svg"),
      ),
    );
  }

  Widget _buildFilterSheet(StateSetter setModalState) {
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Container(
                      width: 44,
                      height: 3,
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildMainSheetHeader(context),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Divider(color: Theme.of(context).dividerColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRect(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  children: [
                    Column(
                      children: [
                        FilterTile(
                          title: "Brands",
                          subtitle: _selectedBrands.isNotEmpty ? _selectedBrands : ["No brands selected"],
                          onTap: () => context.pop('brands'),
                        ),
                        FilterTile(
                          title: "Models",
                          subtitle: _selectedModels.isNotEmpty ? _selectedModels : ["No modals selected"],
                          onTap: () => context.pop('models'),
                        ),
                        FilterTile(
                          title: "Model Year",
                          subtitle: [
                            _selectedMinYear != "" ? _selectedMinYear : "Not specified",
                            _selectedMaxYear != "" ? _selectedMaxYear : "Not specified",
                          ],
                          onTap: () => context.pop('years'),
                        ),
                        FilterTile(
                          title: "Vehicle Type",
                          subtitle: _selectedTypes.isNotEmpty ? _selectedTypes : ["No type selected"],
                          onTap: () => context.pop('types'),
                        ),
                        FilterTile(
                          title: "Car Colors",
                          subtitle: [
                            _selectedInteriorColor != "" ? _selectedInteriorColor : "Not specified",
                            _selectedExteriorColor != "" ? _selectedExteriorColor : "Not specified",
                          ],
                          onTap: () => context.pop('colors'),
                        ),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(text: "Price Range", fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "reset",
                      textColor: Theme.of(context).colorScheme.onSurface,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      onTap: () {
                        setModalState(() {
                          _selectedBrands.clear();
                          _selectedModels.clear();
                          _selectedMinYear = "";
                          _selectedMaxYear = "";
                          _selectedTypes.clear();
                          _selectedInteriorColor = "";
                          _selectedExteriorColor = "";
                        });
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(title: "Apply Filter", onTap: () => context.pop()),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildMainSheetHeader(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Opacity(opacity: 0, child: CustomText(text: "cancel", fontSize: 14)),
            const CustomText(text: "Filter", fontSize: 18, fontWeight: FontWeight.bold),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: CustomText(text: "cancel", fontSize: 14, color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
    );
  }

  // The main trigger function
  void _handleSheetNavigation(BuildContext context) async {
    final result = await _openSheet(
      context,
      StatefulBuilder(builder: (context, setModalState) => _buildFilterSheet(setModalState)),
    );

    // Define the sub-sheets and their logic
    final Map<String, Widget Function(StateSetter)> sheets = {
      'brands': (setSubState) => sheetBuilder.buildBrands(
        setModalState: setSubState,
        selectedBrands: _selectedBrands,
        onUpdate: (val) => _selectedBrands = val,
      ),
      'models': (setSubState) => sheetBuilder.buildModels(
        setModalState: setSubState,
        selectedModels: _selectedModels,
        onUpdate: (val) => _selectedModels = val,
      ),
      'years': (setSubState) => sheetBuilder.buildYears(
        setModalState: setSubState,
        selectedMinYear: _selectedMinYear,
        selectedMaxYear: _selectedMaxYear,
        onMinUpdate: (val) => _selectedMinYear = val,
        onMaxUpdate: (val) => _selectedMaxYear = val,
      ),
      'types': (setSubState) => sheetBuilder.buildTypes(
        setModalState: setSubState,
        selectedTypes: _selectedTypes,
        onUpdate: (val) => _selectedTypes = val,
      ),
      'colors': (setSubState) => sheetBuilder.buildColors(
        setModalState: setSubState,
        selectedExteriorColor: _selectedExteriorColor,
        selectedInteriorColor: _selectedInteriorColor,
        onExteriorUpdate: (val) => _selectedExteriorColor = val,
        onInteriorUpdate: (val) => _selectedInteriorColor = val,
      ),
    };

    if (sheets.containsKey(result)) {
      if (!context.mounted) return;

      final subResult = await _openSheet(
        context,
        StatefulBuilder(builder: (context, setModalState) => sheets[result]!(setModalState)),
      );
      if (context.mounted) {
        if (subResult == 'cancel') {
          context.pop();
        } else {
          _handleSheetNavigation(context);
        }
      }
    }
  }

  Future<String?> _openSheet(BuildContext context, Widget content) {
    final AnimationController customController = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
    );

    return showModalBottomSheet<String>(
      context: context,
      transitionAnimationController: customController,
      backgroundColor: Colors.white,
      elevation: 1,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => content,
    );
  }
}
