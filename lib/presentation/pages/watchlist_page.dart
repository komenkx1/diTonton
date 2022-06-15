import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context.read<WatchlistMovieBloc>().add(OnGotWatchlistMovie()),
          context.read<WatchlistTvSeriesBloc>().add(OnGotWatchlistTvSeries())
        });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnGotWatchlistMovie());
    context.read<WatchlistTvSeriesBloc>().add(OnGotWatchlistTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                  builder: (context, state) {
                    if (state is WatchlistMovieLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WatchlistMovieHasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final movie = state.result[index];
                          return CardList(
                            dataList: movie,
                          );
                        },
                        itemCount: state.result.length,
                      );
                    } else {
                      return Center(
                        child: Column(
                          children: [
                            Text('Data Movies Watcchlist Tidak Tersedia'),
                            SizedBox(height: 16),
                          ],
                        ),
                      );
                    }
                  },
                ),

                BlocBuilder<WatchlistTvSeriesBloc, WatchlistTvSeriesState>(
                  builder: (context, state) {
                    if (state is WatchlistTvSeriesLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WatchlistTvSeriesHasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = state.result[index];
                          return CardList(
                            dataList: data,
                            isTvSeries: true,
                          );
                        },
                        itemCount: state.result.length,
                      );
                    } else {
                      return Center(
                        child: Text('Data Watchlist Tv Series Tidak Tersedia'),
                      );
                    }
                  },
                ),

                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     final movie = data.watchlistMovies[index];
                //     return CardList(
                //       dataList: movie,
                //     );
                //   },
                //   itemCount: data.watchlistMovies.length,
                // ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
