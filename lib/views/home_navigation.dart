import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/api_provider.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
import 'package:country_app/services/api/repository.dart';
import 'package:country_app/views/detail.dart';
import 'package:country_app/views/pages/home.dart';
import 'package:country_app/views/pages/profile.dart';
import 'package:country_app/views/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeNavigationView extends StatefulWidget {
  const HomeNavigationView({super.key});
  @override
  State<HomeNavigationView> createState() => _HomeNavigationViewState();
}

class _HomeNavigationViewState extends State<HomeNavigationView> {
  int _selectedIndex = 0;
  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _list = [
    const HomeView(),
    const SearchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ApiBloc>(
      create: (context) => ApiBloc(Repository()),
      child: BlocConsumer<ApiBloc, ApiState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ApiStateGetCountry) {
            return DetailView(country: state.country);
          }
          return Scaffold(
            body: _list[_selectedIndex],
            bottomNavigationBar: Container(
              color: secondaryAppColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: GNav(
                  tabBackgroundColor: backgroundAppColor,
                  backgroundColor: secondaryAppColor,
                  gap: 10,
                  padding: const EdgeInsets.all(10),
                  tabs: const [
                    GButton(
                      icon: Icons.home,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.search,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.account_circle_rounded,
                      text: 'Profile',
                    ),
                  ],
                  onTabChange: (value) => _navigateTo(value),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
