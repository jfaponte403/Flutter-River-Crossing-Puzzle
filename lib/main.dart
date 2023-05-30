import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'characters/Character.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.blue, // Color principal de la aplicación
      accentColor: Colors.blueAccent, // Color de acento de la aplicación
      fontFamily: 'Arial', // Fuente utilizada en toda la aplicación
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Character> entryList = [
    const Character(
      imagePath: 'assets/fox.png',
      name: 'fox',
    ),
    const Character(imagePath: 'assets/sheep.png', name: 'sheep'),
    const Character(imagePath: 'assets/lettuce.png', name: 'lettuce'),
  ];
  List<Character> shipList = [
    const Character(
      imagePath: 'assets/ship.png',
      name: 'ship',
    )
  ];
  List<Character> arrivalList = [];

  bool isStarted = false;

  void startGame() {
    setState(() {
      isStarted = true;
      // Restablecer las listas
      entryList = [
        const Character(
          imagePath: 'assets/fox.png',
          name: 'fox',
        ),
        const Character(imagePath: 'assets/sheep.png', name: 'sheep'),
        const Character(imagePath: 'assets/lettuce.png', name: 'lettuce'),
      ];
      shipList = [
        const Character(
          imagePath: 'assets/ship.png',
          name: 'ship',
        )
      ];
      arrivalList = [];
    });
  }

  void exit() {
    setState(() {
      isStarted = false;
    });
  }

  // Restablecer el juego
  void resetGame() {
    setState(() {
      entryList = [
        const Character(
          imagePath: 'assets/fox.png',
          name: 'fox',
        ),
        const Character(imagePath: 'assets/sheep.png', name: 'sheep'),
        const Character(imagePath: 'assets/lettuce.png', name: 'lettuce'),
      ];
      shipList = [
        const Character(
          imagePath: 'assets/ship.png',
          name: 'ship',
        )
      ];
      arrivalList = [];
    });
  }

  // Mostrar el diálogo de derrota
  void showLostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'You were defeated',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Try Again',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                resetGame();
                Navigator.pop(context); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  // Mostrar el diálogo de victoria
  void showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'You Win!!!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Finish',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.blue,
                ),
              ),
              onPressed: () {
                exit();
                Navigator.pop(context); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  // Verificar si la lista de llegada es válida
  bool validArrivalList() {
    bool hasSheep = false;
    bool hasLettuce = false;
    bool hasFox = false;

    for (var character in arrivalList) {
      if (character.name == 'sheep') {
        hasSheep = true;
      }
      if (character.name == 'lettuce') {
        hasLettuce = true;
      }
      if (character.name == 'fox') {
        hasFox = true;
      }
    }

    // Caso de zorro y oveja
    if (hasFox && hasSheep) {
      return false;
    }

    // Caso de oveja y lechuga
    if (hasSheep && hasLettuce) {
      return false;
    }

    return true;
  }

  // Verificar si la lista de entrada es válida
  bool validEntryList() {
    bool hasSheep = false;
    bool hasLettuce = false;
    bool hasFox = false;

    for (var character in entryList) {
      if (character.name == 'sheep') {
        hasSheep = true;
      }
      if (character.name == 'lettuce') {
        hasLettuce = true;
      }
      if (character.name == 'fox') {
        hasFox = true;
      }
    }

    // Caso de zorro y oveja
    if (hasFox && hasSheep) {
      return false;
    }

    // Caso de oveja y lechuga
    if (hasSheep && hasLettuce) {
      return false;
    }

    return true;
  }

  // Verificar si el juego ha terminado
  bool isGameOver() {
    return arrivalList.length == 3;
  }

  // Mover un objeto a la lista de la embarcación
  void moveObjectToShipList(String objectName) {
    // Buscar el objeto en la lista entryList
    Character object;
    try {
      object = entryList.firstWhere((character) => character.name == objectName);
    } catch (e) {
      try {
        object = arrivalList.firstWhere((character) => character.name == objectName);
      } catch (e) {
        return;
      }
    }

    setState(() {
      if (shipList.length < 2) {
        arrivalList.remove(object);
        entryList.remove(object);
        shipList.add(object);
      }
    });
  }

  // Mover el segundo objeto a la lista de llegada
  void moveSecondObjectToArrivalList() {
    if (shipList.length >= 2) {
      setState(() {
        Character secondObject = shipList[1];
        shipList.removeAt(1);
        arrivalList.add(secondObject);
      });
    }
  }

  // Mover el segundo objeto a la lista de entrada
  void moveSecondObjectToEntryList() {
    if (shipList.length >= 2) {
      setState(() {
        Character secondObject = shipList[1];
        shipList.removeAt(1);
        entryList.add(secondObject);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'River Crossing Puzzle',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'River Crossing Puzzle',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              if (!isStarted)
                Expanded(
                  child: Container(
                    color: Colors.white, // Color de fondo blanco para cubrir la imagen
                    child: Center(
                      child: ElevatedButton(
                        onPressed: startGame,
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              if (isStarted)
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: 16),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start, // Alineación en la parte superior
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 16), // Espacio para los botones
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: entryList.length,
                                      itemBuilder: (context, index) {
                                        var character = entryList[index];
                                        return Image.asset(
                                          character.imagePath,
                                          height: 128,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 16), // Espacio para los botones
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: shipList.length,
                                      itemBuilder: (context, index) {
                                        var character = shipList[index];
                                        return Image.asset(
                                          character.imagePath,
                                          height: 128,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 16), // Espacio para los botones
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: arrivalList.length,
                                      itemBuilder: (context, index) {
                                        var character = arrivalList[index];
                                        return Image.asset(
                                          character.imagePath,
                                          height: 128,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              moveObjectToShipList('fox');
                            },
                            child: Text(
                              'Move Fox\n To Ship',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              moveObjectToShipList('lettuce');
                            },
                            child: Text(
                              'Move Lettuce\n To Ship',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              moveObjectToShipList('sheep');
                            },
                            child: Text(
                              'Move Sheep\n To Ship',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              moveSecondObjectToEntryList();
                              if (!validArrivalList()) {
                                showLostDialog(context);
                                resetGame();
                              }
                              if (isGameOver()) {
                                showWinDialog(context);
                              }
                            },
                            child: Text(
                              'Move left',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              moveSecondObjectToArrivalList();
                              if (!validEntryList()) {
                                showLostDialog(context);
                                resetGame();
                              }
                              if (isGameOver()) {
                                showWinDialog(context);
                              }
                            },
                            child: Text(
                              'Move right',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              exit();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Color de fondo rojo
                            ),
                            child: Text(
                              'Exit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white, // Color del texto en blanco
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


            ],
          ),
        ),
      ),
    );
  }

}
