import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModal {
  static Future<String?> show(BuildContext context) async {
    final picker = ImagePicker();

    return await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Escolher da Galeria'),
                onTap: () async {
                  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                  if (context.mounted) Navigator.of(context).pop(image?.path);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Tirar Foto'),
                onTap: () async {
                  final XFile? image = await picker.pickImage(source: ImageSource.camera);
                  if (context.mounted) Navigator.of(context).pop(image?.path);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
