import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/UserScreens/AppBar/theme.dart';
import 'package:highlights/UserScreens/search.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: whiteTheme,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Search for a specialist Or a Catergory',
            style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    color: Colors.black)),
          ),
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySeachDelegate(),
                );
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
              )),
        ],
      ),
    );
  }
}
