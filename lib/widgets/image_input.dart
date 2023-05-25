import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();

    final imageFile =
        await picker.pickImage(source: ImageSource.camera, maxHeight: 600);
    setState(() {
      _storedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _storedImage == null
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
            color: const Color(0xFFFBEFB4),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              onTap: _takePicture,
              title: Text(
                'Прикріпити файл',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
            color: const Color(0xFFFBEFB4),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
              title: Text(
                'Вкладене зображення',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 13, 0, 15),
                      height: 236,
                      width: 236,
                      child: Image.file(
                        File(_storedImage!.path),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _storedImage = null;
                        });
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ]),
            ),
          );
  }
}
