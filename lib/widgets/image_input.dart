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
    final ImagePicker _picker = ImagePicker();

    final imageFile =
        await _picker.pickImage(source: ImageSource.camera, maxHeight: 600);
    setState(() {
      _storedImage = imageFile;
    });

    print('_storedImage ${_storedImage!.path}');
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
              title: const Text('Прикріпити файл'),
            ),
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(34, 0, 0, 0),
            color: const Color(0xFFFBEFB4),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
              title: const Text('Вкладене зображення'),
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
              // trailing: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //       IconButton(
              //         onPressed: () {},
              //         icon: const Icon(Icons.clear),
              //       ),
              //     ]));
            ),
          );
    // return Row(
    //   children: [
    //     Container(
    //       width: 200,
    //       height: 200,
    //       child: _storedImage != null ? Image.file(File(_storedImage!.path), fit: BoxFit.cover, width: double.infinity,) : Text('Прикріпити файл', textAlign: TextAlign.center,),
    //     ),
    //     TextButton(onPressed: _takePicture, child: const Text('Прикріпити файл'))
    //   ],
    // );
  }
}
