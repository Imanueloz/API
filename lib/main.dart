import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const PostApi());
}

class PostApi extends StatefulWidget {
  const PostApi({super.key});

  @override
  State<PostApi> createState() => _PostApiState();
}

class _PostApiState extends State<PostApi> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  String display = "Belum ada data";
  String url = 'https://reqres.in/api/users/2';

  Future<void> postData() async {
    var response =
        await http.post(Uri.parse('https://reqres.in/api/users'), body: {
      'first_name': controllerName.text,
      'email': controllerEmail.text,
    });
    Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    setState(() {
      display = "Name : ${data['first_name']} \n Email : ${data['email']}";
    });
  }

  Future<void> fetchData() async {
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        display =
            "Name : ${data['data']['first_name']} \n Email : ${data['data']['email']}";
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> updateData() async {
    var response = await http.put(Uri.parse(url), body: {
      'first_name': controllerName.text,
      'email': controllerEmail.text,
    });
    Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;
    setState(() {
      display = "Name : ${data['first_name']} \n Email : ${data['email']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    display,
                    style: const TextStyle(fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: controllerName,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
              ),
              TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  postData();
                  updateData();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class DeleteApi extends StatefulWidget {
  const DeleteApi({super.key});

  @override
  State<DeleteApi> createState() => _DeleteAPIState();
}

class _DeleteAPIState extends State<DeleteApi> {
  String display = "Belum ada data";
  String url = 'https://reqres.in/api/users/2';

  Future<void> fetchData() async {
    final http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data =
          jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        display =
            "Name : ${data['data']['first_name']} \n Email : ${data['data']['email']}";
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> deleteData() async {
    var response =
        await http.delete(Uri.parse('https://reqres.in/api/users/2'));

    setState(() {
      display = response.statusCode.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        display,
                        style: const TextStyle(fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      deleteData();
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
