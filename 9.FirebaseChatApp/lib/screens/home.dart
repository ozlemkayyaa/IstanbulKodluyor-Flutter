import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final firebaseAuthInstance = FirebaseAuth.instance;
final firebaseStorageInstance = FirebaseStorage.instance;
final firebaseFireStore = FirebaseFirestore.instance;
final fcm = FirebaseMessaging.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _selectedImage;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    _requestNotificationPermission();
    super.initState();
  }

  void _requestNotificationPermission() async {
    NotificationSettings settings = await fcm.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      String? token = await fcm.getToken();
      // gcm-fcm token
      _updateTokenInDb(token!);

      fcm.onTokenRefresh.listen((token) {
        _updateTokenInDb(token);
      });

      await fcm.subscribeToTopic("flutter1b");

      // deeplink
    }
  }

  void _updateTokenInDb(String token) async {
    await firebaseFireStore
        .collection("users")
        .doc(firebaseAuthInstance.currentUser!.uid)
        .update({'fcm': token});
  }

  void _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _uploadImage() async {
    if (_selectedImage != null) {
      User? loggedInUser = firebaseAuthInstance.currentUser;

      final storageRef = firebaseStorageInstance
          .ref()
          .child("images")
          .child("${loggedInUser!.uid}.jpg");

      await storageRef.putFile(_selectedImage!);

      final url = await storageRef.getDownloadURL();

      await firebaseFireStore
          .collection("users")
          .doc(loggedInUser.uid)
          .update({'imageUrl': url});
    }
  }

  Future<String> _getUserImage() async {
    User? loggedInUser = firebaseAuthInstance.currentUser;
    final document =
        firebaseFireStore.collection("users").doc(loggedInUser!.uid);
    final documentSnapshot = await document.get();

    final imageUrl = await documentSnapshot.get("imageUrl");

    return imageUrl;
  }

  void _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      User? loggedInUser = firebaseAuthInstance.currentUser;

      await firebaseFireStore.collection("messages").add({
        'senderUid': loggedInUser!.uid,
        'text': messageText,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Mesaj gönderildikten sonra metin alanını temizle
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase App"),
        actions: [
          IconButton(
            onPressed: () {
              firebaseAuthInstance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          if (_selectedImage == null)
            FutureBuilder(
              future: _getUserImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    foregroundImage: NetworkImage(snapshot.data!),
                  );
                }
                if (snapshot.hasError) {
                  return const Text("Avatar yüklenirken bir hata oluştu..");
                }
                return const CircularProgressIndicator();
              },
            ),
          if (_selectedImage != null)
            CircleAvatar(
              radius: 40,
              foregroundImage: FileImage(_selectedImage!),
            ),
          TextButton(
            onPressed: () {
              _pickImage();
            },
            child: const Text("Resim Seç"),
          ),
          if (_selectedImage != null)
            ElevatedButton(
              onPressed: () {
                _uploadImage();
              },
              child: const Text("Yükle"),
            ),
          Expanded(
            child: StreamBuilder(
              stream: firebaseFireStore.collection("messages").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs;

                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  var messageText = message['text'];
                  var messageSenderUid = message['senderUid'];

                  var messageWidget = MessageWidget(
                    text: messageText,
                    isMe: messageSenderUid ==
                        firebaseAuthInstance.currentUser!.uid,
                  );

                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  children: messageWidgets,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Mesajınızı yazın...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isMe;

  const MessageWidget({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        color: isMe ? Colors.blue : Colors.green,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
