import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  final Function _saveImage;
  const ImageInput(this._saveImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? storedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _takePicture(ImageSource from) async {
    final picture = await _picker.pickImage(
      source: from,
      maxWidth: 600,
    );
    if (picture != null) {
      setState(() {
        storedImage = File(picture.path);
      });
    }

    final appDir = await pathProvider.getApplicationDocumentsDirectory();
    final fileName = path.basename(picture!.path);
    final savedImage = await picture.saveTo('${appDir.path}/$fileName');
    widget._saveImage(storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
          ),
          alignment: Alignment.center,
          child: storedImage != null
              ? Image.file(
                  storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : const Text(
                  'No image selected',
                  textAlign: TextAlign.center,
                ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () => _takePicture(ImageSource.gallery),
              label: const Text('Open Gallery'),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () => _takePicture(ImageSource.camera),
              label: const Text('Open Camera'),
            )
          ],
        ),
      ],
    );
  }
}
