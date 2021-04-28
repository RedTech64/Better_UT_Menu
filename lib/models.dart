class Location {
  final String id;
  final String name;
  final List<String> mealNames;

  Location({this.id, this.name, this.mealNames});

  factory Location.fromJSON(Map<String, dynamic> json) => Location(
    id: json['id'],
    name: json['name'],
    mealNames: json['mealNames'].cast<String>()
  );
}

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
  final num carbs;
  final num fat;
  final num protein;
  final num sugars;
  final String factsLink;
  final List<String> tags;

  MenuItem({
    this.name,
    this.calories,
    this.carbs,
    this.fat,
    this.protein,
    this.sugars,
    this.tags,
    this.factsLink
  });

  factory MenuItem.fromJSON(Map<String, dynamic> json) => MenuItem(
    name: json['name'],
    calories: json['calories'],
    carbs: json['carbs'],
    fat: json['fat'],
    protein: json['protein'],
    sugars: json['sugars'],
    factsLink: json['factsLink'],
    tags: json['tags'].cast<String>()
  );
}