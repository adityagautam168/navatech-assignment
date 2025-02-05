class StringConstants {
  static String get baseUrl => 'https://jsonplaceholder.typicode.com';
}

class ApiEndpoints {
  // TODO(Aditya): Setting limit of 20 as of now, need to paginate it possible
  static String get albumsList => '/albums?_start=0&_limit=20';
  static String photosList(int albumId) => '/photos?albumId=$albumId';
}
