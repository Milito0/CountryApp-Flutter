import 'package:country_app/constants/colors.dart';
import 'package:country_app/models/country_model.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/auth/auth_service.dart';
import 'package:country_app/services/cloud/firebase_cloud.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryList extends StatefulWidget {
  final List<CountryModel> countries;
  const CountryList({super.key, required this.countries});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late final FirebaseCloudStorage _countryService;
  String get userId => AuthService.firebase().currentUser!.id;

  @override
  void initState() {
    _countryService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
        return StreamBuilder(
          stream: _countryService.allCountries(ownerId: userId),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.active:
                return ListView.builder(
                  itemCount: widget.countries.length,
                  itemBuilder: (context, index) {
                    final country = widget.countries.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ApiBloc>()
                            .add(ApiEventGetCountry(code: country.cioc!));
                      },
                      child: Container(
                        height: 120,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: listBackgroundColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 220,
                              child: Center(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 170,
                                          child: Text(
                                            country.name!.common!,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            removeOrAddFavCountry(country);
                                            setState(() {
                                              country.fav = !country.fav;
                                              if (state
                                                  is ApiStateGetFavCountries) {
                                                widget.countries
                                                    .removeAt(index);
                                              }
                                            });
                                          },
                                          icon: getIcon(country.fav),
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        'Capital: ${country.capital![0]}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      removeDiacritics(
                                          ('Region: ${country.region}')),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                width: 150,
                                height: 120,
                                child: Image.network(
                                  country.flags!.png!,
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              default:
                return Center(
                  child: Image.asset(
                    "assets/images/globe-2.gif",
                    height: 200,
                    width: 200,
                  ),
                );
            }
          },
        );
      },
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

  void removeOrAddFavCountry(CountryModel country) async {
    final favCountries = await _countryService.getFavCountries(ownerId: userId);

    for (var c in favCountries) {
      if (c.cioc == country.cioc) {
        await _countryService.removeFav(documentId: c.documentId);
        return;
      }
    }

    await _countryService.newFavCountry(ownerId: userId, cioc: country.cioc!);
  }
}
