import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:mas_market/Pages/app/main/App%20Main%20Screen/app_main_screen.dart';
import 'package:mas_market/Pages/app/main/On%20Bording/custom_clip.dart';
import 'package:mas_market/core/model/onbording.dart';
import 'package:mas_market/core/theme/app_colors.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          SizedBox(height: size.height, width: size.width),
          Positioned(
            top: -50,
            right: 2,
            left: 2,
            child: Image.asset(
              'assets/smiley-woman-pink-suit-with-shopping-nets.png',
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClip(),
              child: Container(
                color: AppColors.softGreen,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _currentPage = value;
                          });
                        },
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: data[index]['title'],
                                      style: TextStyle(
                                        fontSize: 40,

                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    TextSpan(text: '\n'),
                                    TextSpan(
                                      text: data[index]['subtitle'],
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        data.length,
                        (index) => AnimatedContainer(
                          duration: Duration(microseconds: 500),
                          width: _currentPage == index ? 20 : 10,
                          height: 10,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color:
                                _currentPage == index
                                    ? AppColors.softPurple
                                    : AppColors.paleGold,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    MaterialButton(
                      onPressed: () {
                        Get.offAll(AppMainScreen());
                      },
                      color: AppColors.background,
                      height: 65,
                      minWidth: 250,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'ابدا التسوق',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
