import 'dart:io'; // Para o tipo File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationTeamPage extends StatelessWidget {
  const RegistrationTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Team Registration with Logo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(
          0xFFFBF8EE,
        ), // Cor creme/amarelada clara
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(
            0xFFF4F0E6,
          ), // Cor de fundo dos campos de entrada
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0,
            horizontal: 16.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // Bordas arredondadas
            borderSide: BorderSide.none, // Sem borda visível
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(
            color: const Color(0xFF9E8747), // Cor do placeholder
            fontSize: 16.0,
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF4A4A4A)), // Cor geral do texto
          bodyMedium: TextStyle(color: Color(0xFF4A4A4A)),
          labelLarge: TextStyle(color: Color(0xFF4A4A4A)), // Cor dos rótulos
        ),
      ),
      home: TeamRegistrationScreenWithLogo(),
    );
  }
}

class TeamRegistrationScreenWithLogo extends StatefulWidget {
  @override
  _TeamRegistrationScreenWithLogoState createState() =>
      _TeamRegistrationScreenWithLogoState();
}

class _TeamRegistrationScreenWithLogoState
    extends State<TeamRegistrationScreenWithLogo> {
  TextEditingController _foundingDateController = TextEditingController();
  String? _selectedSportTypes;
  File? _teamLogoImage; // Variável para armazenar a imagem do logotipo

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
              primary: const Color(0xFFFAC638), // Cor do seletor de data
              onPrimary: Colors.white,
              onSurface: const Color(0xFF4A4A4A),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(
                  0xFF4A4A4A,
                ), // Cor dos botões do seletor
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

  Future<void> _pickTeamLogo() async {
    final ImagePicker picker = ImagePicker();
    // Permite ao usuário escolher entre galeria ou câmera
    final XFile? image = await showModalBottomSheet<XFile>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galeria de Fotos'),
                onTap: () {
                  Navigator.pop(
                    context,
                    picker.pickImage(source: ImageSource.gallery),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Câmera'),
                onTap: () {
                  Navigator.pop(
                    context,
                    picker.pickImage(source: ImageSource.camera),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    if (image != null) {
      setState(() {
        _teamLogoImage = File(image.path); // Converte XFile para File
      });
    }
  }

  @override
  void dispose() {
    _foundingDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4A4A4A)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Team Registration',
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Campo Team Name
            _buildLabel('Team Name'),
            const SizedBox(height: 8.0),
            TextField(decoration: InputDecoration(hintText: 'Enter team name')),
            const SizedBox(height: 20.0),

            // Campo Abbreviation
            _buildLabel('Abbreviation'),
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(hintText: 'Enter abbreviation'),
            ),
            const SizedBox(height: 20.0),

            // Campo Founding Date
            _buildLabel('Founding Date'),
            const SizedBox(height: 8.0),
            TextField(
              controller: _foundingDateController,
              readOnly: true,
              onTap: () => _selectFoundingDate(context),
              decoration: InputDecoration(
                hintText: 'Select founding date',
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Color(0xFF9E8747),
                  ),
                  onPressed: () => _selectFoundingDate(context),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Campo Location
            _buildLabel('Location'),
            const SizedBox(height: 8.0),
            TextField(decoration: InputDecoration(hintText: 'Enter location')),
            const SizedBox(height: 20.0),

            // Campo City
            _buildLabel('City'),
            const SizedBox(height: 8.0),
            TextField(decoration: InputDecoration(hintText: 'Enter city')),
            const SizedBox(height: 20.0),

            // Campo State
            _buildLabel('State'),
            const SizedBox(height: 8.0),
            TextField(decoration: InputDecoration(hintText: 'Enter state')),
            const SizedBox(height: 20.0),

            // Campo Participating Sport Types (Dropdown)
            _buildLabel('Participating Sport Types'),
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedSportTypes,
              decoration: InputDecoration(
                hintText: 'Select sport types',
                suffixIcon: Icon(
                  Icons.unfold_more,
                  color: const Color(0xFF9E8747),
                  size: 20.0,
                ),
              ),
              items:
                  <String>[
                    'Futebol',
                    'Basquete',
                    'Natação',
                    'Vôlei',
                    'Outro',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSportTypes = newValue;
                });
              },
              style: const TextStyle(color: Color(0xFF4A4A4A), fontSize: 16.0),
            ),
            const SizedBox(height: 30.0), // Espaçamento antes do upload de logo
            // Campo Upload Team Logo
            _buildLabel('Upload Team Logo'), // Rótulo "Upload Team Logo"
            const SizedBox(height: 8.0),
            Container(
              height: 200, // Altura do container de upload
              decoration: BoxDecoration(
                color: Colors.white, // Fundo branco do container
                borderRadius: BorderRadius.circular(
                  12.0,
                ), // Bordas arredondadas
                border: Border.all(
                  color: const Color(
                    0xFFDDDCDC,
                  ), // Cor da borda tracejada (simulada)
                  style: BorderStyle.solid, // Borda sólida
                  width: 2.0,
                ),
              ),
              child: InkWell(
                // Usando InkWell para o efeito de toque
                onTap: _pickTeamLogo, // Chama a função para selecionar a imagem
                borderRadius: BorderRadius.circular(
                  12.0,
                ), // Bordas arredondadas para o ripple
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _teamLogoImage != null
                        ? ClipRRect(
                            // Para exibir a imagem selecionada
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              _teamLogoImage!,
                              height: 120, // Altura da imagem
                              width: 120, // Largura da imagem
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            children: [
                              Text(
                                'Upload Team Logo',
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Tap to upload your team\'s logo',
                                style: TextStyle(
                                  color: Color(0xFF9E8747), // Cor do texto
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(height: 16.0),
                    // O botão 'Upload' dentro do InkWell para a imagem
                    if (_teamLogoImage ==
                        null) // Mostra o botão 'Upload' apenas se nenhuma imagem foi selecionada
                      ElevatedButton(
                        onPressed:
                            _pickTeamLogo, // Chama a função para selecionar a imagem
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFFF4F0E6,
                          ), // Cor de fundo levemente amarelada
                          foregroundColor: const Color(
                            0xFF9E8747,
                          ), // Cor do texto
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ), // Bordas arredondadas
                          ),
                          elevation: 0, // Sem sombra
                        ),
                        child: const Text('Upload'),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0), // Espaço antes do botão final
          ],
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

  // Widget auxiliar para construir os rótulos dos campos
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4A4A4A), // Cor do texto do rótulo
          fontSize: 16.0,
          fontWeight: FontWeight.w600, // Um pouco mais forte para o rótulo
        ),
      ),
    );
  }
}
