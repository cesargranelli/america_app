import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/ui/themes/input_decoration_theme.dart';
import '../../../../core/ui/validators/input_field_uppercase.dart';

class RegistrationLeaguePage extends StatefulWidget {
  const RegistrationLeaguePage({super.key});

  @override
  State<RegistrationLeaguePage> createState() => _RegistrationLeaguePageState();
}

class _RegistrationLeaguePageState extends State<RegistrationLeaguePage> {
  File? _teamLogoImage;

  Future<void> _pickTeamLogo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _teamLogoImage = File(image.path);
      });
    }
  }

  Future<void> _selectFoundingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: const Color(0xFFFAC638),
              onPrimary: Colors.white,
              onSurface: const Color(0xFF4A4A4A),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4A4A4A),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _foundingDateController.text =
            "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  final TextEditingController _foundingDateController = TextEditingController();
  TextEditingController acronymController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: inputDecoration.copyWith(
                  labelText: 'Nome',
                  hintText: 'Digite o nome da liga',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                decoration: inputDecoration.copyWith(
                  labelText: 'Descrição',
                  hintText: 'Digite a descrição da liga',
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _foundingDateController,
                readOnly: true,
                decoration: inputDecoration.copyWith(
                  labelText: 'Fundação',
                  hintText: 'Selecione a data de fundação',
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.calendar_today,
                      color: Color(0xFF9E8747),
                    ),
                    onPressed: () => _selectFoundingDate(context),
                  ),
                ),
                onTap: () => _selectFoundingDate(context),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: acronymController,
                decoration: inputDecoration.copyWith(
                  labelText: 'Sigla',
                  hintText: 'Digite a sigla da liga',
                ),
                inputFormatters: [InputFieldUpperCase()],
                onChanged: (value) {
                  setState(() {
                    value = acronymController.text.toUpperCase();
                  });
                },
              ),
              SizedBox(height: 20.0),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: const Color(0xFFDDDCDC),
                      style: BorderStyle.solid,
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: _pickTeamLogo,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _teamLogoImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.file(
                                  _teamLogoImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : FloatingActionButton(
                                onPressed: _pickTeamLogo,
                                backgroundColor: const Color(0xFFF4F0E6),
                                foregroundColor: const Color(0xFF9E8747),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 0,
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 30.0,
                                  color: const Color(0xFF9E8747),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          onPressed: () {
            // Ação ao registrar o time
            print('Registro de time enviado!');
            if (_teamLogoImage != null) {
              print('Logotipo selecionado: ${_teamLogoImage!.path}');
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Time registrado com sucesso!')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFAC638), // Cor de fundo do botão
            foregroundColor: const Color(0xFF4A4A4A), // Cor do texto do botão
            minimumSize: const Size(double.infinity, 50), // Altura do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.0,
              ), // Bordas arredondadas do botão
            ),
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Register Team'), // Texto do botão
        ),
      ),
    );
  }
}

class DatePickerApp extends StatelessWidget {
  const DatePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('showDatePicker Example')),
        body: const Center(child: DatePickerExample()),
      ),
    );
  }
}

class DatePickerExample extends StatefulWidget {
  const DatePickerExample({super.key});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: <Widget>[
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Fundação",
            hintText: selectedDate != null
                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                : null,
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onTap: _selectDate,
        ),
      ],
    );
  }
}
