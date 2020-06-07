class Task {

  final String title;
  final String description;
  final DateTime deadLine;
  final bool done;


  Task({this.title, this.description, this.deadLine, this.done});

    Map<String, Object> toJson() {
    return {
      "title": this.title, 
      "description": this.description, 
      "deadLine": this.deadLine, 
      "done": this.done
    };
  }

  static fromJson(Map<String, Object> json) {
    return Task(
      title: json["title"], 
      description: json["description"], 
      deadLine: json["deadLine"],
      done: json["done"]
    );
  }

  
}