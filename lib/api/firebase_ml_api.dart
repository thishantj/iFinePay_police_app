import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';

class FirebaseMLApi {
  static Future<String> recogniseText(File imageFile) async {
    if (imageFile == null) {
      return "No selected image";
    } else {
      // final visionImage = FirebaseVisionImage.fromFile(imageFile);
      // final textRecognizer = FirebaseVision.instance.textRecognizer();

      // try {
      //   final visionText = await textRecognizer.processImage(visionImage);
      //   await textRecognizer.close();

      //   final text = extractText(visionText);
      //   return text.isEmpty ? 'No text found in the image' : text;
      // } catch (error) {
      //   return error.toString();
      // }


      final visionImage = InputImage.fromFile(imageFile);
      final textRecognizer = GoogleMlKit.vision.textDetector();

      try {
        final visionText = await textRecognizer.processImage(visionImage);
        await textRecognizer.close();

        final text = extractText(visionText);
        return text.isEmpty ? 'No text found in the image' : text;
      } catch (error) {
        return error.toString();
      }
    }
  }

  // static extractText(VisionText visionText) {
  static extractText(RecognisedText visionText) {
    String text = '';

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          text = text + word.text + ' ';
        }
        text = text + '\n';
      }
    }
    print(text);

    return text;
  }
}