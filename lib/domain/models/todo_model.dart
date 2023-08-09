class Todo {
  int id;
  String title;

 

  Todo({
    required this.id,
    required this.title,

   
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
    id: json['id'] as int,
    title: json['title'] as String,

 
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,


  };

  @override
  String toString() {
    return 'Todo{id: $id, title: $title ';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
              runtimeType == other.runtimeType &&
              id == other.id ;

  @override
  int get hashCode => id;
}
