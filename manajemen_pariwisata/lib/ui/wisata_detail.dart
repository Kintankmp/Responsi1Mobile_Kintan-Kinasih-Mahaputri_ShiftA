import 'package:flutter/material.dart';
import '../bloc/wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/wisata.dart';
import 'wisata_form.dart';
import 'wisata_page.dart';

// ignore: must_be_immutable
class WisataDetail extends StatefulWidget {
  Wisata? wisata;

  WisataDetail({Key? key, this.wisata}) : super(key: key);

  @override
  _WisataDetailState createState() => _WisataDetailState();
}

class _WisataDetailState extends State<WisataDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Wisata'),
        backgroundColor: Colors.yellow, // Warna hijau untuk AppBar
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding untuk tata letak yang lebih rapi
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Posisi di tengah layar
            children: [
              Text(
                "ID: ${widget.wisata!.id}",
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              const SizedBox(height: 8.0), // Jarak antar elemen
              Text(
                "Event: ${widget.wisata!.Event}", // Akses properti event dari model Wisata
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              const SizedBox(height: 8.0), // Jarak antar elemen
              Text(
                "Harga: ${widget.wisata!.Harga}", // Perbaikan string interpolasi
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                "Sheet: ${widget.wisata!.Sheet}", // Akses properti sheet dari model Wisata
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16.0), // Jarak lebih besar untuk tombol
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.green[700], // Warna hijau untuk tombol edit
          ),
          child: const Text(
            "EDIT",
            style: TextStyle(color: Colors.white), // Teks berwarna putih
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WisataForm(
                  wisata: widget.wisata!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8.0), // Jarak antara tombol
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red[700], // Warna merah untuk tombol hapus
          ),
          child: const Text(
            "DELETE",
            style: TextStyle(color: Colors.white), // Teks berwarna putih
          ),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.red[700], // Warna merah untuk konfirmasi hapus
          ),
          child: const Text(
            "Ya",
            style: TextStyle(color: Colors.white), // Teks berwarna putih
          ),
          onPressed: () {
            // Pastikan id adalah string
            WisataBloc.deleteWisata(id: widget.wisata!.id!).then(
              (value) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WisataPage(),
                  ),
                );
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.grey, // Warna abu-abu untuk batal
          ),
          child: const Text(
            "Batal",
            style: TextStyle(color: Colors.white), // Teks berwarna putih
          ),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
