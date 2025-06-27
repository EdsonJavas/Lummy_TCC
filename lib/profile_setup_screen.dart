import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _nameFocused = false;
  bool _ageFocused = false;
  bool _passwordFocused = false;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleProfileSetup() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Perfil configurado com sucesso!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  void _selectProfileImage() {
    // Aqui você implementaria a seleção de imagem
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Funcionalidade de seleção de foto em desenvolvimento'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    
    // Responsividade para telas muito pequenas
    final isVerySmallScreen = screenHeight < 650;
    final isSmallScreen = screenHeight < 700;
    
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
          ),
          child: Stack(
            children: [
              // Fundo azul ocupando toda a tela
              Container(
                width: double.infinity,
                height: screenHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFF357ABD),
                    ],
                  ),
                ),
              ),
              
              // Astronauta "segurando" na borda da tela - GIRADO
              Positioned(
                top: isVerySmallScreen ? 20 : 40,
                right: isVerySmallScreen ? -60 : -80, // Bem na borda da tela
                child: Transform.rotate(
                  angle: -0.3, // Rotação para parecer que está segurando na borda
                  child: SvgPicture.network(
                    'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Design%20sem%20nome%20%281%29-3cva84Hcw1yVzTEgDHAc16jDZNkolI.svg',
                    height: isVerySmallScreen ? 250 : (isSmallScreen ? 300 : 380),
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => Container(
                      height: isVerySmallScreen ? 250 : (isSmallScreen ? 300 : 380),
                      width: isVerySmallScreen ? 250 : (isSmallScreen ? 300 : 380),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(isVerySmallScreen ? 125 : (isSmallScreen ? 150 : 190)),
                      ),
                      child: Icon(
                        Icons.person,
                        size: isVerySmallScreen ? 100 : (isSmallScreen ? 120 : 180),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Foto de perfil no centro superior - MOVIDA PARA A ESQUERDA
              Positioned(
                top: isVerySmallScreen ? screenHeight * 0.12 : screenHeight * 0.15,
                left: screenWidth * 0.25 - (isVerySmallScreen ? 60 : 75), // Mais para a esquerda
                child: Stack(
                  children: [
                    // Container da foto de perfil
                    Container(
                      width: isVerySmallScreen ? 120 : 150,
                      height: isVerySmallScreen ? 120 : 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF003092),
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          color: const Color(0xFFF5F5F5),
                          child: Icon(
                            Icons.person,
                            size: isVerySmallScreen ? 60 : 75,
                            color: const Color(0xFFBDBDBD),
                          ),
                        ),
                      ),
                    ),
                    
                    // Botão de editar foto
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _selectProfileImage,
                        child: Container(
                          width: isVerySmallScreen ? 35 : 40,
                          height: isVerySmallScreen ? 35 : 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: isVerySmallScreen ? 18 : 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Formulário na parte inferior
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: FormTopClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: isVerySmallScreen ? screenHeight * 0.55 : screenHeight * 0.5,
                      maxHeight: isVerySmallScreen ? screenHeight * 0.75 : screenHeight * 0.7,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: isVerySmallScreen ? 20.0 : 24.0,
                        right: isVerySmallScreen ? 20.0 : 24.0,
                        top: isVerySmallScreen ? 20.0 : 24.0,
                        bottom: (isVerySmallScreen ? 20.0 : 24.0) + keyboardHeight,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isVerySmallScreen ? 20 : (isSmallScreen ? 30 : 50)),
                            
                            // Título "Seja Lummy" - com as cores da logo
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Seja ',
                                      style: GoogleFonts.inter(
                                        fontSize: isVerySmallScreen ? 24 : 28,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Lu',
                                      style: GoogleFonts.paytoneOne(
                                        fontSize: isVerySmallScreen ? 24 : 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'm',
                                      style: GoogleFonts.paytoneOne(
                                        fontSize: isVerySmallScreen ? 24 : 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'm',
                                      style: GoogleFonts.paytoneOne(
                                        fontSize: isVerySmallScreen ? 24 : 28,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF003092),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'y',
                                      style: GoogleFonts.paytoneOne(
                                        fontSize: isVerySmallScreen ? 24 : 28,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 20 : 30),
                            
                            // Campo Nome
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _nameFocused 
                                    ? const Color(0xFF4A90E2)
                                    : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: _nameFocused 
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                              ),
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  setState(() {
                                    _nameFocused = hasFocus;
                                  });
                                },
                                child: TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  style: GoogleFonts.poppins(
                                    fontSize: isVerySmallScreen ? 14 : 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Digite seu nome',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: isVerySmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: _nameFocused 
                                        ? const Color(0xFF4A90E2)
                                        : Colors.grey[500],
                                      size: isVerySmallScreen ? 20 : 22,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isVerySmallScreen ? 16 : 20,
                                      vertical: isVerySmallScreen ? 14 : 18,
                                    ),
                                    errorStyle: GoogleFonts.poppins(
                                      fontSize: isVerySmallScreen ? 10 : 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, digite seu nome';
                                    }
                                    if (value.length < 2) {
                                      return 'Nome deve ter pelo menos 2 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 12 : 16),
                            
                            // Campo "Quem você é!"
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _ageFocused 
                                    ? const Color(0xFF4A90E2)
                                    : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: _ageFocused 
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                              ),
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  setState(() {
                                    _ageFocused = hasFocus;
                                  });
                                },
                                child: TextFormField(
                                  controller: _ageController,
                                  keyboardType: TextInputType.text,
                                  style: GoogleFonts.poppins(
                                    fontSize: isVerySmallScreen ? 14 : 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Quem você é!',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: isVerySmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.psychology_outlined,
                                      color: _ageFocused 
                                        ? const Color(0xFF4A90E2)
                                        : Colors.grey[500],
                                      size: isVerySmallScreen ? 20 : 22,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isVerySmallScreen ? 16 : 20,
                                      vertical: isVerySmallScreen ? 14 : 18,
                                    ),
                                    errorStyle: GoogleFonts.poppins(
                                      fontSize: isVerySmallScreen ? 10 : 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, digite quem você é';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 12 : 16),
                            
                            // Campo Senha
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _passwordFocused 
                                    ? const Color(0xFF4A90E2)
                                    : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: _passwordFocused 
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF4A90E2).withOpacity(0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                              ),
                              child: Focus(
                                onFocusChange: (hasFocus) {
                                  setState(() {
                                    _passwordFocused = hasFocus;
                                  });
                                },
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: !_isPasswordVisible,
                                  style: GoogleFonts.poppins(
                                    fontSize: isVerySmallScreen ? 14 : 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Sua Senha',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: isVerySmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: _passwordFocused 
                                        ? const Color(0xFF4A90E2)
                                        : Colors.grey[500],
                                      size: isVerySmallScreen ? 20 : 22,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: isVerySmallScreen ? 16 : 20,
                                      vertical: isVerySmallScreen ? 14 : 18,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: _passwordFocused 
                                          ? const Color(0xFF4A90E2)
                                          : Colors.grey[500],
                                        size: isVerySmallScreen ? 20 : 22,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible = !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    errorStyle: GoogleFonts.poppins(
                                      fontSize: isVerySmallScreen ? 10 : 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, digite sua senha';
                                    }
                                    if (value.length < 6) {
                                      return 'A senha deve ter pelo menos 6 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 20 : 30),
                            
                            // Botão Avançar
                            Container(
                              width: double.infinity,
                              height: isVerySmallScreen ? 50 : 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8C42),
                                    Color(0xFFFF7A28),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(isVerySmallScreen ? 25 : 28),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF8C42).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleProfileSetup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isVerySmallScreen ? 25 : 28),
                                  ),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                        height: isVerySmallScreen ? 18 : 20,
                                        width: isVerySmallScreen ? 18 : 20,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Avançar',
                                        style: GoogleFonts.poppins(
                                          fontSize: isVerySmallScreen ? 16 : 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 15 : 20),
                          ],
                        ),
                      ),
                    ),
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

// Reutilizando a mesma classe das outras telas
class FormTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 60);
    
    path.quadraticBezierTo(
      size.width * 0.75, 20,
      size.width * 0.5, 20,
    );
    
    path.quadraticBezierTo(
      size.width * 0.25, 20,
      0, 60,
    );
    
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
