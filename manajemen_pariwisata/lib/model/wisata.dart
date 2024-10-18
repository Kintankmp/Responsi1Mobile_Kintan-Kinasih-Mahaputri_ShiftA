class Wisata {
  int? id;
  String? Event;
  int? Harga;
  String? Sheet;
  Wisata({this.id, this.Event, this.Harga, this.Sheet});
  factory Wisata.fromJson(Map<String, dynamic> obj) {
    return Wisata(
        id: obj['id'],
        Event: obj['Event'],
        Harga: obj['Harga'],
        Sheet: obj['Sheet']);
  }
}
