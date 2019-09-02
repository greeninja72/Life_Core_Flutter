import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String pid;
  final String language;
  final int water;
  final int filter;
  final bool notify;

  Post(
      {this.id, this.pid, this.language, this.water, this.filter, this.notify});

  factory Post.fromjson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      pid: json['pid'],
      language: json['language'],
      water: json['water'],
      filter: json['filter'],
      notify: json['notify'],
    );
  }
}

Future<Post> fetchPost(String str) async {
  final response = await http.get(
      'http://ec2-3-15-217-14.us-east-2.compute.amazonaws.com:3000/users/' +
          str);

  if (response.statusCode == 200) {
    return Post.fromjson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load post');
  }
}
