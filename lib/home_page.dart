// home_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Altura personalizada da AppBar
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  Colors.purpleAccent,
                ], // Gradiente sutil
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ), // Ajustando a posição do título
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Logo SVG do app Lummy
              Center(
                child: SvgPicture.asset(
                  'assets/lummy_logo.svg', // Certifique-se de que o caminho do SVG está correto
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: 16),

              // Saudação
              Text(
                "Bem-vindo ao Lummy!",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),

              // Descrição do TCC
              Text(
                "Lummy é uma plataforma desenvolvida para auxiliar na gestão de finanças pessoais, ajudando o usuário a controlar seus gastos de forma simples e prática. Com o Lummy, você poderá visualizar seus gastos mensais, analisar tendências e manter o controle financeiro de maneira eficiente.",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 32),

              // Botões de ação
              ElevatedButton(
                onPressed: () {
                  // Exemplo de ação
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Saiba Mais',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
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
}
