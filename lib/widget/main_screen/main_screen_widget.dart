import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:themoviedb/Library/Widgets/Inherited/provider.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/navigation/main_navigation.dart';
import 'package:themoviedb/widget/favorites/favorites_widget_model.dart';

import 'package:themoviedb/widget/movie_list/movie_list_model.dart';
import 'package:themoviedb/widget/movie_list/movie_list_widget.dart';

import '../favorites/favorites_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({
    super.key,
  });

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

enum MenuItem { logout }

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  final movieListModel = MovieListModel();
  final favoritListModel = FavoriteMoviesModel();

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    movieListModel.setupLocale();
    favoritListModel.setupLocale();
  }

  // @override
  // void initState() {
  //   super.initState();

  //   movieListModel.setupLocale(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Column(
          children: [
            Image.asset(
              'assets/images/themoviedb_logo.png',
              height: 35,
            )
          ],
        ),
        leading: PopupMenuButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: const Color.fromARGB(255, 3, 37, 65),
          icon: const Icon(
            FontAwesomeIcons.userLarge,
            size: 18,
            color: Colors.white,
          ),
          onSelected: (value) {
            if (value == MenuItem.logout) {
              SessionDataProvider().setSessionId(null);
              Navigator.pushNamed(context, MainNavigationRouteNames.auth);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: MenuItem.logout,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          NotifierProvider(
              create: () => movieListModel,
              isManagingModel: false,
              child: const MovieListWidget()),
          NotifierProvider(
              create: () => favoritListModel,
              isManagingModel: false,
              child: const FavoriteMoviesListsWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedTab,
        onTap: onSelectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.film),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(FontAwesomeIcons.solidHeart),
            icon: Icon(FontAwesomeIcons.heart),
            label: '',
          ),
        ],
      ),
    );
  }
}
