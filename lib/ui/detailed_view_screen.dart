import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:xkcd_mobx/database/fav_comics.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';
import 'package:xkcd_mobx/ui/image_big.dart';

import '../constants.dart';

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
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bg,
        title: Center(child: Text('Favorite')),
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
      key: _scaffoldKey,
      body: Container(
        color: bg,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                  text: "${widget.comic.comicNumber}",
                                  style: headingId)
                            ]),
                      ),
                      Text(
                        "${formatter.format(DateTime.parse(widget.comic.comicDate))}",
                        overflow: TextOverflow.ellipsis,
                        style: date,
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 25.0,
                    ),
                    onPressed: () async {
                      bool _didDelete =
                          await store.favRemoveAction(widget.comic);
                      if (_didDelete) {
                        // Return true if comic is deleted successfully, to tell UI to refresh
                        Navigator.pop(context, true);
                      } else {
                        BotToast.showText(
                          text: "Cannot remove from favorites",
                          textStyle: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          contentColor: Colors.white,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                "${widget.comic.comicTitle}",
                style: headingText,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 18),
              height: MediaQuery.of(context).size.height * 0.38,
              child: Card(
                child: InteractiveViewer(
                  maxScale: 2.5,
                  child: GestureDetector(
                    onTap: () {
                        if (widget.comic.comicUrl != null) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ImageBig(tag: 'imagebig', url: "${widget.comic.comicUrl}");
                          }));
                        }
                      },
                                      child: Hero(
                      tag: 'imagebig',
                                        child: CachedNetworkImage(
                        imageUrl: "${widget.comic.comicUrl}",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "${widget.comic.comicAlt}",
                textAlign: TextAlign.justify,
                style: caption,
              ),
            ),
            Expanded(child: Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(FeatherIcons.share2),
                  color: Colors.white,
                  onPressed: () async {
                    await store.favShareAction(widget.comic);
                  },
                ),
                IconButton(
                  icon: Icon(FeatherIcons.download),
                  color: Colors.white,
                  onPressed: () async {
                    await store.favDownlaoadAction(widget.comic);
                  },
                ),
              ],
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.30,
            //       child: Row(
            //         children: [
            //           IconButton(
            //             icon: Icon(
            //               Icons.favorite,
            //               color: Colors.red,
            //               size: 25.0,
            //             ),
            //             onPressed: () async {
            //               bool _didDelete =
            //                   await store.favRemoveAction(widget.comic);
            //               if (_didDelete) {
            //                 // Return true if comic is deleted successfully, to tell UI to refresh
            //                 Navigator.pop(context, true);
            //               } else {
            //                 BotToast.showText(
            //                   text: "Cannot remove from favorites",
            //                   textStyle: TextStyle(
            //                     fontSize: 18.0,
            //                     color: Colors.black,
            //                   ),
            //                   contentColor: Colors.white,
            //                 );
            //               }
            //             },
            //           ),
            //           IconButton(
            //             icon: Icon(
            //               Icons.share_rounded,
            //               color:
            //                   store.isComicFavorite ? Colors.red : Colors.white,
            //               size: 25.0,
            //             ),
            //             onPressed: () async {
            //               await store.favShareAction(widget.comic);
            //             },
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       width: MediaQuery.of(context).size.width * 0.30,
            //       child: Column(
            //         children: [
            //           Text(
            //             "#${widget.comic.comicNumber}",
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(
            //               fontSize: 20.0,
            //               color: Colors.white,
            //               fontWeight: FontWeight.w300,
            //             ),
            //           ),
            //           Text(
            //             "${formatter.format(DateTime.parse(widget.comic.comicDate))}",
            //             overflow: TextOverflow.ellipsis,
            //             style: TextStyle(
            //               fontSize: 14.0,
            //               color: Colors.white,
            //               fontWeight: FontWeight.w200,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Container(
            //       alignment: Alignment.centerRight,
            //       width: MediaQuery.of(context).size.width * 0.30,
            //       child: IconButton(
            //         icon: Icon(
            //           Icons.download_rounded,
            //           color: Colors.white,
            //           size: 25.0,
            //         ),
            //         onPressed: () async {
            //           await store.favDownlaoadAction(widget.comic);
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            // Container(
            //   // color: Colors.white,
            //   height: MediaQuery.of(context).size.height * 0.10,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Center(
            //             child: Text(
            //           "${widget.comic.comicTitle}",
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 28.0,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w300,
            //           ),
            //         )),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.03,
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.42,
            //   child: Card(
            //     child: InteractiveViewer(
            //       maxScale: 2.5,
            //       child: CachedNetworkImage(
            //         imageUrl: "${widget.comic.comicUrl}",
            //         fit: BoxFit.contain,
            //         errorWidget: (context, url, error) => Icon(Icons.error),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.05,
            // ),
            // Container(
            //   height: MediaQuery.of(context).size.height * 0.20,
            //   padding: EdgeInsets.symmetric(horizontal: 25.0),
            //   child: Center(
            //     child: Text(
            //       "${widget.comic.comicAlt}",
            //       textAlign: TextAlign.justify,
            //       style: TextStyle(
            //         fontSize: 14.0,
            //         color: Colors.white,
            //         fontWeight: FontWeight.w300,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
