class NumberTrivia {
  final String text;
  final int number;

  NumberTrivia(this.text, this.number);

  @override
  bool operator ==(Object other) {
    return other is NumberTrivia &&
        other.number == number &&
        other.text == text;
  }

  @override
  int get hashCode => text.hashCode + number.hashCode + super.hashCode;
}
