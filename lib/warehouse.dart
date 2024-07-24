import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'config.dart';

void main() {
  runApp(MaterialApp(
    home: NearbyPlacesList(),
  ));
}

class NearbyPlacesList extends StatefulWidget {
  @override
  _NearbyPlacesListState createState() => _NearbyPlacesListState();
}

class _NearbyPlacesListState extends State<NearbyPlacesList> {
  List<dynamic> nearbyPlaces = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Change the URL to your API endpoint
      final response = await http.get(Uri.parse(nearby));

      if (response.statusCode == 200) {
        setState(() {
          nearbyPlaces = json.decode(response.body)['nearby'];
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      // Handle errors in fetching data
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Places'),
      ),
      body: nearbyPlaces.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: nearbyPlaces.length,
              itemBuilder: (context, index) {
                final place = nearbyPlaces[index];
                return ListTile(
                  title: Text(place['name'] ?? 'No Name'),
                  subtitle: place.containsKey('rating')
                      ? Text('Rating: ${place['rating']}')
                      : null,
                  leading: place.containsKey('photos')
                      ? Image.network(
                          getImageUrl(place['photos'][0]['photo_reference']),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : null,
                  onTap: () {
                    // Implement the action when the list item is tapped
                    // For example, navigate to a details page
                  },
                );
              },
            ),
    );
  }

  String getImageUrl(String photoReference) {
    // Change these values with your actual Google API key and base URL
    String apiKey = 'AIzaSyAZOyX4Vz7pLwr0LnB5vKMcnAQHyw2jMIM';
    String baseUrl = 'https://maps.googleapis.com/maps/api/place/photo';
    
    // Construct the complete image URL
    String imageUrl =
        '$baseUrl?maxwidth=400&photoreference=$photoReference&key=$apiKey';
    return imageUrl;
  }
}
