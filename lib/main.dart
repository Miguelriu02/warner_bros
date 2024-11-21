import 'package:flutter/material.dart';
import 'package:warner_bros/cargando_screen.dart';

void main() => runApp(const WarnerBros());

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warner Bros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isAtBottom = true;
      } else {
        _isAtBottom = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        children: [
          Container(
            color: Colors.lightBlue,
            height: 150,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          'assets/madridbeach.png',
                          height: 130,
                        ),
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: botonIzquierdo(
                    context,
                    icon: Icons.search,
                    label: 'Buscar',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: botonDerecho(
                    context,
                    icon: Icons.confirmation_number,
                    label: 'Mis entradas',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              tarjeta(context, 'Atracciones',
                                  'assets/atracciones.jpg'),
                              tarjeta(context, 'Restaurantes',
                                  'assets/restaurantes.jpg'),
                            ],
                          ),
                          SizedBox(
                            height: 175,
                            child: GridView.count(
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                tarjeta(context, 'Mapa', 'assets/mapa.jpg'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Más opciones',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          optionItem(Icons.store, 'Tienda'),
                          optionItem(Icons.directions, 'Cómo llegar'),
                          optionItem(Icons.info, 'Información'),
                          optionItem(Icons.access_alarm, 'Alerta'),
                          optionItem(
                              Icons.airline_seat_individual_suite_outlined,
                              'Hoteles Cercanos'),
                          optionItem(
                              Icons.attach_money_rounded, 'Comprar entrada')
                        ],
                      ),
                    ),
                  ),
                ),
                if (!_isAtBottom)
                  Positioned(
                    bottom: 1,
                    left: MediaQuery.of(context).size.width / 2 - 20,
                    child: GestureDetector(
                      onTap: () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 40,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget botonIzquierdo(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget botonDerecho(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget tarjeta(BuildContext context, String title, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // Imagen de fondo
              Image.asset(
                imagePath,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionItem(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}
