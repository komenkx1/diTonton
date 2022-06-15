import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/bloc/movie/bloc/search_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_series/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/presentation/widgets/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                context.read<SearchBloc>().add(OnQueryChanged(query));
                context
                    .read<SearchTvSeriesBloc>()
                    .add(OnQueryChangedTvSeries(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                      if (state is SearchLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchHasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Movies',
                              style: kHeading6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final movies = state.result;
                                return CardList(
                                  dataList: movies[index],
                                  isTvSeries: false,
                                );
                              },
                              itemCount: state.result.length,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            // Text(
                            //   'Movie',
                            //   style: kHeading6,
                            // ),
                            // ListView.builder(
                            //   shrinkWrap: true,
                            //   physics: NeverScrollableScrollPhysics(),
                            //   padding: const EdgeInsets.all(8),
                            //   itemBuilder: (context, index) {
                            //     final movie = data.searchResult[index];
                            //     return CardList(
                            //       dataList: movie,
                            //     );
                            //   },
                            //   itemCount: resultMovie.length,
                            // ),
                          ],
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
                      }
                    }),
                    SizedBox(
                      height: 16,
                    ),
                    BlocBuilder<SearchTvSeriesBloc, SearchTvSeriesState>(
                        builder: (context, state) {
                      if (state is SearchTvSeriesLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is SearchTvSeriesHasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tv Series',
                              style: kHeading6,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(8),
                              itemBuilder: (context, index) {
                                final tvSeries = state.result[index];
                                return CardList(
                                  dataList: tvSeries,
                                  isTvSeries: true,
                                );
                              },
                              itemCount: state.result.length,
                            ),
                          ],
                        );
                      } else if (state is SearchTvSeriesError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
