import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

class Tutorial extends StatefulWidget {
  Tutorial({Key? key}) : super(key: key);

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  int activeIndex = 0;
  final controller = CarouselController();
  final imagePaths = [ // array di immagini
    'images/home.png',
    'images/new_task.png',
    'images/signin.png',
    'images/signup.png',
    'images/community.png',
    'images/nuovo_commento.png',
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
                carouselController: controller,
                itemCount: imagePaths.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = imagePaths[index];
                  return buildImage(urlImage, index); //widget container con dentro un'immagine
                },
                options: CarouselOptions(
                    height: 610,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) => //modifica l'indice corrente
                        setState(() => activeIndex = index))
            ),
            SizedBox(height: 10),
            buildIndicator()
          ],
        ),
      ),
    );
  }
// indicatore della pagina
  Widget buildIndicator() => AnimatedSmoothIndicator(
    onDotClicked: animateToSlide,
    effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.blue),
    activeIndex: activeIndex,
    count: imagePaths.length,
  );

  void animateToSlide(int index) => controller.animateToPage(index);
}
// per visualizzare degli asset di immagini devo trasformarli in widget
Widget buildImage(String urlImage, int index) =>
    Container(child: Image.asset(urlImage, fit: BoxFit.cover));