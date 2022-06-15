import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/movie/movie_table.dart';
import 'package:ditonton/data/models/tv_series/season_model.dart';
import 'package:ditonton/data/models/tv_series/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series/tv_series_model.dart';
import 'package:ditonton/data/models/tv_series/tv_series_response.dart';
import 'package:ditonton/data/models/tv_series/tv_series_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_series/tv_series.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

final testTvSeriesModel = TvSeriesModel(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Halo",
    overview:
        "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 7348.55,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.7,
    voteCount: 472);

final testTvSeriesModelList = <TvSeriesModel>[testTvSeriesModel];

final testTvSeries = testTvSeriesModel.toEntity();

final testTvSeriesList = <TvSeries>[testTvSeries];

final testTvSeriesResponse = TvSeriesResponse(
    results: testTvSeriesModelList, page: 1, totalPages: 1, totalResults: 1);

final testTvSeriesDetailResponse = TvSeriesDetailModel(
  adult: false,
  backdropPath: '',
  genres: [GenreModel(id: 1, name: 'Action')],
  id: 2,
  episodeRunTime: [],
  homepage: "https://google.com",
  numberOfEpisodes: 34,
  name: 'name',
  numberOfSeasons: 2,
  originalLanguage: 'en',
  originalName: 'name',
  overview: 'overview',
  popularity: 12.323,
  posterPath: '',
  seasons: [
    SeasonModel(
      airDate: '',
      episodeCount: 7,
      id: 1,
      name: 'Winter',
      overview: 'overview',
      posterPath: 'posterPath',
      seasonNumber: 2,
    )
  ],
  status: 'status',
  tagline: 'tagline',
  type: 'Scripted',
  voteAverage: 3,
  voteCount: 3,
);

final testTvSeriesDetailResponseEntity = testTvSeriesDetailResponse.toEntity();

final testTvSeriesTable =
    TvSeriesTable.fromEntity(testTvSeriesDetailResponseEntity);

final testTvSeriesTableList = <TvSeriesTable>[testTvSeriesTable];

final testWatchlistTvSeries = [testTvSeriesTable.toEntity()];

final testTvSeriesMaping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTvSeriesDetail = TvSeriesDetailModel(
  adult: false,
  popularity: 1,
  posterPath: 'posterPath',
  name: 'name',
  type: 'type',
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  seasons: [],
  episodeRunTime: [1],
  genres: [],
  id: 1,
  overview: 'overview',
  voteCount: 1,
  tagline: 'tagline',
  originalName: 'originalName',
  homepage: 'homepage',
  voteAverage: 1,
  originalLanguage: 'originalLanguage',
  backdropPath: 'backdropPath',
  status: 'status',
);

final testTvSeriesDetailEntity = testTvSeriesDetail.toEntity();
final testTvSeriesMap = testTvSeriesDetail.toJson();

//seasons
final testSeasonTvSeriesModel = SeasonModel(
  id: 1,
  name: 'season',
  posterPath: 'poster',
  episodeCount: 2,
  seasonNumber: 2,
  airDate: '',
  overview: '',
);

final testSeason = testSeasonTvSeriesModel.toEntity();

final testSeasonMap = testSeasonTvSeriesModel.toJson();
