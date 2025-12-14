import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DogInfoScreen extends StatefulWidget {
  @override
  _DogInfoScreenState createState() => _DogInfoScreenState();
}

class _DogInfoScreenState extends State<DogInfoScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _breedController = TextEditingController();
  final _weightController = TextEditingController();
  final _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('dogName') ?? '';
      _ageController.text = prefs.getString('dogAge') ?? '';
      _breedController.text = prefs.getString('dogBreed') ?? '';
      _weightController.text = prefs.getString('dogWeight') ?? '';
      _genderController.text = prefs.getString('dogGender') ?? '';
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('dogName', _nameController.text);
    prefs.setString('dogAge', _ageController.text);
    prefs.setString('dogBreed', _breedController.text);
    prefs.setString('dogWeight', _weightController.text);
    prefs.setString('dogGender', _genderController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Información de tu canino'
        ),
        backgroundColor: Colors.blue.withOpacity(0.17),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.2),
              Colors.blue.withOpacity(0.1)
            ],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre del canino'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Edad (en años)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _breedController,
              decoration: InputDecoration(labelText: 'Raza'),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Peso (en kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Género'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveData(); // Guardar los datos al presionar el botón
                // Puedes agregar aquí cualquier otra acción que necesites realizar
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
