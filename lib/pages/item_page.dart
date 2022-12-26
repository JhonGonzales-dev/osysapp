import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/item_model.dart';
import '../provider/empleado_provider.dart';
import '../widgets/custom_buttoms.dart';
import '../widgets/custom_inputs.dart';
import 'package:provider/provider.dart';

class ItemPage extends StatefulWidget {
  final EmpleadoModel? data;

  const ItemPage({super.key, this.data});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  String birtDate = '';
  String startDate = '';
  String endDate = '';
  String name = '';
  String lastname = '';
  int age = 0;

  var ctrlBirtDate = TextEditingController();
  var ctrlStartDate = TextEditingController();
  var ctrlEndDate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _isEmpty = ValueNotifier<bool>(true);

  _submit() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      context
          .read<EmpleadoProvider>()
          .createEmpleado(name, lastname, age, birtDate, startDate, endDate);
    }
  }

  _update() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();
      EmpleadoModel info = widget.data!;

      lastname = lastname.isEmpty ? info.lastName : lastname;
      name = name.isEmpty ? info.name : name;
      age = age == 0 ? info.age : age;
      birtDate = birtDate.isEmpty ? info.birthDate : birtDate;
      startDate = startDate.isEmpty ? info.startDate : startDate;
      endDate = endDate.isEmpty ? info.endDate : endDate;

      context.read<EmpleadoProvider>().updatePorId(
          widget.data!.id!, name, lastname, age, birtDate, startDate, endDate);
    }
  }

  _delete() async {
    final bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      FocusScope.of(context).unfocus();

      context.read<EmpleadoProvider>().borrarEmpleadoId(widget.data!.id!);
    }
  }

  @override
  void initState() {
    ctrlBirtDate.text = widget.data?.birthDate ?? '';
    ctrlStartDate.text = widget.data?.startDate ?? '';
    ctrlEndDate.text = widget.data?.endDate ?? '';
    if (widget.data != null) {
      context.read<EmpleadoProvider>().calculatedays(widget.data?.endDate);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.data == null ? 'Nuevo Empleado' : 'Editar/Eliminar'),
        leading: BackButton(onPressed: (() => Navigator.of(context).pop())),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
//...................TEXFORM FIELD NAME................................
              TextFormField(
                initialValue: widget.data?.name ?? '',
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Nombre',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.person,
                ),
                validator: (dynamic value) {
                  return (value.isEmpty) ? 'Nombre obligatorio' : null;
                },
                onChanged: (value) {
                  _isEmpty.value = false;
                  name = value;
                },
              ),
              const SizedBox(height: 15),

//...................TEXFORM FIELD LASTNAME................................
              TextFormField(
                initialValue: widget.data?.lastName ?? '',
                maxLines: 1,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Apellidos',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.person,
                ),
                validator: (dynamic value) {
                  return (value.isEmpty) ? 'apellido obligatorio' : null;
                },
                onChanged: (value) {
                  _isEmpty.value = false;
                  lastname = value;
                },
              ),
              const SizedBox(height: 15),

//...................TEXFORM FIELD AGE................................
              TextFormField(
                initialValue: widget.data?.age.toString() ?? '',
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                keyboardType: TextInputType.number,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Edad',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.person,
                ),
                validator: (dynamic value) {
                  return (value.isEmpty || int.tryParse(value)! <= 18)
                      ? 'edad incorrecto'
                      : null;
                },
                onChanged: (value) {
                  _isEmpty.value = false;
                  age = int.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 15),

//...................TEXFORM BIRTH DATE................................
              TextFormField(
                controller: ctrlBirtDate,
                enableInteractiveSelection: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Fecha nacimiento',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.calendar_today,
                ),
                validator: (dynamic value) {
                  return (value.isEmpty) ? 'campo obligatorio' : null;
                },
                onChanged: (value) {
                  _isEmpty.value = false;
                },
                onTap: () {
                  _isEmpty.value = false;
                  FocusScope.of(context).requestFocus(FocusNode());
                  selectedDate(context, OptionDate.birtDate);
                },
              ),
              const SizedBox(height: 15),

//...................TEXFORM START DATE WORK................................
              TextFormField(
                controller: ctrlStartDate,
                enableInteractiveSelection: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Fecha inicio',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.calendar_today,
                ),
                validator: (dynamic value) {
                  return (value.isEmpty) ? 'campo obligatorio' : null;
                },
                onChanged: (value) {
                  _isEmpty.value = false;
                },
                onTap: () {
                  _isEmpty.value = false;
                  FocusScope.of(context).requestFocus(FocusNode());
                  selectedDate(context, OptionDate.startDate);
                },
              ),
              const SizedBox(height: 15),

//...................TEXFORM END DATE WORK................................
              TextFormField(
                controller: ctrlEndDate,
                enableInteractiveSelection: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: CustomInputs.loginInputDecoration(
                  borderRadius: 10,
                  hint: 'Fecha finalizacion',
                  fillcolor: Colors.grey.withOpacity(0.1),
                  icon: Icons.calendar_today,
                ),
                onChanged: (value) {
                  _isEmpty.value = false;
                },
                validator: (dynamic value) {
                  return (value.isEmpty) ? 'campo obligatorio' : null;
                },
                onTap: () {
                  _isEmpty.value = false;
                  FocusScope.of(context).requestFocus(FocusNode());
                  selectedDate(context, OptionDate.endDate);
                },
              ),
              const SizedBox(height: 30),

//...................BUTTOMS SAVE / UPDATE ................................
              ValueListenableBuilder(
                  valueListenable: _isEmpty,
                  builder: (_, bool value, __) {
                    return CustomButtom(
                      borderRadius: 30,
                      colorButtom: const Color(0XFF52D0A1),
                      paddingHorizontal: 50,
                      paddingVertical: 10,
                      text: widget.data == null ? 'Guardar' : 'Actualizar',
                      isEmpty: value,
                      onpress: widget.data == null
                          ? () => _submit()
                          : () => _update(),
                    );
                  }),
              const SizedBox(height: 15),

//................BUTTOM DELETE ..............................
              if (widget.data != null)
                CustomButtom(
                  borderRadius: 30,
                  colorButtom: const Color(0xFFFD3C2E),
                  paddingHorizontal: 50,
                  paddingVertical: 10,
                  text: 'Eliminar',
                  isEmpty: false,
                  onpress: () => _delete(),
                ),
              if (widget.data != null)
                Column(
                  children: [
                    const SizedBox(height: 15),
                    const Divider(thickness: 1),
                    Text(
                        '${context.watch<EmpleadoProvider>().differenceDays} dias para terminar el contrato'),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

/*   String calculatedays() {
    DateTime today = DateTime.now();
    String enddatework = widget.data!.endDate;
    var endDate = DateFormat('d/M/y').parse(enddatework);
    Duration diastotales = endDate.difference(today);

    return diastotales.inDays.toString();
  } */

  void selectedDate(BuildContext context, OptionDate date) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));

    if (picked != null) {
      switch (date) {
        case OptionDate.birtDate:
          return setState(() {
            birtDate = DateFormat('dd/MM/yyyy').format(picked);
            ctrlBirtDate.text = birtDate;
          });

        case OptionDate.startDate:
          return setState(() {
            startDate = DateFormat('dd/MM/yyyy').format(picked);
            ctrlStartDate.text = startDate;
          });
        case OptionDate.endDate:
          return setState(() {
            endDate = DateFormat('dd/MM/yyyy').format(picked);
            ctrlEndDate.text = endDate;
          });
      }
    }
  }
}

enum OptionDate { birtDate, startDate, endDate }
