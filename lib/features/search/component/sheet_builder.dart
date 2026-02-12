import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtr/features/search/component/selection_chip.dart';

import '../../../core/widgets/local_image.dart';
import 'search_sheet_grid.dart';
import '../../../core/widgets/text.dart';
import 'custom_radio_row.dart';

class SheetBuilder {
  final BuildContext context;
  final Function setState;

  SheetBuilder({required this.context, required this.setState});

  Widget _buildCommonHeader() {
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 8, bottom: 16),
      child: Container(
        width: 44,
        height: 3,
        decoration: BoxDecoration(color: const Color(0xFFDFDFDF), borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  // Helper for the drag handle and header logic
  _buildSecondarySheetHeader(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomText(text: "Filter", fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  behavior: HitTestBehavior.opaque,
                  child: LocalImage(img: "return", type: "svg", size: 24),
                ),
                GestureDetector(
                  onTap: () {
                    context.pop('cancel');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10), // Matching vertical tap target
                    child: CustomText(
                      text: "cancel",
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// --- BRANDS SHEET ---
  Widget buildBrands({
    required StateSetter setModalState,
    required List<String> selectedBrands,
    required Function(List<String>) onUpdate,
  }) {
    final List<String> brands = [
      "Rolls Royce",
      "Ferrari",
      "Lamborghini",
      "Maybach",
      "Mercedes",
      "Audi",
      "Tesla",
      "BMW",
      "Aston Martin",
      "Volkswagen",
      "Mitsubishi",
      "Ford",
      "Hyundai",
      "Nissan",
    ];

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            _buildCommonHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildSecondarySheetHeader(context),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 12, bottom: 16, left: 24, right: 24),
              child: Divider(thickness: 1, color: Theme.of(context).dividerColor),
            ),
            Expanded(
              child: ListView(
                children: brands.map((brand) {
                  return CustomRadioRow(
                    label: brand,
                    value: brand,
                    selectedValues: selectedBrands,
                    onChanged: (v) {
                      setModalState(() => onUpdate(v));
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- MODELS SHEET ---
  Widget buildModels({
    required StateSetter setModalState,
    required List<String> selectedModels,
    required Function(List<String>) onUpdate,
  }) {
    final List<String> models = ["A220", "Huracan EVO", "Ghost", "Rang Rover SVR"];

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            _buildCommonHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildSecondarySheetHeader(context),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 12, bottom: 16, left: 24, right: 24),
              child: Divider(thickness: 1, color: Theme.of(context).dividerColor),
            ),
            Expanded(
              child: ListView(
                children: models.map((model) {
                  return CustomRadioRow(
                    label: model,
                    value: model,
                    selectedValues: selectedModels,
                    onChanged: (v) {
                      setModalState(() => onUpdate(v));
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- YEARS SHEET ---
  Widget buildYears({
    required StateSetter setModalState,
    required String? selectedMinYear,
    required String? selectedMaxYear,
    required Function(String) onMinUpdate,
    required Function(String) onMaxUpdate,
  }) {
    final List<String> searchYears = [
      "2016", "2017", "2018", "2019", "2020", "2021", "2022", "2023", "2024", "2025", "2026",
    ];
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCommonHeader(),
              _buildSecondarySheetHeader(context),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 12, bottom: 16, left: 12, right: 12),
                child: Divider(thickness: 1, color: Theme.of(context).dividerColor),
              ),

              // 1. Use Expanded here to fill the rest of the sheet
              Expanded(
                // 2. Add a SingleChildScrollView so the whole section scrolls together
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("min year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),

                      // 3. Removed Expanded around ResponsiveGrid
                      SearchSheetGrid(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchYears.length,
                        itemBuilder: (ctx, index) => SelectionChip(
                          label: searchYears[index],
                          isSelected: selectedMinYear == searchYears[index],
                          onSelected: (v) {
                            setModalState(() => onMinUpdate(searchYears[index]));
                            setState(() {});
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                        child: Divider(color: Theme.of(context).dividerColor),
                      ),

                      const Text("Max year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      SizedBox(height: 8),

                      // 4. Removed Expanded around the second ResponsiveGrid
                      SearchSheetGrid(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchYears.length,
                        itemBuilder: (ctx, index) => SelectionChip(
                          label: searchYears[index],
                          isSelected: selectedMaxYear == searchYears[index],
                          onSelected: (v) {
                            setModalState(() => onMaxUpdate(searchYears[index]));
                            setState(() {});
                          },
                        ),
                      ),

                      // Add bottom padding for better scrolling experience
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- VEHICLE TYPES SHEET ---
  Widget buildTypes({
    required StateSetter setModalState,
    required List<String> selectedTypes,
    required Function(List<String>) onUpdate,
  }) {
    final List<String> types = ["Sedan", "SUV", "Sports", "Economic", "Luxury", "7 seater", "Muscle"];

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Column(
          children: [
            _buildCommonHeader(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _buildSecondarySheetHeader(context),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 12, bottom: 16, left: 24, right: 24),
              child: Divider(thickness: 1, color: Theme.of(context).dividerColor),
            ),
            Expanded(
              child: ListView(
                children: types.map((type) {
                  return CustomRadioRow(
                    label: type,
                    value: type,
                    selectedValues: selectedTypes,
                    onChanged: (v) {
                      setModalState(() => onUpdate(v));
                      setState(() {});
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// --- CAR COLORS SHEET ---
  Widget buildColors({
    required StateSetter setModalState,
    required String? selectedExteriorColor,
    required String? selectedInteriorColor,
    required Function(String) onExteriorUpdate,
    required Function(String) onInteriorUpdate,
  }) {
    final List<String> searchColors = [
      "White", "Black", "Grey", "Silver", "Gold", "Yellow", "Orange", "Brown", "Red", "Blue", "Purple", "Green",
    ];
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCommonHeader(),
              _buildSecondarySheetHeader(context),
              Padding(
                padding: EdgeInsetsGeometry.only(top: 12, bottom: 16, left: 12, right: 12),
                child: Divider(thickness: 1, color: Theme.of(context).dividerColor),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Exterior Color",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      SearchSheetGrid(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchColors.length,
                        itemBuilder: (ctx, index) => SelectionChip(
                          label: searchColors[index],
                          withColor: true,
                          isSelected: selectedExteriorColor == searchColors[index],
                          onSelected: (v) {
                            setModalState(() => onExteriorUpdate(searchColors[index]));
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
                        child: Divider(color: Theme.of(context).dividerColor),
                      ),
                      const Text(
                        "Interior Color",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      SearchSheetGrid(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: searchColors.length,
                        itemBuilder: (ctx, index) => SelectionChip(
                          label: searchColors[index],
                          withColor: true,
                          isSelected: selectedInteriorColor == searchColors[index],
                          onSelected: (v) {
                            setModalState(() => onInteriorUpdate(searchColors[index]));
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
