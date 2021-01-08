import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xkcd_mobx/database/fav_comics.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';

class DetailedView extends StatefulWidget {
  final FavComic comic;
  DetailedView({Key key, @required this.comic}) : super(key: key);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  final XkcdService store = XkcdService();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat formatter = DateFormat('yMMMd');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text("")
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.favorite,
                    //     color: Colors.white,
                    //     size: 25.0,
                    //   ),
                    //   onPressed: () {
                    //     store.addFavComic();
                    //   },
                    // ),
                    ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Column(
                    children: [
                      Text(
                        "#${widget.comic.comicNumber}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "${formatter.format(DateTime.parse(widget.comic.comicDate))}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: IconButton(
                    icon: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                      size: 25.0,
                    ),
                    onPressed: () async {
                      store.downloadImage();
                    },
                  ),
                ),
              ],
            ),
            Container(
              // color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                children: [
                  Expanded(
                    child: Center(
                        child: Text(
                      "${widget.comic.comicTitle}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.42,
              child: Card(
                child: InteractiveViewer(
                  maxScale: 2.5,
                  child: CachedNetworkImage(
                    imageUrl: "${widget.comic.comicUrl}",
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.20,
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Text(
                  "${widget.comic.comicAlt}",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
