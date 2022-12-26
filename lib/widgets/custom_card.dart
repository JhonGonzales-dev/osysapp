import 'package:flutter/material.dart';

import '../models/item_model.dart';
import 'custom_text.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key, this.data}) : super(key: key);
  final EmpleadoModel? data;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Row(
            children: [
              const Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.person, size: 60),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRichText(
                          'Nombre:', '${data!.name} ${data!.lastName}'),
                      CustomRichText('fecha ingreso: ', data!.startDate),
                      CustomRichText('fecha termino: ', data!.endDate),
                    ],
                  ))
            ],
          ),
        ));
  }
}
