import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/data/datasources/auth_service.dart';
import 'package:spotify/utils/utils.dart';


class SpotifyService{
  static const String baseUrl = "https://api.spotify.com/v1";

  static Future<Map<String, dynamic>?> searchAlbums(String query) async {
    try{
      Utils.showLoader();
      String? token = await AuthService.getStoredToken();
      if(token == null){
        Utils.hideLoader();
      }
      if (token == null) return null;
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=$query&type=album&market=US&limit=20'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Utils.hideLoader();
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error fetching artist: ${response.body}");
        return null;
      }
    }catch(e){
      print(e);
      Utils.hideLoader();
      return null;
    }
  }

  static Future<Map<String, dynamic>?> searchArtists(String query) async {
    try{
      Utils.showLoader();
      String? token = await AuthService.getStoredToken();
      if(token == null){
        Utils.hideLoader();
      }
      if (token == null) return null;
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=$query&type=artist&market=US&limit=20'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Utils.hideLoader();
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error fetching artist: ${response.body}");
        return null;
      }
    }catch(e){
      print(e);
      Utils.hideLoader();
      return null;
    }
  }
}