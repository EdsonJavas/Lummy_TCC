import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = "Maria";
  final int userLevel = 5;
  final int totalPoints = 2190;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          // Header com paisagem e foto de perfil
          _buildProfileHeader(screenWidth, screenHeight),
          
          // Conteúdo inferior
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFE8F4F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título "Nome"
                    Text(
                      'Nome',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Botões de configuração
                    _buildConfigButton(
                      'configurações',
                      Icons.settings,
                      Color(0xFF4299E1),
                      false,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    _buildConfigButton(
                      'editar e-mail e senhas',
                      Icons.edit,
                      Color(0xFF4299E1),
                      false,
                    ),
                    
                    const SizedBox(height: 12),
                    
                    _buildConfigButton(
                      'sair da conta',
                      Icons.logout,
                      Color(0xFF48BB78),
                      true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.50,
      width: double.infinity,
      child: Stack(
        children: [
          // Imagem de fundo
          Container(
            height: screenHeight * 0.50,
            width: double.infinity,
            child: Image.network(
              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/fotocriancafodase%201-MFp8K8GLj7deZeGCFVqMJVDVgEtfsc.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF87CEEB),
                        Color(0xFF4CAF50),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Botão voltar
          Positioned(
            top: 50,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          
          // Título "Seu Perfil"
          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Seu Perfil',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          // Foto de perfil centralizada
          Positioned(
            top: screenHeight * 0.15,
            left: screenWidth / 2 - 60,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFF1E40AF), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF87CEEB).withOpacity(0.3),
                  ),
                  child: Image.network(
                    'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Lum%202-0CkW5uvZjaDxIjCSextrqE198N99r7.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1E40AF).withOpacity(0.1),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF1E40AF),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          
          // Badge de nível e pontos
          Positioned(
            top: screenHeight * 0.28,
            left: screenWidth / 2 - 80,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge de nível
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF8C42),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      userLevel.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(width: 20),
                
                // Pontos totais
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xFFFF8C42),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          totalPoints.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'PONTOS TOTAIS',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigButton(String title, IconData icon, Color color, bool isGreen) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: isGreen ? Color(0xFF48BB78) : Color(0xFF4299E1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (isGreen ? Color(0xFF48BB78) : Color(0xFF4299E1)).withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (title == 'sair da conta') {
              // Implementar logout
              Navigator.of(context).popUntil((route) => route.isFirst);
            } else {
              // Implementar outras ações
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
