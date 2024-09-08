import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/repositories/article_repository.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  _AddBlogState createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker imagePicker = ImagePicker();
  XFile? selectedImage;
  String title = "";
  String content = "";
  String author = "";

  pickImage() async {
    // Galeride bekleme süresi belli değil, Galeriden fotoğraf seçmeden çıkabilir, Bu yüzden nullable
    XFile? selectedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = selectedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Blog Ekle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (selectedImage != null) Image.file(File(selectedImage!.path)),
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text("Fotoğraf Seç")),
              TextFormField(
                decoration: const InputDecoration(label: Text("Blog Başlığı")),
                onSaved: (newValue) {
                  title = newValue!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen bir blog başlığı giriniz";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Blog İçeriği")),
                maxLines: 5, // 5 Satırlık text alanı gibi düşün
                onSaved: (newValue) {
                  content = newValue!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen bir blog içeriği giriniz";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(label: Text("Ad Soyad")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen ad soyad giriniz";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  author = newValue!;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ArticleRepository()
                          .addBlog(selectedImage, title, content, author);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Blog Ekle"))
            ],
          ),
        ),
      ),
    );
  }
}
