import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Manabata/requests.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  late List<PostData> posts;

  @override
  void initState() {
    super.initState();
    posts = [];
    loadPosts(refresh: false);
  }

  Future<void> loadPosts({bool refresh = true}) async {
    String postEmergencyRaw = json.encode(await API.getPostRegular( refresh: refresh));
    Map<String, dynamic> postEmergency = json.decode(postEmergencyRaw)['data'];

    final List<PostData> newPosts = postEmergency.entries
        .map((entry) => PostData.fromJson(entry.key, entry.value))
        .toList();

    setState(() {
      posts = newPosts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: loadPosts,
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return CardWidget(
              postId: posts[index].postId,
              title: posts[index].title,
              content: posts[index].content,
              bloodGroup: posts[index].bloodGroup,
              country: posts[index].country,
              state: posts[index].state,
              city: posts[index].city,
              createTs: posts[index].createTs,
              urgencyLevel: posts[index].urgencyLevel,
              username: posts[index].username,
              area: posts[index].area,
            );
          },
        ),
      ),
    );
  }
}

class PostData {
  final String postId;
  final String content;
  final String createTs;
  final String country;
  final String urgencyLevel;
  final String title;
  final String bloodGroup;
  final String state;
  final String city;
  final String username;
  final String area;

  PostData({
    required this.postId,
    required this.content,
    required this.createTs,
    required this.country,
    required this.urgencyLevel,
    required this.title,
    required this.bloodGroup,
    required this.state,
    required this.city,
    required this.username,
    required this.area,
  });

  factory PostData.fromJson(String postId, Map<String, dynamic> json) {
    return PostData(
      postId: postId,
      content: json['content'],
      createTs: json['create_ts'],
      country: json['country'],
      urgencyLevel: json['urgency_level'],
      title: json['title'],
      bloodGroup: json['blood_group'],
      state: json['state'],
      city: json['city'],
      username: json['username'],
      area: json['area'],
    );
  }
}

class CardWidget extends StatelessWidget {
  final String postId;
  final String content;
  final String createTs;
  final String country;
  final String urgencyLevel;
  final String title;
  final String bloodGroup;
  final String state;
  final String city;
  final String username;
  final String area;
  List<DataRow> rows = [];

  CardWidget({
    super.key,
    required this.postId,
    required this.content,
    required this.createTs,
    required this.country,
    required this.urgencyLevel,
    required this.title,
    required this.bloodGroup,
    required this.state,
    required this.city,
    required this.username,
    required this.area,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.purple.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              'A post by $username',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            subtitle: Text(createTs),
            leading: CircleAvatar(
                backgroundColor: Colors.red.shade300,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 32.0,
                  semanticLabel: 'Profile Picture of the user',
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Title: $title"),
                const SizedBox(height: 5),
                Text("Content: $content"),
                const SizedBox(height: 10),
                Text("Blood Group: $bloodGroup"),
                const SizedBox(height: 10),
                const Text("Address:"),
                const SizedBox(height: 5),
                Text("      Country: $country"),
                const SizedBox(height: 5),
                Text("      State: $state"),
                const SizedBox(height: 5),
                Text("      City: $city"),
                const SizedBox(height: 5),
                Text("      Area: $area"),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
