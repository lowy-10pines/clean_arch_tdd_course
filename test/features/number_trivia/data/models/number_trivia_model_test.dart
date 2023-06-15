import 'dart:convert';

import 'package:clean_arch_tdd_course/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_arch_tdd_course/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel("Test trivia on test", 1);

  test("should be a subclass of NumberTrivia", () {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test("should return a valid model when the JSON number is an integer", () {
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test("should return a valid model when the JSON model is a double", () {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("trivia_double.json"));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });
}
