import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:xkcd_mobx/constants.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';
import 'package:xkcd_mobx/ui/image_big.dart';
import 'package:xkcd_mobx/ui/nav_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final XkcdService store = XkcdService();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat formatter = DateFormat('yMMMd');

  @override
  void initState() {
    getMainComic();
    super.initState();
  }

  getMainComic() async {
    await store.getTodayComic(refresh);
  }

  refresh() async {
    initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(" main build func called");
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black87,
      endDrawer: DrawerWidget(),
      body: Container(
        child: Observer(
          builder: (context) {
            if (store.isMainComicLoading) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Lottie.asset('assets/loading.json',
                    height: 120, width: 120),
              );
            } else {
              return SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: '#',
                                    style: headingId.copyWith(fontSize: 20),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "${store.comic.getComicNumber}",
                                          style: headingId)
                                    ]),
                              ),
                              Text(
                                "${formatter.format(DateTime.parse(store.comic.getComicDate))}",
                                overflow: TextOverflow.ellipsis,
                                style: date,
                              )
                            ],
                          ),
                          IconButton(
                              icon: Icon(FeatherIcons.moreHorizontal),
                              color: white80,
                              onPressed: () {
                                _scaffoldKey.currentState.openEndDrawer();
                              })
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Text(
                        "${store.comic.getComicTitle}",
                        style: headingText,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 18),
                      height: MediaQuery.of(context).size.height * 0.38,
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            if (store.comic.getComicUrl != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return ImageBig(
                                    tag: 'imagebig',
                                    url: "${store.comic.getComicUrl}");
                              }));
                            }
                          },
                          child: CachedNetworkImage(
                            imageUrl: "${store.comic.getComicUrl}",
                            fit: BoxFit.contain,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        "${store.comic.getComicAlt}",
                        textAlign: TextAlign.justify,
                        style: caption,
                      ),
                    ),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RawMaterialButton(
                          onPressed: () async {
                            // print(" button Pressed");
                            await store.getNumberedComic(
                                store.comic.getComicNumber - 1, "down");
                          },
                          elevation: 0.0,
                          fillColor: white20,
                          child: Icon(FeatherIcons.chevronLeft,
                              color: Colors.white),
                          padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(FeatherIcons.share2),
                              color: Colors.white,
                              onPressed: () async {
                                await store.shareImage();
                              },
                            ),
                            IconButton(
                              icon: store.isComicFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: red,
                                    )
                                  : Icon(
                                      FeatherIcons.heart,
                                      color: Colors.white,
                                    ),
                              onPressed: () async {
                                await store.addFavComic();
                              },
                            ),
                            IconButton(
                              icon: Icon(FeatherIcons.download),
                              color: Colors.white,
                              onPressed: () async {
                                await store.downloadImage();
                              },
                            ),
                          ],
                        ),
                        RawMaterialButton(
                          onPressed: () async {
                            // print(" button Pressed");
                            await store.getNumberedComic(
                                store.comic.getComicNumber, "up");
                          },
                          elevation: 0.0,
                          fillColor: white20,
                          child: Icon(FeatherIcons.chevronRight,
                              color: Colors.white),
                          padding: EdgeInsets.all(5.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
              );
              // return Column(
              //   children: [
              //     SizedBox(
              //       height: MediaQuery.of(context).size.height * 0.05,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Container(
              //           child: Padding(
              //             padding: const EdgeInsets.only(right: 8.0),
              //             child: GestureDetector(
              //               onTap: () {
              //                 // print(_scaffoldKey.currentState.hasAppBar);
              //                 _scaffoldKey.currentState.openEndDrawer();
              //               },
              //               child: Icon(
              //                 Icons.menu,
              //                 color: Colors.white,
              //                 size: 30.0,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //     Container(
              //       color: Colors.black87,
              //       child: Column(
              //         children: [
              //           GestureDetector(
              //             onTap: () async {
              //               await refresh();
              //             },
              //             child: Text(
              //               "#${store.comic.getComicNumber}",
              //               overflow: TextOverflow.ellipsis,
              //               style: TextStyle(
              //                 fontSize: 20.0,
              //                 color: Colors.white,
              //                 fontWeight: FontWeight.w300,
              //               ),
              //             ),
              //           ),
              //           Text(
              //             "${formatter.format(DateTime.parse(store.comic.getComicDate))}",
              //             overflow: TextOverflow.ellipsis,
              //             style: TextStyle(
              //               fontSize: 14.0,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w200,
              //             ),
              //           ),
              //           Container(
              //             // color: Colors.white,
              //             height: MediaQuery.of(context).size.height * 0.10,
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   child: Center(
              //                     child: Text(
              //                       "${store.comic.getComicTitle}",
              //                       overflow: TextOverflow.ellipsis,
              //                       style: TextStyle(
              //                         fontSize: 28.0,
              //                         color: Colors.white,
              //                         fontWeight: FontWeight.w300,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           SizedBox(
              //             height: MediaQuery.of(context).size.height * 0.03,
              //           ),
              //           Container(
              //             height: MediaQuery.of(context).size.height * 0.38,
              //             child: Card(
              //               child: InteractiveViewer(
              //                 maxScale: 2.5,
              //                 child: CachedNetworkImage(
              //                   imageUrl: "${store.comic.getComicUrl}",
              //                   fit: BoxFit.contain,
              //                   errorWidget: (context, url, error) =>
              //                       Icon(Icons.error),
              //                 ),
              //               ),
              //             ),
              //           ),
              //           SizedBox(
              //             height: MediaQuery.of(context).size.height * 0.05,
              //           ),
              //           Container(
              //             height: MediaQuery.of(context).size.height * 0.18,
              //             padding: EdgeInsets.symmetric(horizontal: 25.0),
              //             child: Center(
              //               child: Text(
              //                 "${store.comic.getComicAlt}",
              //                 textAlign: TextAlign.justify,
              //                 style: TextStyle(
              //                   fontSize: 14.0,
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w300,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           Container(
              //             height: MediaQuery.of(context).size.height * 0.08,
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //               children: [
              //                 RaisedButton(
              //                   shape: CircleBorder(),
              //                   color: Colors.white,
              //                   child: Icon(
              //                     Icons.arrow_left,
              //                     color: Colors.black,
              //                     size: 40.0,
              //                   ),
              //                   onPressed: () async {
              //                     // print(" button Pressed");
              //                     await store.getNumberedComic(
              //                         store.comic.getComicNumber - 1, "down");
              //                   },
              //                 ),
              //                 Container(
              //                   alignment: Alignment.center,
              //                   child: IconButton(
              //                     icon: Icon(
              //                       Icons.share_rounded,
              //                       color: Colors.white,
              //                       size: 36.0,
              //                     ),
              //                     onPressed: () async {
              //                       await store.shareImage();
              //                     },
              //                   ),
              //                 ),
              //                 Container(
              //                   alignment: Alignment.center,
              //                   child: IconButton(
              //                     icon: Icon(
              //                       Icons.favorite,
              //                       color: store.isComicFavorite
              //                           ? Colors.red
              //                           : Colors.white,
              //                       size: 36.0,
              //                     ),
              //                     onPressed: () async {
              //                       await store.addFavComic();
              //                     },
              //                   ),
              //                 ),
              //                 Container(
              //                   alignment: Alignment.center,
              //                   child: IconButton(
              //                     icon: Icon(
              //                       Icons.download_rounded,
              //                       color: Colors.white,
              //                       size: 40.0,
              //                     ),
              //                     onPressed: () async {
              //                       await store.downloadImage();
              //                     },
              //                   ),
              //                 ),
              //                 Container(
              //                   padding: EdgeInsets.only(left: 10.0),
              //                   child: RaisedButton(
              //                     color: Colors.white,
              //                     shape: CircleBorder(),
              //                     child: Icon(
              //                       Icons.arrow_right,
              //                       color: Colors.black,
              //                       size: 40.0,
              //                     ),
              //                     onPressed: () async {
              //                       // print(" button Pressed");
              //                       await store.getNumberedComic(
              //                           store.comic.getComicNumber, "up");
              //                     },
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // );
            }
          },
        ),
      ),
    );
  }
}
