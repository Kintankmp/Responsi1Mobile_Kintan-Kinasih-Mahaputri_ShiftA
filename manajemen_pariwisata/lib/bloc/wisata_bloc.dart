import 'dart:convert';
import 'package:manajemen_pariwasata/helpers/api.dart';
import 'package:manajemen_pariwasata/helpers/api_url.dart';
import 'package:manajemen_pariwasata/model/wisata.dart';
class WisataBloc {
  static Future<List<Wisata>> getWisata() async {
    String apiUrl = ApiUrl.listWisata;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> listWisata = (jsonObj as Map<String, dynamic>)['data'];
    List<Wisata> wisata = [];
    for (int i = 0; i < listWisata.length; i++) {
      wisata.add(Wisata.fromJson(listWisata[i]));
    }
    return wisata;
  }

  static Future addWisata({Wisata? wisata}) async {
    String apiUrl = ApiUrl.createWisata;
    var body = {
      "id": wisata!.id,
      "Event": wisata.Event,
      "Harga": wisata.Harga,
      "Sheet": wisata.Sheet,
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateWisata({required Wisata wisata}) async {
    String apiUrl = ApiUrl.updateWisata(wisata.id!);
    print(apiUrl);
    var body = {
      "id": wisata!.id,
      "Event": wisata.Event,
      "Harga": wisata.Harga,
      "Sheet": wisata.Sheet,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteWisata({int? id}) async {
    String apiUrl = ApiUrl.deleteWisata(id!);
    var response = await Api().delete(apiUrl);

    if (response != null && response.body.isNotEmpty) {
      var jsonObj = json.decode(response.body);
      return jsonObj['status'] == true;
    } else {
      return false;
    }
  }
}
