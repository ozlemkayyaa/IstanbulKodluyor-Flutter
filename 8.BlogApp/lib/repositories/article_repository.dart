import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/models/blog.dart';

class ArticleRepository {
  Future<List<Blog>> fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);
    return jsonData.map((json) => Blog.fromJson(json)).toList();
  }

  Future<bool> addBlog(
      XFile? selectedImage, String title, String content, String author) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    // Multipart - istekte hem bilgi hemde dosya var
    var request = http.MultipartRequest("POST", url);

    request.fields['Title'] = title;
    request.fields['Content'] = content;
    request.fields['Author'] = author;

    if (selectedImage != null) {
      http.MultipartFile file =
          await http.MultipartFile.fromPath("File", selectedImage.path);
      request.files.add(file);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      // Ekleme başarılı
      return true;
    } else {
      return false;
    }
  }
}
