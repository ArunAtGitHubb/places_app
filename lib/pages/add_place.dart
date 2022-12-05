import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/providers/places.dart';

import 'package:great_places/widgets/inputImage.dart';
import 'package:great_places/widgets/inputLocation.dart';
import 'package:provider/provider.dart';

class AddPlacePage extends StatefulWidget {
  const AddPlacePage({super.key});
  static String route = '/add-place';

  @override
  State<AddPlacePage> createState() => _AddPlacePageState();
}

class _AddPlacePageState extends State<AddPlacePage> {
  final _titleController = TextEditingController();
  late File _pickedImage;

  void _saveImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _addPlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    print('outside');
    var newPlace = Place(
      id: DateTime.now().toString(),
      title: _titleController.text,
      image: _pickedImage,
      location: Location(
        address: '',
        latitude: 0.0,
        logitude: 0.0,
      ),
    );
    Provider.of<Places>(context, listen: false).addPlace(newPlace);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add a new place')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 20),
                    ImageInput(_saveImage),
                    const SizedBox(height: 20),
                    const LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _addPlace,
              label: const Text('Add place'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).accentColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
