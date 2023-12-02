import 'package:http/http.dart' as http;
import 'dart:convert';

class Person {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Person({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Person.fromMap(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int,
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}

Future<List<Person>> fetchData() async {
  final response =
      await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data =
        jsonDecode(response.body) as Map<String, dynamic>;

    List<dynamic> dataPerson = data['data'] as List;
    return dataPerson.map((e) => Person.fromMap(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

late Future<List<Person>> listPerson;
