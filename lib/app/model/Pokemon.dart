class Pokemon {
  final int id;
  final String name;
  final List<dynamic> abilities;
  final int height;
  final List<dynamic> stats;
  final String defaultImage;

  Pokemon(this.id, this.name, this.abilities, this.height, this.stats,
      this.defaultImage);

  factory Pokemon.fromJson(Map<dynamic, dynamic> json) {
    return Pokemon(json['id'], json['name'], json['abilities'], json['height'],
        json['stats'], json['sprites']['back_default']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["abilities"] = this.abilities;
    data["height"] = this.height;
    data["stats"] = this.stats;
    data["defaultImage"] = this.defaultImage;
  }
}
