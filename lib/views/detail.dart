import 'package:country_app/constants/colors.dart';
import 'package:country_app/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailView extends StatefulWidget {
  final CountryModel country;
  const DetailView({super.key, required this.country});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late final GoogleMapController _controller;
  Map<String, Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.down,
      key: UniqueKey(),
      onDismissed: (direction) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            color: backgroundAppColor,
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
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
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 90, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Capital",
                              style: TextStyle(
                                  fontSize: 27,
                                  decoration: TextDecoration.underline),
                            ),
                            Text(
                              widget.country.capital!.first,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Container(
                              height: 20,
                            ),
                            const Text(
                              "Population",
                              style: TextStyle(
                                  fontSize: 27,
                                  decoration: TextDecoration.underline),
                            ),
                            Text(
                              widget.country.population!.toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 90, left: 30),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            width: 180,
                            height: 130,
                            child: Image.network(
                              widget.country.flags!.png!,
                              fit: BoxFit.fill,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Text(
                              "Country:  ${widget.country.region}",
                              style: const TextStyle(fontSize: 20),
                            ),
                            Text(
                              "Subcountry:  ${widget.country.subregion}",
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 300,
                    width: 300,
                    margin: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                            widget.country.latlng![0],
                            widget.country.latlng![1],
                          ),
                          zoom: 5),
                      onMapCreated: (controller) {
                        _controller = controller;
                        addMarker(
                            'test',
                            LatLng(
                              widget.country.latlng![0],
                              widget.country.latlng![1],
                            ));
                      },
                      markers: _markers.values.toSet(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(markerId: MarkerId(id), position: location);
    _markers[id] = marker;
    setState(() {});
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
