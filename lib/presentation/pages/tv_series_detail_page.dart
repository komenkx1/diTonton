import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/detail_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/recommendation_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv-series';

  final int id;
  TvSeriesDetailPage({required this.id});

  @override
  _TvSeriesDetailPageState createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<DetailTvSeriesBloc>()
          .add(DetailTvSeriesAppellation(widget.id));
      context
          .read<RecommendationTvSeriesBloc>()
          .add(RecommendationTvSeriesAppellation(widget.id));
      context
          .read<WatchlistTvSeriesBloc>()
          .add(GotWatchlistTvSeries(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isAddedToWatchlist =
        context.select<WatchlistTvSeriesBloc, bool>((bloc) {
      if (bloc.state is InsertDataTvSeriesToWatchlist) {
        return (bloc.state as InsertDataTvSeriesToWatchlist).watchlistStatus;
      }
      return false;
    });
    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
        builder: (context, state) {
          if (state is DetailTvSeriesLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSeriesHasData) {
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
  final TvSeriesDetail tvSeries;
  final bool isAddedWatchlist;

  DetailContent(this.tvSeries, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(InsertWatchlistTvSeries(tvSeries));
                                } else {
                                  context
                                      .read<WatchlistTvSeriesBloc>()
                                      .add(DeleteWatchlistTvSeries(tvSeries));
                                }

                                final state =
                                    BlocProvider.of<WatchlistTvSeriesBloc>(
                                            context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String deleteMessage = "Removed from Watchlist";

                                if (state is InsertDataTvSeriesToWatchlist) {
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
                                    action: SnackBarAction(
                                      label: 'See Watchlist',
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            WatchlistMoviesPage.ROUTE_NAME);
                                      },
                                    ),
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
                              _showGenres(tvSeries.genres),
                            ),
                            Text(
                              _formatListDuration(tvSeries.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            Container(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tvSeriesData = tvSeries.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              TvSeriesDetailPage.ROUTE_NAME,
                                              arguments: tvSeriesData.id,
                                            );
                                          },
                                          // child: Text(
                                          //     tvSeriesData.posterPath ?? "-"),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                                height: 100,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvSeriesData.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                          color: Colors.white,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Image.asset(
                                                              'assets/no_image_1.png',
                                                              fit: BoxFit.cover,
                                                              width: 60,
                                                            ),
                                                          ),
                                                        )),
                                          ),
                                        ),
                                        Text(tvSeriesData.name),
                                        Text(
                                            "Episode : ${tvSeriesData.episodeCount}"),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: tvSeries.seasons.length,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvSeriesBloc,
                                RecommendationTvSeriesState>(
                              builder: (context, state) {
                                if (state is RecommendationTvSeriesLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$BASE_IMAGE_URL${tvSeries.posterPath}',
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
                                } else if (state
                                    is RecommendationTvSeriesError) {
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

  String _formatListDuration(List<int> runtimes) =>
      runtimes.map((runtime) => _showDuration(runtime)).join(", ");
}
