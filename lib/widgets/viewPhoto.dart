import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';

class ImagePhotoview extends StatefulWidget {
  ImagePhotoview({super.key, required this.image1, this.index = 0}) : pageController = PageController(initialPage: index);
  final String image1;
  final PageController? pageController;
  final int index;

  @override
  State<ImagePhotoview> createState() => _ImagePhotoviewState();
}

class _ImagePhotoviewState extends State<ImagePhotoview> {
  late int index = widget.index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          PhotoView(
            // imageProvider: NetworkImage(widget.image1.length < 255 ? baseUrl + widget.image1 : widget.image1),
            imageProvider: AssetImage('assets/images/bannerLogin.png'),
          ),
          Positioned(
            top: 30,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
