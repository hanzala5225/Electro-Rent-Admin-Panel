import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_vision/flutter_vision.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image/image.dart' as img;

class AutoScanningScreen extends StatefulWidget {
  const AutoScanningScreen({super.key});

  @override
  State<AutoScanningScreen> createState() => _AutoScanningScreenState();
}

class _AutoScanningScreenState extends State<AutoScanningScreen> {
  bool isLoaded = false;
  bool detection = false;
  String modelStatus = 'Model is not loaded right now';
  String modelResult = '';
  TextEditingController detectedObject = TextEditingController();
  XFile? selectedPhoto;
  late FlutterVision vision;
  @override
  void initState() {
    vision = FlutterVision();
    loadYoloModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: detection
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(modelStatus),
                    modelResult.isEmpty
                        ? const SizedBox()
                        : Text('Detected Object is :$modelResult'),
                    detectedObject.text.isEmpty
                        ? const SizedBox()
                        : TextField(
                            controller: detectedObject,
                          ),
                    selectedPhoto != null
                        ? Image.file(
                            File(selectedPhoto!.path),
                            height: 150,
                          )
                        : const Text('select a photo kindly'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('from camera'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: Text('from gallery'),
                        )
                      ],
                    ),
                  ],
                )),
    );
  }

  // model loading function
  // call this function in init state
  Future<void> loadYoloModel() async {
    FlutterVision vision = FlutterVision();
    await vision.loadYoloModel(
        labels: 'assets/labels.txt',
        modelPath: 'assets/model.tflite',
        modelVersion: "yolov8",
        quantization: false,
        numThreads: 1,
        useGpu: false);
    setState(() {
      modelStatus = 'model is loaded';
    });
  }

  // image resizing
  Uint8List resizeImage(File imageFile, int targetWidth, int targetHeight) {
    // Read the image file as bytes
    List<int> imageBytes = imageFile.readAsBytesSync();

    // Decode the image bytes
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // Resize the image to target dimensions
    img.Image resizedImage =
        img.copyResize(image, width: targetWidth, height: targetHeight);

    // Encode the resized image to bytes
    List<int> resizedImageBytes = img.encodeJpg(resizedImage);

    // Convert List<int> to Uint8List
    Uint8List resizedImageUint8List = Uint8List.fromList(resizedImageBytes);

    return resizedImageUint8List;
  }

  //model detection function
  void yoloOnResizedImage(File imageFile) async {
    // Resize the image to 640x640
    Uint8List resizedImageBytes = resizeImage(imageFile, 640, 640);

    try {
      final result = await vision.yoloOnImage(
        bytesList: resizedImageBytes,
        imageHeight: 640,
        imageWidth: 640,
        iouThreshold: 0.8,
        confThreshold: 0.4,
        classThreshold: 0.7,
      );
      print(result);
      List<String> tags = result
          .map((detectedObject) => detectedObject['tag'] as String)
          .toList();
      print(tags);
      setState(() {
        if (tags.isEmpty) {
          modelResult = 'object is not detected';
          detectedObject.text = '';
        } else {
          modelResult = tags[0];
          detectedObject.text = tags[0];
        }
        detection = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        detection = false;
      });
    }
  }

  Future<void> startDetection() async {
    setState(() {
      detection = true;
    });
    yoloOnResizedImage(File(selectedPhoto!.path));
  }

  // image picking function

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedPhoto = image;
      });
      debugPrint('selected file path: ${selectedPhoto!.path}');

      startDetection();
    }
  }
}
