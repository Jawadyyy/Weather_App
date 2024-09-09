import 'package:flutter/material.dart';

class CitySelectionPage extends StatefulWidget {
  final Function(String) onCitySelected;

  const CitySelectionPage({super.key, required this.onCitySelected});

  @override
  // ignore: library_private_types_in_public_api
  _CitySelectionPageState createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  final List<String> _cities = [];

  void _addCity() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController cityController = TextEditingController();

        return AlertDialog(
          title: const Text('Add a City'),
          content: TextField(
            controller: cityController,
            decoration: const InputDecoration(hintText: 'Enter city name'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newCity = cityController.text.trim();
                if (newCity.isNotEmpty && !_cities.contains(newCity)) {
                  setState(() {
                    _cities.add(newCity);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a City'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: _cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_cities[index]),
            onTap: () {
              widget.onCitySelected(_cities[index]);
              Navigator.pop(context);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCity,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
