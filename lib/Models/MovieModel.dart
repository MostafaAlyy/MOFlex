class MovieModel {
  String? link;
  String? img;
  String? description;
  String? name;
  String? dateTime;

  MovieModel(
      {this.link,
      required this.name,
      this.img,
      this.description = "",
      this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'img': img,
      'description': description,
      'dateTime': dateTime,
    };
  }

  MovieModel.fromJson(Map<String, dynamic> Json) {
    link = Json['link'];
    name = Json['name'];
    img = Json['img'];
    description = Json['description'];
    dateTime = Json['dateTime'];
  }
}
