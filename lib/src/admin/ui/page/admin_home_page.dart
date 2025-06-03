import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Home Menu M3',
      theme: ThemeData(
        useMaterial3: true, // Habilita o Material 3
        primarySwatch: Colors.blue,
        // Cor de fundo geral do Scaffold e do Drawer, como na imagem
        scaffoldBackgroundColor: const Color(
          0xFFFBF8EE,
        ), // Cor creme/amarelada clara
        // Tema de texto para combinar as cores da imagem
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFF4A4A4A),
          ), // Cor padrão do texto
          bodyLarge: TextStyle(color: Color(0xFF4A4A4A)),
        ),
      ),
      home: AdminHomeScreenM3(),
    );
  }
}

class AdminHomeScreenM3 extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(color: Color(0xFF4A4A4A)), // Cor do título
        ),
        backgroundColor:
            Colors.transparent, // AppBar transparente para o Drawer
        elevation: 0, // Remove a sombra
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color(0xFF4A4A4A),
          ), // Ícone de menu para abrir o Drawer
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: AppDrawerM3(), // Nosso Drawer personalizado para Material 3
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo à página principal!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Text('Abrir Menu'),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawerM3 extends StatelessWidget {
  const AppDrawerM3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cores extraídas da imagem para fidelidade
    final Color drawerBackgroundColor = const Color(
      0xFFFBF8EE,
    ); // Fundo do Drawer
    final Color textColor = const Color(0xFF4A4A4A); // Cor escura para o texto
    final Color selectedItemBackgroundColor = const Color(
      0xFFF4F0E6,
    ); // Fundo do item "Home" selecionado
    final Color selectedItemIconTextColor = const Color(
      0xFF9E8747,
    ); // Cor do ícone e texto "Home" selecionado

    return Drawer(
      backgroundColor: drawerBackgroundColor, // Define a cor de fundo do Drawer
      width:
          MediaQuery.of(context).size.width *
          0.75, // Ajuste a largura do drawer se necessário
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
        children: <Widget>[
          // Cabeçalho do Drawer com o nome do usuário
          Padding(
            padding: const EdgeInsets.fromLTRB(
              20.0,
              60.0,
              20.0,
              20.0,
            ), // Padding conforme a imagem
            child: Text(
              'Sophia Carter', // Nome do usuário
              style: TextStyle(
                color: textColor, // Cor do texto
                fontSize: 24.0, // Tamanho da fonte do nome
                fontWeight: FontWeight.bold, // Negrito para o nome
              ),
            ),
          ),
          // Lista de opções do menu
          Expanded(
            // Expanded para as opções ocuparem o espaço restante
            child: ListView(
              padding: EdgeInsets.zero, // Remove o padding padrão do ListView
              children: <Widget>[
                // Item Home (selecionado)
                _buildDrawerItem(
                  context,
                  icon: Icons.home,
                  text: 'Home',
                  isSelected: true,
                  backgroundColor: selectedItemBackgroundColor,
                  iconColor: selectedItemIconTextColor,
                  textColor: selectedItemIconTextColor,
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para a Home
                  },
                ),
                // Outros itens
                _buildDrawerItem(
                  context,
                  icon: Icons.calendar_today,
                  text: 'My Events',
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para Meus Eventos
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.people,
                  text: 'My Teams',
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para Meus Times
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.person,
                  text: 'My Profile',
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para Meu Perfil
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  text: 'Settings',
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para Configurações
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  text: 'Help',
                  onTap: () {
                    Navigator.pop(context); // Fecha o drawer
                    // Ação para navegar para Ajuda
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para construir os itens do Drawer
  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isSelected = false,
    Color? backgroundColor,
    Color? iconColor,
    Color? textColor,
  }) {
    // Cores padrão para itens não selecionados, extraídas da imagem
    final Color defaultIconTextColor = const Color(0xFF4A4A4A);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      ), // Padding ajustado conforme a imagem
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? backgroundColor
              : Colors.transparent, // Fundo transparente ou customizado
          borderRadius: BorderRadius.circular(
            12.0,
          ), // Bordas arredondadas para o item selecionado
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isSelected
                ? iconColor
                : defaultIconTextColor, // Cor do ícone
            size: 24.0, // Tamanho do ícone
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? textColor
                  : defaultIconTextColor, // Cor do texto
              fontSize: 18.0, // Tamanho da fonte dos itens
              fontWeight: isSelected
                  ? FontWeight.w600
                  : FontWeight.normal, // Negrito para item selecionado
            ),
          ),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ), // Padding interno do ListTile
        ),
      ),
    );
  }
}
