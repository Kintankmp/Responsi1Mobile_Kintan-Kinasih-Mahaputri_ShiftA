import 'package:flutter/material.dart';
import '../bloc/logout_bloc.dart';
import '../bloc/wisata_bloc.dart';
import '/model/wisata.dart';
import '/ui/wisata_detail.dart';
import '/ui/wisata_form.dart';
import 'login_page.dart';

class WisataPage extends StatefulWidget {
  const WisataPage({Key? key}) : super(key: key);

  @override
  _WisataPageState createState() => _WisataPageState();
}

class _WisataPageState extends State<WisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700], // Warna hijau untuk app bar
        title: const Text(
          'List Event',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 24.0,
            color: Colors.black, // Warna teks hitam untuk kontras
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.black), // Ikon hitam untuk kontras
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WisataForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      ),
                    });
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.green[700], // Latar belakang hijau muda untuk seluruh body
        child: FutureBuilder<List>(
          future: WisataBloc.getWisata(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListWisata(
                    list: snapshot.data,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}

class ListWisata extends StatelessWidget {
  final List? list;

  const ListWisata({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemWisata(
          wisata: list![i],
        );
      },
    );
  }
}

class ItemWisata extends StatelessWidget {
  final Wisata wisata;

  const ItemWisata({Key? key, required this.wisata}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WisataDetail(wisata: wisata),
          ),
        );
      },
      child: Card(
        color: Colors.green[50], // Warna hijau muda untuk latar belakang kartu
        elevation: 5.0, // Sedikit elevasi untuk efek bayangan
        child: ListTile(
          title: Text(
            wisata.Event!,
            style: const TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 18.0,
              color: Colors.black, // Warna teks hitam untuk kontras
            ),
          ),
          subtitle: Text(
            wisata.Harga?.toString() ?? 'Harga tidak tersedia', // Menangani kemungkinan null
            style: const TextStyle(color: Colors.black54),
          ),
          trailing: Text(
            wisata.Sheet!,
            style: const TextStyle(color: Colors.black87), // Hitam lebih gelap untuk teks atraksi
          ),
        ),
      ),
    );
  }
}
