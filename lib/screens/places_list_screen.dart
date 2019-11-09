import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlacesProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlacesProvider>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, greatPlaces, ch) {
                  if (greatPlaces.items.isEmpty) return ch;

                  return ListView.builder(
                    itemCount: greatPlaces.items.length,
                    itemBuilder: (BuildContext ctx, int i) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            greatPlaces.items[i].image,
                          ),
                        ),
                        title: Text(greatPlaces.items[i].title),
                        onTap: () {
                          // Go to detail page
                        },
                      );
                    },
                  );
                }),
      ),
    );
  }
}
