import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:xkcd_mobx/constants.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';
import 'package:xkcd_mobx/ui/image_big.dart';

class RandomComicScreen extends StatefulWidget {
  RandomComicScreen({Key key}) : super(key: key);

  @override
  _RandomComicScreenState createState() => _RandomComicScreenState();
}

class _RandomComicScreenState extends State<RandomComicScreen> {
  final XkcdService store = XkcdService();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  DateFormat formatter = DateFormat('yMMMd');

  @override
  void initState() {
    getMainComic();
    super.initState();
  }

  getMainComic() async {
    await store.getRandomComic();
  }

  Future<void> _handleRefresh() async {
    await store.getRandomComic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bg,
        title: Center(child: Text('Random Comics')),
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
              return Container(
                color: bg,
                child: LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: _handleRefresh,
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  springAnimationDurationInMilliseconds: 200,
                  showChildOpacityTransition: false,
                  child: ListView(
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
                                            text:
                                                "${store.comic.getComicNumber}",
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
                              onPressed: () {
                                store.getRandomComic();
                              },
                              color: white80,
                              icon: Icon(
                                FeatherIcons.refreshCcw,
                                size: 30.0,
                              ),
                            ),
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
                            child: Hero(
                              tag: 'imagebig',
                              child: CachedNetworkImage(
                                imageUrl: "${store.comic.getComicUrl}",
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          "${store.comic.getComicAlt}",
                          textAlign: TextAlign.justify,
                          style: caption,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            onPressed: () {
                              store.addFavComic();
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
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
