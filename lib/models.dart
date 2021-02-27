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
  final int calories;
  final bool beef;
  final bool liteBites;
  final bool milk;
  final bool pork;
  final bool shellfish;
  final bool soy;
  final bool treeNuts;
  final bool vegan;
  final bool veggie;
  final bool wheat;

  MenuItem({
    this.name,
    this.calories,
    this.beef,
    this.liteBites,
    this.milk,
    this.pork,
    this.shellfish,
    this.soy,
    this.treeNuts,
    this.vegan,
    this.veggie,
    this.wheat
  });

  factory MenuItem.fromJSON(Map<String, dynamic> json) => MenuItem(
    name: json['name'],
    calories: json['calories'],
    beef: json['beef'] ?? false,
    liteBites: json['liteBites'] ?? false,
    milk: json['milk'] ?? false,
    pork: json['pork'] ?? false,
    shellfish: json['shellfish'] ?? false,
    soy: json['soy'] ?? false,
    treeNuts: json['treeNuts'] ?? false,
    vegan: json['vegan'] ?? false,
    veggie: json['veggie'] ?? false,
    wheat: json['wheat'] ?? false
  );
}