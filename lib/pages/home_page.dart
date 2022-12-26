import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/empleado_provider.dart';
import '../widgets/custom_card.dart';
import 'item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<EmpleadoProvider>().cargarEmpleados();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Osys App'),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/item');
            },
            child: const Icon(Icons.add)),
        body: Consumer<EmpleadoProvider>(builder: (_, data, __) {
          if (data.status == EmpleadoStatus.checking) {
            return const Center(child: CircularProgressIndicator());
          } else if (data.status == EmpleadoStatus.loaded) {
            return ListView.builder(
                padding: const EdgeInsets.all(29),
                itemCount: data.empleados.length,
                itemBuilder: (_, index) {
                  final dato = data.empleados[index];
                  return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ItemPage(data: dato))),
                      child: CustomCard(data: dato));
                });
          } else {
            return SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'No es posible conectar a la red',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ]));
          }
        }));
  }
}
