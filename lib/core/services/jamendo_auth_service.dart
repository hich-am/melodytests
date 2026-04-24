import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JamendoAuthService {
  static const clientId = 'ad40341f';
  static const clientSecret = 'b08521241f68004684199a0052962554';
  static const redirectUri = 'melodyapp://callback';

  Future<String?> login() async {
    try {
      final url = 'https://api.jamendo.com/v3.0/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code';
      
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: 'melodyapp',
      );

      final code = Uri.parse(result).queryParameters['code'];
      if (code == null) return null;

      final response = await http.post(
        Uri.parse('https://api.jamendo.com/v3.0/oauth/grant'),
        body: {
          'grant_type': 'authorization_code',
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': code,
          'redirect_uri': redirectUri,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['access_token'];
      }
    } catch (e) {
      print('Auth error: $e');
    }
    return null;
  }
}
