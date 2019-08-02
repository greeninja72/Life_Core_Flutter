import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String pid;
  final int water;
  final bool notify;

  Post({this.id, this.pid, this.water, this.notify});

  factory Post.fromjson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      pid: json['pid'],
      water: json['water'],
      notify: json['notify'],
    );
  }
}

Future<Post> fetchPost(String str) async {
  final response = await http.post(
    'http://ec2-3-14-69-10.us-east-2.compute.amazonaws.com:3000/users/' + str,
  );

  if (response.statusCode == 200) {
    return Post.fromjson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load post');
  }
}
