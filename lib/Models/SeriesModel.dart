class SeriesModel {
  String? img;
  String? description;
  String? name;
  String? dateTime;
  Map<String, dynamic>? links;

  SeriesModel(
      {this.links,
      required this.name,
      this.img,
      this.description = "",
      this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'links': links,
      'img': img,
      'description': description,
      'dateTime': dateTime,
    };
  }

  SeriesModel.fromJson(Map<String, dynamic> Json) {
    name = Json['name'];
    img = Json['img'];
    description = Json['description'];
    dateTime = Json['dateTime'];
    links = Json['links'];
  }

  ///from sql
  SeriesModel.fromJsonDB(Map<String, dynamic> Json) {
    name = Json['name'];
    img = Json['img'];
    description = Json['description'];
    links = {};
  }
}
