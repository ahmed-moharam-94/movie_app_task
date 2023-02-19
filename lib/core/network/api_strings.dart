class ApiStrings {
  // movie db apis
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = 'e664eac271c82657547af1edc1fd33b4';
  static const String popularMoviesPath =
      '$baseUrl/movie/popular?api_key=$apiKey';

  static const String noImageFound =
      'https://upload.wikimedia.org/wikipedia/commons/d/d1/Image_not_available.png';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) {
    return path.isEmpty ? noImageFound : '$imageBaseUrl/$path';
  }

  static String movieDetailsPath(int movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey';

  // push notification apis
  static String fcmPath = 'https://fcm.googleapis.com/fcm/send';
  static String fcmServer =
      'AAAAG32P2MA:APA91bG9nwPKV0sWg1f_RKsMIRUJmMIduL4NA7s1h1fUhHJyw-YRqk5v66xUP4mw8uHTSRUkxyXg317SA03EP0xW_BteALKkvVSGZ05FZbND0SoaOXcRfr6OyrdPzYM2XERV7wp-5F9a';

}
