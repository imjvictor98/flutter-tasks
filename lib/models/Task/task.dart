class Task {
  final int id;
  final String title;
  final String description;
  final DateTime deadLine;
  final bool done;


  Task({this.id, this.title, this.description, this.deadLine, this.done});

    Map<String, Object> toJson() {
    return {
      "id": this.id,
      "title": this.title, 
      "description": this.description, 
      "deadLine": this.deadLine, 
      "done": this.done
    };
  }

  static fromJson(Map<String, Object> json) {
    return Task(
      id: json["id"],
      title: json["title"], 
      description: json["description"], 
      deadLine: json["deadLine"],
      done: json["done"]
    );
  }

  
}