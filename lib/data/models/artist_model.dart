

import 'package:spotify/data/models/Images_model.dart';
import 'package:spotify/data/models/external_urls.dart';

class ArtistModel {
  ExternalUrls externalUrls = ExternalUrls();
  List<String> genres = [];
  String href = '';
  String id = '';
  List<ImagesModel> images = [];
  String name = '';
  int popularity = 0;
  String type = '';
  String uri = '';

  ArtistModel.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null ? ExternalUrls.fromJson(json['external_urls']) : ExternalUrls();
    if (json.containsKey('genres') && json['genres'] != null) {
      genres = json['genres'].cast<String>();
    }
    href = json['href'] ?? '';
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    if (json.containsKey('images') && json['images'] != null) {
      images = <ImagesModel>[];
      json['images'].forEach((v) {
        images.add(ImagesModel.fromJson(v));
      });
    }
    type = json['type'] ?? '';
    uri = json['uri'] ?? '';
  }
}