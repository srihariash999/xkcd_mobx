import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';
import 'dart:ui' as ui;

import 'package:xkcd_mobx/ui/detailed_view_screen.dart';

class FavoriteComicsScreen extends StatefulWidget {
  FavoriteComicsScreen({Key key}) : super(key: key);

  @override
  _FavoriteComicsScreenState createState() => _FavoriteComicsScreenState();
}

class _FavoriteComicsScreenState extends State<FavoriteComicsScreen> {
  final XkcdService store = XkcdService();

  @override
  void initState() {
    store.getFavoriteComics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (context) {
          return Container(
            color: Colors.black87,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                            top: 5.0,
                            bottom: 5.0,
                          ),
                          child: Text(
                            " Favorites ",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                    child: store.isMainComicLoading
                        ? Container()
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (_, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () async {
                                    var n = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailedView(
                                          comic: store.favoriteComics[index],
                                        ),
                                      ),
                                    );
                                    if (n != null && n == true) {
                                      await store.getFavoriteComics();
                                    }
                                  },
                                  child: Container(
                                    height: 120.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(store
                                            .favoriteComics[index].comicUrl),
                                      ),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: BackdropFilter(
                                        filter: ui.ImageFilter.blur(
                                            sigmaX: 2.0, sigmaY: 2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(18.0)),
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            "#${store.favoriteComics[index].comicNumber}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: store.favoriteComics.length,
                          )
                    //  Column(
                    //     children: store.favoriteComics.map((favComic) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Card(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(12.0),
                    //             child: Text("${favComic.comicNumber}"),
                    //           ),
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
