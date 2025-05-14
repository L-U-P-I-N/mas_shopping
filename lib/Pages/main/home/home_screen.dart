// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:mas_market/Pages/main/home/widgets/app_banner.dart';
import 'package:mas_market/Pages/main/home/widgets/app_bar_part.dart';
import 'package:mas_market/Pages/main/home/widgets/product_item_display.dart';
import 'package:mas_market/core/model/category.dart';
import 'package:mas_market/core/model/product.dart';
import 'package:mas_market/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:mas_market/Models/category_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<CategoryModel>> futureCategoryModel;
  String? selectedCategory;
  late Future<List<ProductModel>> futureProductModel = Future.value([]);

  @override
  void initState() {
    super.initState();
    futureCategoryModel = fetchCategoryModel().then((categories) {
    if (categories.isNotEmpty) {
      setState(() {
        selectedCategory = categories.first.name;
        futureProductModel = fetchProductModel(selectedCategory!);
      });
    }
    return categories;
  });
  }

  Future<List<ProductModel>> fetchProductModel(String value) async {
    try {
      final response = await Supabase.instance.client.from('shop_products').select().eq('category', value);
      return (response as List).map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      return [];
    }
  }
    Future<List<CategoryModel>> fetchCategoryModel() async {
    try {
      final response = await Supabase.instance.client.from('category').select();
      return (response as List).map((json) => CategoryModel.fromJson(json)).toList();
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: AppColors.background,
  appBar: AppBarPart(),
  body: Column(
    children:[ Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appBanner(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),Text('Categories',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
        ],
      ),
    ),
    _buildCategoryList(),
    SizedBox(height: MediaQuery.of(context).size.height * 0.03) ,
    ViewAll(),
    SizedBox(height: MediaQuery.of(context).size.height * 0.03) ,
    _buildProductSection(),
    ],)
   
);

  }

  Padding ViewAll() {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Popular Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppColors.textPrimary),),
        GestureDetector(
          onTap: () {
          
          },
          child: Row(
            children: [
              Text("See All",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: AppColors.textSecondary),),
              Icon(Icons.arrow_forward_ios_outlined,color: AppColors.textSecondary,)
            ],
          ),
        )
      ],
    ),
  );
  }

  
  
  
  Widget _buildCategoryList() {
    return FutureBuilder<List<CategoryModel>>(
      future: futureCategoryModel,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final categories = snapshot.data ?? [];
        if (categories.isEmpty) {
          return const Center(child: Text('No categories found.'));
        }
        // Initialize selectedCategory on first load
        if (selectedCategory == null && categories.isNotEmpty) {
          selectedCategory = categories.first.name;
        }
        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category.name;
                      futureProductModel = fetchProductModel(category.name);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: selectedCategory == category.name
                          ? AppColors.softPurple
                          : AppColors.softGreen,
                      borderRadius: BorderRadius.circular(20),),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: selectedCategory == category.name
                                ? AppColors.background
                                : AppColors.softGreen,
                            shape: BoxShape.circle),
                          child: Image.network(
                            category.image,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.shop),
                          ),
                        ),
                        SizedBox(width: 15,),
                        Text(category.name,
                          style: TextStyle(
                            color: selectedCategory == category.name
                                ? const Color.fromARGB(255, 255, 255, 255)
                                : AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }


 Widget _buildProductSection() {
    return Expanded(
      child: FutureBuilder<List<ProductModel>>(
        future: futureProductModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final product = snapshot.data ?? [];
          if (product.isEmpty) {
            return const Center(child: Text('No Product found.'));
          }
          // Initialize selectedCategory on first load
          if (selectedCategory == null && product.isNotEmpty) {
            selectedCategory = product.first.name;
          }
          return  ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: product.length,
              // physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                // final category = product[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 25 : 0,
                    right: index == product.length-1 ? 25 : 0,),
                  child: ProductItemDisplay(productModel: product[index],)
                );
              },
            
          );
        },
      ),
    );
  }

}
