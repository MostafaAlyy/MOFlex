class MovieModel {
  String? link;
  String? link2;
  String? link3;
  String? img;
  String? description;
  String? name;
  String? dateTime;

  MovieModel(
      {this.link,
      this.link2,
      this.link3,
      required this.name,
      this.img,
      this.description = "",
      this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'link': link,
      'link2': link2,
      'link3': link3,
      'img': img,
      'description': description,
      'dateTime': dateTime,
    };
  }

  MovieModel.fromJson(Map<String, dynamic> Json) {
    link = Json['link'];
    link2 = Json['link2'];
    link3 = Json['link3'];
    name = Json['name'];
    img = Json['img'];
    description = Json['description'];
    dateTime = Json['dateTime'];
  }
}
