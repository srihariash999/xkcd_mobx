import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xkcd_mobx/ui/custom_dialog.dart';
import 'package:xkcd_mobx/ui/fav_comics.dart';
import 'package:xkcd_mobx/ui/random_comic_screen.dart';

TextStyle navDrawerTextStyle = GoogleFonts.fredokaOne(
    color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200);

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 100.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RandomComicScreen(),
                      ),
                    );
                  },
                  child: Text("Random Comics", style: navDrawerTextStyle),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16.0, bottom: 30.0),
              //   child: Text("App Settings", style: navDrawerTextStyle),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteComicsScreen(),
                      ),
                    );
                  },
                  child: Text("Favorite Comics", style: navDrawerTextStyle),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 30.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogBox(
                            title: "About Author",
                            descriptions:
                                "This app was developed by Srihari A. You can contact him using links below.",
                            text: "Close",
                          );
                        });
                  },
                  child: Text("About Author", style: navDrawerTextStyle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
