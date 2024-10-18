class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/';
  static const String registrasi = baseUrl + 'api/registrasi';
  static const String login = baseUrl + 'api/login';
  static const String listWisata = baseUrl + 'api/pariwisata/destinasi_wisata';
  static const String createWisata =
      baseUrl + 'api/pariwisata/destinasi_wisata';
  static String updateWisata(int id) {
    return baseUrl +
        'api/pariwisata/destinasi_wisata/' +
        id.toString() +
        '/update';
  }

  static String showWisata(int id) {
    return baseUrl + 'api/pariwisata/destinasi_wisata/' + id.toString();
  }

  static String deleteWisata(int id) {
    return baseUrl +
        'api/pariwisata/destinasi_wisata/' +
        id.toString() +
        '/delete';
  }
}
