import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:js_event_app/models/onboarding_model.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  static const boardingTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w900);
  static const boardingSubTextStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey);

  static const double kDefaultPadding = 20;

  static int currentIndex = 0;

  final double _width = 10;

  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: onBoarding.length,
            itemBuilder: (_, i) {
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      onBoarding[i].image.toString(),
                      height: 250,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    Text(onBoarding[i].title.toString(),
                        style: boardingTextStyle),
                    const SizedBox(height: kDefaultPadding),
                    Text(
                      onBoarding[i].discription.toString(),
                      textAlign: TextAlign.center,
                      style: boardingSubTextStyle,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            onBoarding.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              margin: const EdgeInsets.only(right: 5),
              height: 10,
              width: currentIndex == index ? _width : 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding),
                color: index == currentIndex ? Colors.blueGrey : Colors.grey,
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: currentIndex == 2 ? Colors.blueGrey : null),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(40),
          child: Row(
            mainAxisAlignment: currentIndex == 2
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
            children: currentIndex == 2
                ? [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )),
                    )
                  ]
                : [
                    TextButton(
                        onPressed: () {
                          _controller.jumpToPage(3);
                        },
                        child: const Text(
                          "Skip",
                          style: TextStyle(color: Colors.blueGrey),
                        )),
                    IconButton(
                      onPressed: () {
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn);
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                      color: Colors.black,
                    )
                  ],
          ),
        ),
      ],
    ));
  }
}
