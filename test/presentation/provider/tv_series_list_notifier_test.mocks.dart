// Mocks generated by Mockito 5.1.0 from annotations
// in ditonton/test/presentation/provider/tv_series_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_series/tv_series.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_series_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/tv_series/get_now_playing_tv_series.dart'
    as _i4;
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart'
    as _i8;
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart'
    as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvSeriesRepository_0 extends _i1.Fake
    implements _i2.TvSeriesRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetNowPlayingTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingTvSeries extends _i1.Mock
    implements _i4.GetNowPlayingTvSeries {
  MockGetNowPlayingTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TvSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetPopularTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvSeries extends _i1.Mock
    implements _i8.GetPopularTvSeries {
  MockGetPopularTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TvSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}

/// A class which mocks [GetTopRatedTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvSeries extends _i1.Mock
    implements _i9.GetTopRatedTvSeries {
  MockGetTopRatedTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_0()) as _i2.TvSeriesRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>.value(
                      _FakeEither_1<_i6.Failure, List<_i7.TvSeries>>()))
          as _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvSeries>>>);
}
