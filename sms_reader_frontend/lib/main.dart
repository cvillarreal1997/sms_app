import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SMS Reader App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _messageController = TextEditingController();

  Future<void> enviarMensajeSMS() async {
    String url = 'http://localhost:3000/sms'; // Reemplaza con la URL de tu backend
    String mensaje = _messageController.text;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': mensaje}),
      );

      if (response.statusCode == 200) {
        // El mensaje se envió correctamente
        print('Mensaje enviado correctamente');
      } else {
        // Hubo un error al enviar el mensaje
        print('Error al enviar el mensaje');
      }
    } catch (e) {
      // Manejar errores de conexión
      print('Error de conexión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enviar Mensaje SMS'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _messageController,
              decoration: InputDecoration(labelText: 'Mensaje'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: enviarMensajeSMS,
              child: Text('Enviar SMS'),
            ),
          ],
        ),
      ),
    );
  }
}

