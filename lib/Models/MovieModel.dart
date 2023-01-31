class MovieModel {
  String? link;
  String? img;
  String? description;
  String? name;

  MovieModel({
    this.link,
    required this.name,
    this.img,
    this.description = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'img': img,
      'description': description,
    };
  }

  MovieModel.fromJson(Map<String, dynamic> Json) {
    link = Json['link'];
    name = Json['name'];
    img = Json['img'];
    description = Json['description'];
  }
}
