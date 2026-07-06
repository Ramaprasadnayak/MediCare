import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:maruthimedical/core/constants/carosel_list.dart';

class Carosel extends StatefulWidget {
  const Carosel({super.key});
  @override
  State<Carosel> createState() => _CaroselState();
}

class _CaroselState extends State<Carosel> {
  
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: imgList.map((e) => Center(
            child: Image.asset(e,fit: BoxFit.cover,width: double.infinity),
          ),).toList(),
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: const Duration(seconds: 5),
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 10),
        buildCarouselIndicator(),
      ],
    );
  }

  Widget buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            margin: const EdgeInsets.all(4),
            height: 8,
            width: 8,
            decoration: BoxDecoration(
              color: currentIndex == i ? Colors.blue : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
