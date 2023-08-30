import 'package:flutter/material.dart';

void main() {
  runApp(KalkulatorMatriksApp());
}

class KalkulatorMatriksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Matriks',
      theme: ThemeData(
        primarySwatch: createCustomMaterialColor(Color.fromARGB(255, 50, 157, 211)),
      ),
      home: KalkulatorMatriksScreen(),
    );
  }

  MaterialColor createCustomMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }
}

class KalkulatorMatriksScreen extends StatefulWidget {
  @override
  _KalkulatorMatriksScreenState createState() => _KalkulatorMatriksScreenState();
}

class _KalkulatorMatriksScreenState extends State<KalkulatorMatriksScreen> {
  List<List<double>> matriks1 = List.generate(3, (i) => List.generate(3, (j) => 0.0));
  List<List<double>> matriks2 = List.generate(3, (i) => List.generate(3, (j) => 0.0));
  List<List<double>> matriksHasil = List.generate(3, (i) => List.generate(3, (j) => 0.0));

  void hitung(Operation operasi) {
    setState(() {
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (operasi == Operation.Tambah) {
            matriksHasil[i][j] = matriks1[i][j] + matriks2[i][j];
          } else if (operasi == Operation.Kurang) {
            matriksHasil[i][j] = matriks1[i][j] - matriks2[i][j];
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Matriks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Matriks 1',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < 3; i++)
                Row(
                  children: [
                    for (int j = 0; j < 3; j++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              matriks1[i][j] = double.tryParse(value) ?? 0.0;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 16),
              Text(
                'Matriks 2',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (int i = 0; i < 3; i++)
                Row(
                  children: [
                    for (int j = 0; j < 3; j++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            onChanged: (value) {
                              matriks2[i][j] = double.tryParse(value) ?? 0.0;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => hitung(Operation.Tambah),
                    child: Text('Tambah'),
                  ),
                  ElevatedButton(
                    onPressed: () => hitung(Operation.Kurang),
                    child: Text('Kurang'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Matriks Hasil:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              for (int i = 0; i < 3; i++) Text(matriksHasil[i].toString()),
            ],
          ),
        ),
      ),
    );
  }
}

enum Operation {
  Tambah,
  Kurang,
}
