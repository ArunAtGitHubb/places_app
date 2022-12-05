import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:great_places/pages/add_place.dart';
import 'package:great_places/providers/places.dart';
import 'package:provider/provider.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places..'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.route);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<Places>(context, listen: false).fetchPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<Places>(
                    builder: (context, value, child) => value.places.isNotEmpty
                        ? ListView.builder(
                            itemBuilder: (context, index) {
                              final place = value.places[index];
                              return SizedBox(
                                height: 100,
                                child: Card(
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(70),
                                      child: CircleAvatar(
                                        backgroundImage: FileImage(place.image),
                                      ),
                                    ),
                                    title: Text(place.title),
                                  ),
                                ),
                              );
                            },
                            itemCount: value.places.length,
                          )
                        : child!,
                    child: const Center(
                      child: Text('Places not yet added, Add new places..'),
                    )),
      ),
    );
  }
}
