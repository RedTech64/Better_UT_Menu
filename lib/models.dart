class Meal {
  final String name;
  final String dateString;
  final List<Line> lines;

  Meal({this.name, this.dateString, this.lines});

  factory Meal.fromJSON(Map<String, dynamic> json) => Meal(
    name: json['name'],
    dateString: json['dateString'],
    lines: json['lines'].map((lineJson) => Line.fromJSON(lineJson)).toList().cast<Line>()
  );
}

class Line {
  final String name;
  final List<MenuItem> items;

  Line({this.name, this.items});

  factory Line.fromJSON(Map<String, dynamic> json) => Line(
    name: json['name'],
    items: json['items'].map((itemJson) => MenuItem.fromJSON(itemJson)).toList().cast<MenuItem>()
  );
}

class MenuItem {
  final String name;
  final num calories;
  final List<String> tags;

  MenuItem({
    this.name,
    this.calories,
    this.tags
  });

  factory MenuItem.fromJSON(Map<String, dynamic> json) => MenuItem(
    name: json['name'],
    calories: json['calories'],
    tags: json['tags'].cast<String>()
  );
}