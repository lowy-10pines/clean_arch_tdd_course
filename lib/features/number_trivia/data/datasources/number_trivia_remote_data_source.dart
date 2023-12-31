import 'dart:convert';

import 'package:clean_arch_tdd_course/core/error/exceptions.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  /// Calls the http://numbersapi.com/random endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl(this.client);

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) {
    return _getNumberTrivia("/$number");
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() {
    return _getNumberTrivia("/random");
  }

  Future<NumberTriviaModel> _getNumberTrivia(String endpoint) async {
    final response = await client.get(
      Uri.http("numbersapi.com", endpoint),
      headers: {
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(
        json.decode(
          response.body,
        ),
      );
    } else {
      throw ServerException();
    }
  }
}
