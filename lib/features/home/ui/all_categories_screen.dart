import 'package:flutter/material.dart';
import 'package:gtr/core/widgets/app_bar.dart';
import 'package:gtr/features/search/component/search_sheet_grid.dart';

import '../../../core/widgets/local_image.dart';
import '../../../core/widgets/text.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'make an app bar',isBackButtonVisible: true,),
      body: SafeArea(child: Padding(
        padding: EdgeInsets.all(16),
        child: SearchSheetGrid(itemCount: 40, itemBuilder: (BuildContext context, index){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){},
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: LocalImage(img: "car-logo", type: "svg", size: 36),
                ),
              ),
              CustomText(text: "Mercedes", color: Colors.black),
            ],
          );
        }),
      )),
    );
  }
}
