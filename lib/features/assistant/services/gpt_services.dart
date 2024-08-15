import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GPTServices {
  static Future<bool> isQuestionFarmRelated(String question) async {
    try {
      final response = await http.post(
        Uri.parse(OPENAI_API_URL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENAI_API_KEY',
        },
        body: json.encode({
          "model": OPENAI_API_MODEL,
          "messages": [
            {
              "role": "system",
              "content":
                  "You are an expert in determining if questions are farming related or agriculture related."
            },
            {
              "role": "user",
              "content":
                  "Is the following question farming related or agriculture related? \"$question\" Answer with 'true' or 'false'."
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content']
            .trim()
            .toString()
            .toLowerCase()
            .contains('true');
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getFarmRelatedResponse(String question) async {
    try {
      final response = await http.post(
        Uri.parse(OPENAI_API_URL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENAI_API_KEY',
        },
        body: json.encode({
          "model": OPENAI_API_MODEL,
          "messages": [
            {"role": "system", "content": "You are a helpful farm assistant."},
            {"role": "user", "content": question}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'].toString();
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> isFarmRelatedWithImage(Uint8List imageToBase64) async {
    try {
      String base64Image = base64Encode(imageToBase64);
      final response = await http.post(
        Uri.parse(OPENAI_API_URL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENAI_API_KEY',
        },
        body: json.encode({
          "model": OPENAI_API_MODEL,
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "Is this image farming related or agriculture related or a part of a plant? Please answer with 'true' or 'false'."
                },
                {
                  "type": "image_url",
                  "image_url": {"url": "data:image/jpeg;base64,$base64Image"}
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content']
            .trim()
            .toString()
            .toLowerCase()
            .contains('true');
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getFarmRelatedResponseWithImage(
      Uint8List imageToBase64) async {
    try {
      String base64Image = base64Encode(imageToBase64);
      final response = await http.post(
        Uri.parse(OPENAI_API_URL),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENAI_API_KEY',
        },
        body: json.encode({
          "model": OPENAI_API_MODEL,
          "messages": [
            {
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text":
                      "What disease is this plant suffering from? Please provide a detailed description, State Disease name, Symptoms,Causes and possible treatment."
                },
                {
                  "type": "image_url",
                  "image_url": {"url": "data:image/jpeg;base64,$base64Image"}
                }
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> uploadImageToFirestore(Uint8List imageToBase64) async {
    try {
      final FirebaseStorage _storage = FirebaseStorage.instance;
      final ref = _storage
          .ref('images')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putData(
          imageToBase64, SettableMetadata(contentType: 'image/jpg'));
      return await ref.getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }
}

const String baseUrl =
    'https://sms.arkesel.com/sms/api?action=send-sms&api_key=SmtPRE5HZk11Q3lKdHNGamJFRnE&to=PhoneNumber&from=SenderID&sms=YourMessage';

Future<bool> sendMessage(String phoneNumber, String message) async {
  try {
    final response = await http.get(Uri.parse(baseUrl
        .replaceFirst('PhoneNumber', phoneNumber)
        .replaceFirst('SenderID', 'FarmerCity')
        .replaceFirst('YourMessage', message)));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print(e);
    return false;
  }
}
