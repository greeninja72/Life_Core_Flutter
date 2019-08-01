
class Post {
  final int id;
  final String pid;
  final int water;
  final bool notify;

  Post({this.id, this.pid, this.water, this.notify});

  Post.fromjson(Map<String, dynamic> json)
}
