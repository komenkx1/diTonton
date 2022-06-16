import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/recommendation_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DetailMovieBloc>().add(DetailMovieAppellation(widget.id));
      context
          .read<RecommendationMoviesBloc>()
          .add(RecommendationMoviesAppellation(widget.id));
      context.read<WatchlistMovieBloc>().add(GotWatchlistMovie(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist = context.select<WatchlistMovieBloc, bool>((bloc) {
      if (bloc.state is InsertDataMovieToWatchlist) {
        return (bloc.state as InsertDataMovieToWatchlist).watchlistStatus;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailMovieBloc, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailMovieHasData) {
            final data = state.result;
            return SafeArea(
              child: DetailContent(
                data,
                isAddedToWatchlist,
              ),
            );
          } else {
            return Text("Terjadi Error, Silahkan Periksa Jaringan Anda");
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(InsertWatchlistMovie(movie));
                                } else {
                                  context
                                      .read<WatchlistMovieBloc>()
                                      .add(DeleteWatchlistMovie(movie));
                                }

                                final state =
                                    BlocProvider.of<WatchlistMovieBloc>(context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String deleteMessage = "Removed from Watchlist";

                                if (state is InsertDataMovieToWatchlist) {
                                  final isAdded = state.watchlistStatus;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = deleteMessage;
                                  }
                                } else {
                                  if (!isAddedWatchlist) {
                                    message = insertMessage;
                                  } else {
                                    message = deleteMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == deleteMessage) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(message),
                                  ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationMoviesBloc,
                                RecommendationMoviesState>(
                              builder: (context, state) {
                                if (state is RecommendationMoviesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationMoviesHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$BASE_IMAGE_URL${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else if (state is RecommendationMoviesError) {
                                  return Expanded(
                                    child: Center(
                                      child: Text(state.message),
                                    ),
                                  );
                                } else {
                                  return const Text(
                                      'There is no recommendations');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
