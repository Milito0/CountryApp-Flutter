import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_event.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<ApiBloc>().add(const ApiEventGetRandomCountries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiStateGetCountry) {
          context.read<ApiBloc>().add(const ApiEventGetRandomCountries());
        }
      },
      builder: (context, state) {
        if (state is ApiStateGetRandomCountries) {
          return SafeArea(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 10),
                child: const Text(
                  "Paises destacado de cada continente",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              // Container Asia
              GestureDetector(
                onTap: () {
                  context
                      .read<ApiBloc>()
                      .add(ApiEventGetCountry(code: state.countries[0].cioc!));
                },
                child: Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: secondaryAppColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        width: (MediaQuery.of(context).size.width - 20) * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              state.countries[0].name!.common!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              state.countries[0].region!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
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
                            state.countries[0].flags!.png!,
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
              ),
              // CONTAINER OCEANIA
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryAppColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: (MediaQuery.of(context).size.width - 20) * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.countries[1].name!.common!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            state.countries[1].region!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
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
                          state.countries[1].flags!.png!,
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
              // CONTAINER EUROPE
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryAppColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: (MediaQuery.of(context).size.width - 20) * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.countries[2].name!.common!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            state.countries[2].region!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
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
                          state.countries[2].flags!.png!,
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
              // CONTAINER AMERICA
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryAppColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: (MediaQuery.of(context).size.width - 20) * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.countries[3].name!.common!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            state.countries[3].region!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
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
                          state.countries[3].flags!.png!,
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
              // CONTAINER AFRICA
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: secondaryAppColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: (MediaQuery.of(context).size.width - 20) * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            state.countries[4].name!.common!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(
                            state.countries[4].region!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
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
                          state.countries[4].flags!.png!,
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
            ],
          ));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
