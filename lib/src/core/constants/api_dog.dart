import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiDogConstants {
  static final String baseApiUrl = "${dotenv.env['API_URL']}/v1";
  static final String apiKey = '${dotenv.env['API_KEY']}';
}
