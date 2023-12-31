import 'dart:convert';

import 'package:clean_arch_tdd_course/core/error/exceptions.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  void setUpMockHTTPSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture("trivia.json"), 200),
    );
  }

  void setUpMockHttpFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response("Something went wrong", 404),
    );
  }

  group('#getConcreteNumberTrivia', () {
    const int tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia.json")));
    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHTTPSuccess200();
      // act
      dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(
        mockHttpClient.get(
          Uri.http("numbersapi.com", "/$tNumber"),
          headers: {
            'content-type': 'application/json',
          },
        ),
      );
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHTTPSuccess200();
      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = dataSource.getConcreteNumberTrivia;
      // assert
      expect(
        () => call(tNumber),
        throwsA(
          const TypeMatcher<ServerException>(),
        ),
      );
    });
  });

  group('#getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia.json")));
    test(
        'should perform a GET request on a URL with random being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHTTPSuccess200();
      // act
      dataSource.getRandomNumberTrivia();
      // assert
      verify(
        mockHttpClient.get(
          Uri.http("numbersapi.com", "/random"),
          headers: {
            'content-type': 'application/json',
          },
        ),
      );
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHTTPSuccess200();
      // act
      final result = await dataSource.getRandomNumberTrivia();

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code is not 200',
        () async {
      // arrange
      setUpMockHttpFailure404();
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(
        () => call(),
        throwsA(
          const TypeMatcher<ServerException>(),
        ),
      );
    });
  });
}
