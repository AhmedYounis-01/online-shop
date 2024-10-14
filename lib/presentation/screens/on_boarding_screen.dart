import 'package:flutter/material.dart';
import 'package:shop_app/data/local/cache_helper.dart';
import 'package:shop_app/presentation/screens/shop/shop_login_screen.dart';
import 'package:shop_app/presentation/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/images/img1.jpg",
        title: "on board title 1",
        body: "on board body 1"),
    BoardingModel(
        image: "assets/images/img2.jpg",
        title: "on board title 2",
        body: "on board body 2"),
    BoardingModel(
        image: "assets/images/img3.jpg",
        title: "on board title 3",
        body: "on board body 3"),
  ];

  var boardController = PageController();

  bool isLast = false;

  void submit() {
    CacheHelper.saveData(key: "onBoarding", value: true).then(
      (value) {
        // ignore: use_build_context_synchronously
        navigateAndFinish(context, ShopLoginScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const Text(
              "Skip",
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int value) {
                  if (value == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    }
                    boardController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  },
                  child: const Icon(
                    Icons.arrow_right_alt,
                    size: 35,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
