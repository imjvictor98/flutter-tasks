class User {
  final String name;

  User({this.name});

  Map<String, Object> toJson() {
    return {"name": this.name};
  }

  static fromJson(Map<String, Object> json) {
    return User(name: json["name"]);
  }
}
