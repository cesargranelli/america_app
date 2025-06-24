import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationPlayerPage extends StatelessWidget {
  const RegistrationPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stitch Design Registration',
      theme: ThemeData(
        // Definir as fontes Lexend e Noto Sans requer configurar o pubspec.yaml
        // e carregar as fontes no Theme. Para simplificar, estamos usando fontes padrão
        // que mais se aproximam ou as fontes padrão do Flutter.
        // fontFamily:
        //     'Lexend', // Você precisaria importar a fonte Lexend para que funcione
        textTheme: GoogleFonts.lexendTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFFCFBF8), // bg-[#fcfbf8]
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF4F0E6), // bg-[#f4f0e6]
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0), // rounded-xl
            borderSide: BorderSide.none, // border-none
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none, // focus:border-none
          ),
          hintStyle: TextStyle(
            color: const Color(0xFF9E8747), // placeholder:text-[#9e8747]
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            height: 1.4, // leading-normal
          ),
          contentPadding: const EdgeInsets.all(16.0), // p-4
        ),
      ),
      home: RegistrationScreen(),
    );
  }
}

// Para usar fontes customizadas como Lexend, você precisaria:
// 1. Baixar os arquivos .ttf da Google Fonts.
// 2. Criar uma pasta 'fonts' (ou similar) no seu projeto.
// 3. Adicionar as fontes ao seu pubspec.yaml:
/*
  fonts:
    - family: Lexend
      fonts:
        - asset: fonts/Lexend-Regular.ttf
        - asset: fonts/Lexend-Medium.ttf
          weight: 500
        - asset: fonts/Lexend-Bold.ttf
          weight: 700
        - asset: fonts/Lexend-ExtraBold.ttf
          weight: 900 # ou Black, dependendo do nome
    - family: Noto Sans
      fonts:
        - asset: fonts/NotoSans-Regular.ttf
        // Adicionar outros pesos conforme necessário
*/
// 4. Depois de configurar, o Theme.of(context).textTheme usará essas fontes.
// No exemplo, estou definindo 'Lexend' como fontFamily globalmente.

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _selectedSport;
  String? _selectedSportType;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset já é true por padrão e ajuda com o teclado
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCFBF8), // bg-[#fcfbf8]
        elevation: 0, // Sem sombra
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 8.0,
          ), // Adiciona padding para o ícone
          child: InkWell(
            // Para o efeito de ripple no ícone
            onTap: () {
              // Ação de voltar
              Navigator.of(context).pop();
            },
            borderRadius: BorderRadius.circular(
              24.0,
            ), // Para o ripple arredondado
            child: Container(
              width: 48, // size-12 (approx 48px)
              height: 48,
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF1C180D), // text-[#1c180d]
                size: 24.0, // data-size="24px"
              ),
            ),
          ),
        ),
        title: const Text(
          'Cadastro de Atleta',
          style: TextStyle(
            color: Color(0xFF1C180D), // text-[#1c180d]
            fontSize: 18.0, // text-lg
            fontWeight: FontWeight.bold, // font-bold
            letterSpacing: -0.015 * 18, // tracking-[-0.015em]
          ),
        ),
        centerTitle: true, // text-center
        titleSpacing: 0, // Remove espaço extra
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container principal para os campos de entrada, com max-width e padding
            Center(
              // Para replicar max-w-[480px] e centralizar
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ), // px-4 py-3
                child: Column(
                  // flex-wrap items-end gap-4
                  children: [
                    // Name Input
                    _buildFormField(
                      label: 'Name',
                      placeholder: 'Enter your name',
                    ),
                    const SizedBox(height: 16.0), // gap-4
                    // Sport Dropdown
                    _buildDropdownField(
                      label: 'Sport',
                      hintText: 'Select your sport',
                      value: _selectedSport,
                      items: const ['Futebol', 'Basquete', 'Natação', 'Outro'],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSport = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0), // gap-4
                    // Age Input
                    _buildFormField(
                      label: 'Age',
                      placeholder: 'Enter your age',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0), // gap-4
                    // Jersey Number Input
                    _buildFormField(
                      label: 'Jersey Number',
                      placeholder: 'Enter your jersey number',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0), // gap-4
                    // Sport Type Dropdown
                    _buildDropdownField(
                      label: 'Sport Type',
                      hintText: 'Select your sport type',
                      value: _selectedSportType,
                      items: const ['Individual', 'Coletivo'],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedSportType = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0), // gap-4
                    // Gender Dropdown
                    _buildDropdownField(
                      label: 'Gender',
                      hintText: 'Select your gender',
                      value: _selectedGender,
                      items: const ['Masculino', 'Feminino', 'Outro'],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                    Container(
                      color: const Color(0xFFFCFBF8), // bg-[#fcfbf8]
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ), // px-4 py-3
                      child: Center(
                        // Para replicar max-w-[480px] e centralizar
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: ElevatedButton(
                            onPressed: () {
                              // Ação de submeter o formulário
                              print('Formulário Submetido!');
                              print('Esporte: $_selectedSport');
                              print('Tipo de Esporte: $_selectedSportType');
                              print('Gênero: $_selectedGender');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Formulário Submetido!'),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(
                                0xFFFAC638,
                              ), // bg-[#fac638]
                              foregroundColor: const Color(
                                0xFF1C180D,
                              ), // text-[#1c180d]
                              minimumSize: const Size(
                                double.infinity,
                                48,
                              ), // h-12 (48px)
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  12.0,
                                ), // rounded-xl
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16.0, // text-base
                                fontWeight: FontWeight.bold, // font-bold
                                letterSpacing: 0.015 * 16, // tracking-[0.015em]
                              ),
                            ),
                            child: const Text('Submit'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xFFFCFBF8), // bg-[#fcfbf8]
        child: Padding(
          padding: EdgeInsets.all(16.0), // p-4
          child: Text(
            'Powered by Stitch Design',
            style: TextStyle(
              color: Color(0xFF1C180D), // text-[#1c180d]
              fontSize: 14.0, // text-sm
              fontWeight: FontWeight.w400, // font-normal
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required String placeholder,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // pb-2
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1C180D), // text-[#1c180d]
              fontSize: 16.0, // text-base
              fontWeight: FontWeight.w500, // font-medium
              height: 1.4, // leading-normal
            ),
          ),
        ),
        TextField(
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Color(0xFF1C180D), // text-[#1c180d]
            fontSize: 16.0, // text-base
            fontWeight: FontWeight.w400, // font-normal
            height: 1.4, // leading-normal
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            // Outros estilos de InputDecoration são definidos no ThemeData acima
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0), // pb-2
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1C180D), // text-[#1c180d]
              fontSize: 16.0, // text-base
              fontWeight: FontWeight.w500, // font-medium
              height: 1.4, // leading-normal
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: hintText,
            // O ícone personalizado do SVG é um pouco mais complexo de replicar diretamente
            // sem um pacote SVG. Usaremos o ícone padrão do Flutter aqui.
            suffixIcon: Icon(
              Icons
                  .keyboard_arrow_down, // Ícone padrão do Flutter para dropdown
              color: const Color(
                0xFF9E8747,
              ), // Cor baseada na variável --select-button-svg
            ),
          ),
          items: items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(
            color: Color(0xFF1C180D), // text-[#1c180d]
            fontSize: 16.0, // text-base
            fontWeight: FontWeight.w400, // font-normal
            height: 1.4, // leading-normal
          ),
          // O estilo do dropdown pode ser mais complexo para replicar exatamente
          // o bg-[image:--select-button-svg], mas o essencial está aqui.
        ),
      ],
    );
  }
}
