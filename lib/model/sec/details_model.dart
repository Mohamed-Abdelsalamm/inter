class Details {
  late int id;
  late String title;
  late String image;
  late String instructions;

  Details({
    required this.id,
    required this.title,
    required this.image,
    required this.instructions,
  });

  Details.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.image = map['image'];
    this.instructions = map['instructions'];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      'id' : this.id,
      'title' :this.title,
      'image' :this.image,
      'instructions' :this.instructions,
    };
    return map;
  }
}
