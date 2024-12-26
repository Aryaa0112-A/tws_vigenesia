import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';

import 'EditPage.dart';
import 'Login.dart';
import '../Models/Motivasi_Model.dart';

class MainScreens extends StatefulWidget {
  final String? nama;
  const MainScreens({Key? key, this.nama}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  String baseurl = "http://localhost:8080/vigenesia/";
  var dio = Dio();
  List<MotivasiModel> listproduk = [];
  TextEditingController isiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dio.options.headers['Accept'] = 'application/json';
    _getData();
  }

  Future<List<MotivasiModel>> getData() async {
    try {
      var response = await dio.get(
        '$baseurl/api/Get_motivasi/',
        options: Options(
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => MotivasiModel.fromJson(item)).toList();
      } else {
        print("Error Response: ${response.statusCode} - ${response.data}");
        throw Exception("Gagal memuat data");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> _getData() async {
    try {
      listproduk = await getData();
      setState(() {});
    } catch (e) {
      print("Error saat mengambil data: $e");
    }
  }

  Future<dynamic> sendMotivasi(String isi) async {
    try {
      var formData = FormData.fromMap({
        "isi_motivasi": isi,
      });

      var response = await dio.post(
        "$baseurl/api/dev/POSTmotivasi/",
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Error Response: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error Details: $e");
      return null;
    }
  }

  Future<dynamic> deletePost(String id) async {
    try {
      var formData = FormData.fromMap({"id": id});

      var response = await dio.delete(
        '$baseurl/api/dev/DELETEmotivasi',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
          followRedirects: false,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.data);
      } else {
        print("Error Response: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error Details: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Halo ${widget.nama}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Login()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              FormBuilderTextField(
                controller: isiController,
                name: "isi_motivasi",
                decoration: InputDecoration(
                  labelText: "Masukkan Motivasi",
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.only(left: 10),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (isiController.text.isEmpty) {
                    Flushbar(
                      message: "Motivasi tidak boleh kosong.",
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.redAccent,
                    ).show(context);
                    return;
                  }

                  var result = await sendMotivasi(isiController.text);
                  if (result != null) {
                    Flushbar(
                      message: "Berhasil Submit",
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.greenAccent,
                    ).show(context);
                    _getData();
                    isiController.clear();
                  } else {
                    Flushbar(
                      message: "Gagal mengirim motivasi.",
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.redAccent,
                    ).show(context);
                  }
                },
                child: Text("Submit"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<MotivasiModel>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var item = snapshot.data![index];
                          return Card(
                            margin: EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(item.isiMotivasi ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => EditPage(
                                            id: item.id,
                                            isi_motivasi: item.isiMotivasi,
                                          ),
                                        ),
                                      );
                                      _getData();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      await deletePost(item.id!);
                                      _getData();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(child: Text("No Data Available"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
