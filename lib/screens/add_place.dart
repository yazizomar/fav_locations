import 'dart:io';

import 'package:fav_locations/provider/user_places.dart';
import 'package:fav_locations/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _takenImage;

  void _savePlace() {
    final enteredTitle = _titleController.text;
    if (enteredTitle.isEmpty || _takenImage == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(
          enteredTitle,
          _takenImage!,
        );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(height: 16),
            ImageInput(
              onTakenImage: (image) {
                _takenImage = image;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              onPressed: _savePlace,
              label: const Text('Add Place'),
            )
          ],
        ),
      ),
    );
  }
}
