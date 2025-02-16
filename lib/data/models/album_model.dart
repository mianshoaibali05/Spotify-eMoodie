
import 'package:spotify/data/models/Images_model.dart';
import 'package:spotify/data/models/artist_model.dart';
import 'package:spotify/data/models/external_urls.dart';

class AlbumModel{
  String albumType = '';
  int totalTracks = 0;
  bool isPlayable = false;
  ExternalUrls externalUrls = ExternalUrls();
  String href = '';
  String id = '';
  List<ImagesModel> images = [];
  String name = '';
  String releaseDate = '';
  String releaseDatePrecision = '';
  String type = '';
  String uri = '';
  List<ArtistModel> artists = [];

  AlbumModel.fromJson(Map<String, dynamic> json) {
    albumType = json['album_type'] ?? '';
    totalTracks = json['total_tracks'] ?? 0;
    isPlayable = json['is_playable'] ?? false;
    externalUrls = json['external_urls'] != null
        ? ExternalUrls.fromJson(json['external_urls'])
        : ExternalUrls();
    href = json['href'] ?? '';
    id = json['id'] ?? '';
    if (json['images'] != null) {
      images = <ImagesModel>[];
      json['images'].forEach((v) {
        images.add(ImagesModel.fromJson(v));
      });
    }
    name = json['name'] ?? '';
    releaseDate = json['release_date'] ?? '';
    releaseDatePrecision = json['release_date_precision'] ?? '';
    type = json['type'] ?? '';
    uri = json['uri'] ?? '';
    if (json['artists'] != null) {
      artists = <ArtistModel>[];
      json['artists'].forEach((v) {
        artists.add(ArtistModel.fromJson(v));
      });
    }
  }

  String get getArtistsName{
    List<String> nameList = [];
    for(var artistName in artists){
      nameList.add(artistName.name);
    }
    String name = nameList.join(", ");
    return name;
  }
}