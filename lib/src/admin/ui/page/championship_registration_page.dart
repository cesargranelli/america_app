import 'package:flutter/material.dart';

class RegisterChampionshipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Championship Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Cor de fundo geral do Scaffold, como o bg da imagem.
        scaffoldBackgroundColor: const Color(
          0xFFFBF8EE,
        ), // Cor creme/amarelada clara da imagem
        // Estilo padrão para os TextFields e Dropdowns
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
      home: ChampionshipRegistrationScreen(),
    );
  }
}

class ChampionshipRegistrationScreen extends StatefulWidget {
  @override
  _ChampionshipRegistrationScreenState createState() =>
      _ChampionshipRegistrationScreenState();
}

class _ChampionshipRegistrationScreenState
    extends State<ChampionshipRegistrationScreen> {
  String? _selectedSportType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // Transparente para usar o background do Scaffold
        elevation: 0, // Sem sombra na AppBar
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF4A4A4A), // Cor do ícone de voltar
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Championship Registration',
          style: TextStyle(
            color: Color(0xFF4A4A4A), // Cor do título
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Padding geral para o conteúdo
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Campo Full Name
            _buildLabel('Full Name'), // Rótulo do campo
            const SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter your full name', // Placeholder
              ),
            ),
            const SizedBox(height: 20.0),

            // Campo Sport Type (Dropdown)
            _buildLabel('Sport Type'), // Rótulo do campo
            const SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedSportType,
              decoration: InputDecoration(
                hintText: 'Select sport', // Placeholder
                // Ícone personalizado de seta dupla (up-down)
                suffixIcon: Icon(
                  Icons.unfold_more, // Representa o ícone de seta dupla
                  color: const Color(0xFF9E8747), // Cor do ícone
                  size: 20.0,
                ),
              ),
              items: <String>['Futebol', 'Basquete', 'Natação', 'Outro']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  })
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSportType = newValue;
                });
              },
              style: const TextStyle(
                color: Color(0xFF4A4A4A), // Cor do texto selecionado
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),

            // Campo Year
            _buildLabel('Year'), // Rótulo do campo
            const SizedBox(height: 8.0),
            TextField(
              keyboardType: TextInputType.number, // Para entrada de ano
              decoration: InputDecoration(
                hintText: 'Enter year', // Placeholder
              ),
            ),
            // Adicionar espaço extra para garantir que o botão "Submit" não se sobreponha a nenhum campo
            // se o teclado estiver visível e a tela não rolar o suficiente.
            const SizedBox(height: 100.0),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0), // Padding ao redor do botão Submit
        child: ElevatedButton(
          onPressed: () {
            // Ação ao submeter o formulário
            print('Formulário de registro enviado!');
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Registro enviado!')));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(
              0xFFFAC638,
            ), // Cor de fundo do botão Submit
            foregroundColor: const Color(
              0xFF4A4A4A,
            ), // Cor do texto do botão Submit
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
          child: const Text('Submit'), // Texto do botão
        ),
      ),
    );
  }

  // Widget auxiliar para construir os rótulos dos campos
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF4A4A4A), // Cor do texto do rótulo
        fontSize: 16.0,
        fontWeight: FontWeight.w600, // Um pouco mais forte para o rótulo
      ),
    );
  }
}
