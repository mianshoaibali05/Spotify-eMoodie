
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify/data/datasources/spotify_service.dart';
import 'package:spotify/data/models/album_model.dart';
import 'package:spotify/data/models/artist_model.dart';

class SpotifySearchController extends GetxController{
  TextEditingController searchEditingController = TextEditingController();
  int selectedIndex = 0;
  final List<String> chipLabels = [
    'Albums',
    'Artists',
  ];
  List<AlbumModel> albumsList = [];
  List<ArtistModel> artistsList = [];

  void switchChip({required int newValue}){
    if(newValue != selectedIndex){
      selectedIndex = newValue;
      update();
    }
  }

  void onSuffixClick(){
    searchEditingController.clear();
    albumsList.clear();
    artistsList.clear();
    update();
  }

  void callApis()async{
    await searchAlbums();
    await searchArtists();
  }

  Future searchArtists()async{
    Map<String, dynamic>? data = await SpotifyService.searchArtists(searchEditingController.text.trim().toString());
    if(data != null){
      List<dynamic> items = data['artists']['items'];
      for(var item in items){
        artistsList.add(ArtistModel.fromJson(item));
      }
      update();
    }
  }

  Future searchAlbums()async{
    Map<String, dynamic>? data = await SpotifyService.searchAlbums(searchEditingController.text.trim().toString());
    if(data != null){
      List<dynamic> items = data['albums']['items'];
      for(var item in items){
        albumsList.add(AlbumModel.fromJson(item));
      }
      update();
    }
  }


}