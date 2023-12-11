import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Manabata/requests.dart' as request;

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  Map<String, dynamic> user = {};
  late List<PostData> posts;

  @override
  void initState() {
    super.initState();
    posts = [];
    loadPosts(refresh: false);
  }

  Future<void> setUserData() async {
    String userRaw = await request.getLocalData('user') as String;
    setState(() {
      user = json.decode(userRaw);
    });
  }

  Future<void> loadPosts({bool refresh = true}) async {
    await setUserData();
    String postEmergencyRaw = json.encode(await request.API.getPostRegular(user['uid'], refresh: refresh));
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
              postUser: posts[index].username,
              area: posts[index].area,
              totalReaction: int.parse(posts[index].totalReaction),
              userReaction: int.parse(posts[index].userReaction),
              username: user['uid']
            );
          },
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  @override
  State<CardWidget> createState() => _CardWidgetState();

  final String postId;
  final String content;
  final String createTs;
  final String country;
  final String urgencyLevel;
  final String title;
  final String bloodGroup;
  final String state;
  final String city;
  final String postUser;
  final String area;
  int totalReaction;
  int userReaction;
  final String username;
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
    required this.postUser,
    required this.area,
    required this.totalReaction,
    required this.userReaction,
    required this.username
  });
}

class _CardWidgetState extends State<CardWidget> {
  Color mainColor = Colors.blue.shade500;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              (widget.title == '') ? "A post by ${widget.postUser}" : widget.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text("${widget.createTs} by ${widget.postUser} | ${widget.bloodGroup}"),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text((widget.content == '') ? "(no content)" : widget.content),
                const SizedBox(height: 30),
                const Text(
                  "Address:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text("${widget.state}, ${widget.country}"),
                const SizedBox(height: 5),
                Text("City: ${widget.city}"),
                const SizedBox(height: 5),
                Text("Area: ${widget.area}"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () async {
                          final data = {
                            'username': widget.username,
                            'post_id': widget.postId,
                            'urgency_level': 'post',
                            'reaction': (widget.userReaction == 0) ? '1' : '0'
                          };
                          setState(() {
                            widget.userReaction = (widget.userReaction == 0) ? 1 : 0;
                            widget.totalReaction = (widget.userReaction == 1) ? (widget.totalReaction + 1) : (widget.totalReaction - 1);
                          });
                          Map<String, dynamic> response = await request.API.putReaction(data);
                          if(response["status"] == true) {
                            await request.API.getPostRegular(widget.username, refresh: true);
                            if (kDebugMode) {
                              print("Reacted on ${widget.postId}: ${widget.userReaction}");
                            }
                          }
                          else{
                            setState(() {
                              widget.userReaction = (widget.userReaction == 0) ? 1 : 0;
                              widget.totalReaction = (widget.userReaction == 1) ? (widget.totalReaction + 1) : (widget.totalReaction - 1);
                            });
                            if (kDebugMode) {
                              print(response["messages"]["error"]);
                            }
                          }
                        },
                        icon: (widget.userReaction == 1) ? Icon(Icons.thumb_up, color: mainColor) : Icon(Icons.thumb_up_outlined, color: mainColor),
                        label: (widget.totalReaction == 0) ? Text('Like', style: TextStyle(color: mainColor),) : Text('${widget.totalReaction}', style: TextStyle(color: mainColor),),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Handle comment action
                        },
                        icon: Icon(Icons.comment, color: mainColor),
                        label: Text('Comment', style: TextStyle(color: mainColor),),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Handle share action
                        },
                        icon: Icon(Icons.screen_share_rounded, color: mainColor),
                        label: Text('Share', style: TextStyle(color: mainColor),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
  final String totalReaction;
  final String userReaction;

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
    required this.totalReaction,
    required this.userReaction,
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
      totalReaction: (json.containsKey('total_reaction')) ? '${json['total_reaction']}' : '0',
      userReaction: (json.containsKey('user_reaction')) ? '${json['user_reaction']}' : '0',
    );
  }
}
