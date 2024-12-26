import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';

class EditPage extends StatefulWidget {
  final String? id;
  final String? isi_motivasi;
  const EditPage({Key? key, this.id, this.isi_motivasi}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String baseurl =
      "http://localhost:8080/vigenesia/"; // Ganti dengan IP/backend Anda
  var dio = Dio();

  Future<dynamic> putPost(String isi_motivasi, String ids) async {
    try {
      Map<String, dynamic> data = {"isi_motivasi": isi_motivasi, "id": ids};
      var response = await dio.put(
        '$baseurl/api/dev/PUTmotivasi',
        data: data,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception("Gagal mengupdate data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  TextEditingController isiMotivasiC = TextEditingController();

  @override
  void initState() {
    super.initState();
    isiMotivasiC.text = widget.isi_motivasi ?? ''; // Set nilai awal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Data Sebelumnya: ${widget.isi_motivasi}"),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: FormBuilderTextField(
                  name: "isi_motivasi",
                  controller: isiMotivasiC,
                  decoration: InputDecoration(
                    labelText: "Data Baru",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  putPost(isiMotivasiC.text, widget.id.toString())
                      .then((value) {
                    if (value != null) {
                      Navigator.pop(context);
                      Flushbar(
                        message:
                            "Berhasil Update, Refresh untuk Melihat Perubahan",
                        duration: Duration(seconds: 5),
                        backgroundColor: Colors.green,
                        flushbarPosition: FlushbarPosition.TOP,
                      ).show(context);
                    }
                  });
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
