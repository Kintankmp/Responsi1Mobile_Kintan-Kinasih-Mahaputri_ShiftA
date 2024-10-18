import 'package:flutter/material.dart';
import '../bloc/wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import '/model/wisata.dart';
import 'wisata_page.dart';

class WisataForm extends StatefulWidget {
  final Wisata? wisata;

  const WisataForm({Key? key, this.wisata}) : super(key: key);

  @override
  _WisataFormState createState() => _WisataFormState();
}

class _WisataFormState extends State<WisataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH EVENT";
  String tombolSubmit = "SIMPAN";
  final _idTextboxController = TextEditingController();
  final _EventTextboxController = TextEditingController();
  final _HargaTextboxController = TextEditingController();
  final _SheetTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.wisata != null) {
      setState(() {
        judul = "UBAH EVENT";
        tombolSubmit = "UBAH";
        _idTextboxController.text = widget.wisata!.id?.toString() ?? '';
        _EventTextboxController.text = widget.wisata!.Event ?? '';
        _HargaTextboxController.text = widget.wisata!.Harga?.toString() ?? '';
        _SheetTextboxController.text = widget.wisata!.Sheet ?? '';
      });
    } else {
      setState(() {
        judul = "TAMBAH EVENT";
        tombolSubmit = "SIMPAN";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.yellow[700], // Warna kuning untuk AppBar
      ),
      body: Container(
        color: Colors.green[300], // Warna hijau untuk latar belakang
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _idTextField(),
                  _EventTextField(),
                  _HargaTextField(),
                  _SheetTextField(),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _idTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "ID",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      controller: _idTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "ID harus diisi";
        }
        return null;
      },
    );
  }

  Widget _EventTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Event",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      controller: _EventTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Event harus diisi";
        }
        return null;
      },
    );
  }

  Widget _HargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.number, // Pastikan ini adalah angka
      controller: _HargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _SheetTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Sheet",
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.text,
      controller: _SheetTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Sheet harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.yellow[700], // Warna kuning untuk tombol
      ),
      child: Text(
        tombolSubmit,
        style: const TextStyle(color: Colors.black), // Teks berwarna hitam
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.wisata != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    // Pastikan Harga diisi dan dikonversi menjadi integer
    int? harga = int.tryParse(_HargaTextboxController.text);
    if (harga == null) {
      // Jika parsing gagal, tampilkan dialog peringatan
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Harga harus berupa angka yang valid.",
        ),
      );
      setState(() {
        _isLoading = false; // Reset loading state
      });
      return; // Hentikan eksekusi
    }

    Wisata createWisata = Wisata(
      id: null,
      Event: _EventTextboxController.text,
      Harga: harga,
      Sheet: _SheetTextboxController.text,
    );

    WisataBloc.addWisata(wisata: createWisata).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const WisataPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    // Pastikan Harga diisi dan dikonversi menjadi integer
    int? harga = int.tryParse(_HargaTextboxController.text);
    if (harga == null) {
      // Jika parsing gagal, tampilkan dialog peringatan
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Harga harus berupa angka yang valid.",
        ),
      );
      setState(() {
        _isLoading = false; // Reset loading state
      });
      return; // Hentikan eksekusi
    }

    Wisata updateWisata = Wisata(
      id: widget.wisata!.id,
      Event: _EventTextboxController.text,
      Harga: harga,
      Sheet: _SheetTextboxController.text,
    );

    WisataBloc.updateWisata(wisata: updateWisata).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const WisataPage(),
        ),
      );
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    }).whenComplete(() {
      setState(() {
        _isLoading = false; // Reset loading state
      });
    });
  }
}
