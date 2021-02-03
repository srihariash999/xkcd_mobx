import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xkcd_mobx/constants.dart';
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
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bg,
        title: Center(child: Text('Favorites')),
        actions: [
          Icon(
            Icons.more_horiz_outlined,
            color: bg,
          ),
          Icon(
            Icons.more_horiz_outlined,
            color: bg,
          )
        ],
      ),
      body: Observer(
        builder: (context) {
          return Container(
            color: bg,
            child: Column(
              children: [
                Expanded(
                  child: store.isMainComicLoading
                      ? Container()
                      : store.favoriteComics.length > 0
                          ? GridView.builder(
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
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: CachedNetworkImageProvider(
                                              store.favoriteComics[index]
                                                  .comicUrl),
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
                                                    BorderRadius.circular(
                                                        10.0)),
                                            padding: const EdgeInsets.all(12.0),
                                            child: RichText(
                                              text: TextSpan(
                                                  text: '#',
                                                  style: headingId.copyWith(
                                                      fontSize: 20),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text:
                                                            "${store.favoriteComics[index].comicNumber}",
                                                        style: headingId)
                                                  ]),
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
                          : Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 40.0),
                              child: Text(
                                " No favorite comics, mark some comics as favorite to see them here ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ),
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
