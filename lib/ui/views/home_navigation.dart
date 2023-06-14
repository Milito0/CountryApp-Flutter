import 'package:country_app/constants/colors.dart';
import 'package:country_app/services/api/bloc/api_bloc.dart';
import 'package:country_app/services/api/bloc/api_state.dart';
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
    _selectedIndex = index;
    setState(() {});
  }

  final List<Widget> _list = [
    const HomeView(),
    const SearchView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApiBloc, ApiState>(
      listener: (context, state) {
        if (state is ApiStateGetCountry) {
          showGeneralDialog(
            context: context,
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => DetailView(
              country: state.country,
            ),
            transitionBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position:
                    Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
                        .animate(animation),
                child: child,
              );
            },
          );
        } else if (state is ApiStateGetHomeCountry) {
          _navigateTo(1);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: _list[_selectedIndex],
          bottomNavigationBar: Container(
            color: secondaryAppColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
    );
  }
}
