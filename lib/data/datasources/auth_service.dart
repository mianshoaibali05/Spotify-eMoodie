import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String clientId = "3af8e17840684c5bb3325a5e8b8e808d";
  static const String clientSecret = "e46b037b7f76416ca7e3ac9676f557f7";
  static const String tokenUrl = "https://accounts.spotify.com/api/token";

  static Future<String?> fetchAccessToken() async {
    try {
      var response = await http.post(
        Uri.parse(tokenUrl),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic ${base64Encode(utf8.encode("$clientId:$clientSecret"))}",
        },
        body: "grant_type=client_credentials",
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String accessToken = data["access_token"];
        int expiresIn = data["expires_in"];
        await saveToken(accessToken, expiresIn);
        return accessToken;
      } else {
        print("Error getting token: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error fetching token: $e");
      return null;
    }
  }

  static Future<void> saveToken(String token, int expiresIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", token);
    await prefs.setInt("expiry_time", DateTime.now().millisecondsSinceEpoch + (expiresIn * 1000));
  }

  static Future<String?> getStoredToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    int? expiryTime = prefs.getInt("expiry_time");

    if (token != null && expiryTime != null) {
      if (DateTime.now().millisecondsSinceEpoch < expiryTime) {
        return token;
      } else {
        print("Token expired, refreshing...");
        return await fetchAccessToken();
      }
    }
    return await fetchAccessToken();
  }
}