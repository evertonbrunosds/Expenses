class Day {
  String name;
  double value;

  Day({required this.name, required this.value});

  // Getters
  String get getName => name;
  double get getValue => value;

  // Setters
  set setName(final String name) {
    this.name = name;
  }

  set setValue(final double value) {
    this.value = value;
  }
}
