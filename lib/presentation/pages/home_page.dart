import 'package:ditonton/presentation/bloc/home_bloc.dart';
import 'package:ditonton/presentation/bloc/home_event.dart';
import 'package:ditonton/presentation/bloc/home_state.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/screens/home_movie_screen.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/screens/tv_series_screen.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeBloc>().add(OnPageChanged(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is HomeHasData) {
        return Scaffold(
          drawer: Drawer(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('assets/circle-g.png'),
                  ),
                  accountName: Text('Ditonton'),
                  accountEmail: Text('ditonton@dicoding.com'),
                ),
                ListTile(
                  leading: Icon(Icons.movie),
                  title: Text('Movies'),
                  onTap: () {
                    context.read<HomeBloc>().add(OnPageChanged(0));
                    Navigator.pop(context);
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.tv),
                  title: Text('Tv Series'),
                  onTap: () {
                    // FirebaseCrashlytics.instance.crash();
                    context.read<HomeBloc>().add(OnPageChanged(1));
                    Navigator.pop(context);
                    // Navigator.pushNamed(context, TvSeriesScreen.ROUTE_NAME);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.save_alt),
                  title: Text('Watchlist'),
                  onTap: () {
                    Navigator.pushNamed(
                        context, WatchlistMoviesPage.ROUTE_NAME);
                  },
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
                  },
                  leading: Icon(Icons.info_outline),
                  title: Text('About'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(state.index == 0 ? 'Movie List' : 'Tv Series'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                },
                icon: Icon(Icons.search),
              )
            ],
          ),
          body: IndexedStack(
            index: state.index,
            children: [
              HomeMovieScreen(),
              TvSeriesScreen(),
            ],
          ),
        );
      }
      return Container();
    });
  }
}
