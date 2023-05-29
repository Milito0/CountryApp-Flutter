import 'package:country_app/constants/colors.dart';
import 'package:country_app/models/country_model.dart';
import 'package:flutter/material.dart';

class DetailView extends StatefulWidget {
  final CountryModel country;
  const DetailView({super.key, required this.country});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundAppColor,
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      color: Colors.red,
                      margin: const EdgeInsets.only(top: 30, left: 30),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        widget.country.name!.common!,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            widget.country.fav = !widget.country.fav;
                            getIcon(widget.country.fav);
                          });
                        },
                        icon: getIcon(widget.country.fav),
                        iconSize: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getIcon(bool fav) {
    if (!fav) {
      return const Icon(
        Icons.favorite_border,
        color: Colors.black,
      );
    }
    return const Icon(
      Icons.favorite,
      color: Colors.red,
    );
  }
}
