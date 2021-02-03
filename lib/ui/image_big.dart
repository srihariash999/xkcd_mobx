import "package:flutter/material.dart";
import 'package:xkcd_mobx/constants.dart';

class ImageBig extends StatefulWidget {
  final String tag;
  final String url;

  ImageBig({Key key, @required this.tag, @required this.url})
      : assert(tag != null),
        assert(url != null),
        super(key: key);

  @override
  _ImageBigState createState() => _ImageBigState();
}

class _ImageBigState extends State<ImageBig> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: bg,
        body: InteractiveViewer(
          maxScale: 2.5,
          child: Center(
            child: Hero(tag: widget.tag, child: Image.network(widget.url)),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
