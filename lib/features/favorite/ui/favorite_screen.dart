import 'package:flutter/material.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/core/widgets/responsive_grid.dart';
import 'package:gtr/core/widgets/text.dart';
import 'package:gtr/features/favorite/component/favorite_Product_card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final List<Map<String, String>> favoriteCars = [
    {
      "name": "Mclaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaren 750S",
      "image": "car7",
      "price": "22aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa00",
      "hp": "52aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0",
      "trans": "Autaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaomatic",
      "seats": "2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    },
    {
      "name": "Ferraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaari Convertible",
      "image": "car6",
      "price": "2200",
      "hp": "520",
      "trans": "Automatic",
      "seats": "2",
    },
    {
      "name": "Mclaren 750S",
      "image": "car8",
      "price": "2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa200",
      "hp": "520",
      "trans": "Automatic",
      "seats": "2",
    },
    {
      "name": "Ferrari Convertible",
      "image": "car7",
      "price": "2200",
      "hp": "52aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa0",
      "trans": "Automatic",
      "seats": "2",
    },
    {
      "name": "Ferrari Convertible",
      "image": "car7",
      "price": "2200",
      "hp": "520",
      "trans": "Automaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaatic",
      "seats": "2",
    },
    {
      "name": "Mclaren 750S",
      "image": "car8",
      "price": "2200",
      "hp": "520",
      "trans": "Automatic",
      "seats": "2aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    },
    {
      "name": "Mclaren 750S",
      "image": "car7",
      "price": "2200",
      "hp": "520",
      "trans": "Automatic",
      "seats": "2",
    },
  ];

  void _removeItem(int index) {
    setState(() {
      favoriteCars.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "My Favorites"),
      body: SafeArea(
        child: favoriteCars.isEmpty
            ? const Center(
                child: CustomText(text: "No Favorites Yet!", fontWeight: FontWeight.bold, fontSize: 16),
              )
            : ListView(
                children: [
                  ResponsiveGrid(
                    forFavoriteScreen: true,
                    itemCount: favoriteCars.length,
                    itemBuilder: (BuildContext context, index) {
                      final car = favoriteCars[index];
                      return FavoriteProductCard(
                        carName: car["name"]!,
                        carImage: car["image"]!,
                        price: car["price"]!,
                        hp: car["hp"]!,
                        transmission: car["trans"]!,
                        seatCount: car["seats"]!,
                        onRemove: () => _removeItem(index),
                        onBookTap: () {},
                      );
                    },
                  ),
                  const SizedBox(height: 80),
                ],
              ),
      ),
    );
  }
}
