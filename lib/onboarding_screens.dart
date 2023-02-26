import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sphere/IntroFiles/page1.dart';
import 'package:sphere/IntroFiles/page2.dart';
import 'package:sphere/IntroFiles/page3.dart';
import 'IntroFiles/page4.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 3);
              });
            },
            children: const [
              Page1(),
              Page2(),
              Page3(),
              Page4(),
            ],
          ),
          Container(
              alignment: const Alignment(0, 0.75),
              //x value and y value - both takes from -1 to +1.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  onLastPage
                      ? const Text(
                          '         ',
                          style: TextStyle(fontSize: 15),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.jumpToPage(3); //0 for 1st
                          },
                          child: const Text(
                            'Skip',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const SlideEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.black87,
                        dotHeight: 10,
                        dotWidth: 10),
                  ),
                  onLastPage
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/');
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeIn);
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                ],
              )),
        ],
      ),
    );
  }
}
