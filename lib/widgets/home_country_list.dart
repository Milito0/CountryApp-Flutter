import 'package:country_app/constants/colors.dart';
import 'package:country_app/models/country_model.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCountryList extends StatefulWidget {
  final List<CountryModel> countries;
  const HomeCountryList({super.key, required this.countries});

  @override
  State<HomeCountryList> createState() => _HomeCountryListState();
}

class _HomeCountryListState extends State<HomeCountryList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                height: 100,
                width: MediaQuery.of(context).size.width,
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      width: (MediaQuery.of(context).size.width - 20) * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            country.name!.common!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            country.region!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        width: (MediaQuery.of(context).size.width - 25) * 0.4,
                        height: 120,
                        child: Image.network(
                          country.flags!.png!,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
