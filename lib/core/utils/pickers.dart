import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';
import '../widgets/text_fields.dart';

void showTopNotification(
  BuildContext context,
  String message, {
  Duration displayDuration = const Duration(seconds: 2),
  Duration animationDuration = const Duration(milliseconds: 300),
}) {
  final overlay = Overlay.of(context, rootOverlay: true);
  final animationController = ValueNotifier<bool>(true);

  final entry = OverlayEntry(
    builder: (context) => ValueListenableBuilder<bool>(
      valueListenable: animationController,
      builder: (context, shouldShow, _) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: shouldShow ? -20 : 0, end: shouldShow ? 0 : -20),
          duration: animationDuration,
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Positioned(
              top: MediaQuery.of(context).padding.top + 16 + value,
              left: 16,
              right: 16,
              child: Opacity(opacity: (1 - (value.abs() / 20)).clamp(0.0, 1.0), child: child),
            );
          },
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomText(text: message, maxLines: 3, textAlign: TextAlign.start),
            ),
          ),
        );
      },
    ),
  );

  overlay.insert(entry);

  Future.delayed(displayDuration, () {
    animationController.value = false;

    Future.delayed(animationDuration, () {
      entry.remove();
      animationController.dispose();
    });
  });
}

Future<String?> showGovernoratePicker(BuildContext context, String? initialValue) async {
  final List<String> governorates = [
    "بغداد",
    "البصرة",
    "الموصل",
    "أربيل",
    "كركوك",
    "النجف",
    "كربلاء",
    "السليمانية",
    "ديالى",
    "بابل",
    "الأنبار",
    "ذي قار",
    "واسط",
    "ميسان",
    "المثنى",
    "القادسية",
    "دهوك",
    "صلاح الدين",
  ];

  String? selectedGovernorate = initialValue != null && initialValue.isNotEmpty ? initialValue : null;

  final TextEditingController search = TextEditingController();

  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SafeArea(
        child: StatefulBuilder(
          builder: (context, setModalState) {
            final filteredGovernorates = governorates.where((governorate) {
              final searchText = search.text.trim().toLowerCase();
              if (searchText.isEmpty) return true;
              return governorate.toLowerCase().contains(searchText);
            }).toList();

            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 12),
                  Center(
                    child: Container(
                      height: 9,
                      width: 92,
                      decoration: BoxDecoration(color: Color(0xFFEFF2F1), borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  SizedBox(height: 8),
                  CustomText(text: "المحافظة", fontWeight: FontWeight.w700, fontSize: 16),
                  SizedBox(height: 8),
                  Divider(color: Color(0xFFEFF2F1)),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CustomField(
                      controller: search,
                      showLabel: false,
                      hintText: "إبحث عن المحافظة",
                      icon: "map-colored",
                      onChanged: (_) => setModalState(() {}),
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomText(text: "إختر المحافظة", fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 12),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.5,
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: filteredGovernorates.isEmpty
                        ? Padding(
                            padding: EdgeInsets.all(32),
                            child: CustomText(text: "لا توجد نتائج", color: Theme.of(context).hintColor, textAlign: TextAlign.center),
                          )
                        : ListView.builder(
                            itemCount: filteredGovernorates.length,
                            itemBuilder: (context, index) {
                              final governorate = filteredGovernorates[index];
                              final isSelected = selectedGovernorate == governorate;

                              return InkWell(
                                onTap: () {
                                  setModalState(() {
                                    selectedGovernorate = governorate;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.easeInOutCubic,
                                  padding: EdgeInsets.all(16),
                                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Theme.of(context).hintColor.withAlpha(64)),
                                  ),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(milliseconds: 150),
                                        curve: Curves.easeInOutCubic,
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: isSelected ? Theme.of(context).primaryColor : const Color(0xFFF1F2F3),
                                          border: Border.all(width: isSelected ? 5 : 0, color: const Color(0xFFF1F2F3)),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      CustomText(
                                        text: governorate,
                                        fontSize: 16,
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                        color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomButton(
                      title: "تأكيد",
                      onTap: () {
                        if (selectedGovernorate == null) {
                          showTopNotification(context, "الرجاء إختيار محافظة");

                          return;
                        }
                        Navigator.pop(context, selectedGovernorate);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

Future<DateTime?> showBirthDatePicker(BuildContext context, {DateTime? initialDate, DateTime? minimumDate, DateTime? maximumDate}) async {
  DateTime? selectedDate;

  final DateTime resolvedInitialDate = initialDate ?? DateTime.now().subtract(const Duration(days: 365 * 25));

  return await showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return SafeArea(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Center(
                    child: Container(
                      height: 9,
                      width: 92,
                      decoration: BoxDecoration(color: const Color(0xFFEFF2F1), borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const CustomText(text: "تاريخ الميلاد", fontWeight: FontWeight.w700, fontSize: 16),
                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFFEFF2F1)),

                  SizedBox(
                    height: 216,
                    child: Localizations.override(
                      context: context,
                      locale: const Locale('en', 'US'),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: selectedDate ?? resolvedInitialDate,
                        minimumDate: minimumDate ?? DateTime(1900),
                        maximumDate: maximumDate ?? DateTime.now(),
                        onDateTimeChanged: (date) {
                          setModalState(() {
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomButton(
                      title: "تأكيد",
                      onTap: () {
                        Navigator.pop(context, selectedDate ?? resolvedInitialDate);
                      },
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
