// register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;
  bool _emailFocused = false;
  bool _passwordFocused = false;
  bool _confirmPasswordFocused = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
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
          content: const Text('Conta criada com sucesso!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
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
              
              // Logo no topo - SUBIDO (menos padding)
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.0, 
                    top: isVerySmallScreen ? 10 : 20, // Reduzido de 30
                  ),
                  child: Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Lu',
                              style: GoogleFonts.paytoneOne(
                                fontSize: isVerySmallScreen ? 28 : 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'm',
                              style: GoogleFonts.paytoneOne(
                                fontSize: isVerySmallScreen ? 28 : 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: 'm',
                              style: GoogleFonts.paytoneOne(
                                fontSize: isVerySmallScreen ? 28 : 32,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF003092),
                              ),
                            ),
                            TextSpan(
                              text: 'y',
                              style: GoogleFonts.paytoneOne(
                                fontSize: isVerySmallScreen ? 28 : 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Astronauta - mesmo tamanho da tela de login
              Positioned(
                top: isVerySmallScreen ? screenHeight * 0.08 : screenHeight * 0.10,
                left: screenWidth * 0.15,
                right: screenWidth * 0.05,
                child: Center(
                  child: SvgPicture.network(
                    'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/astronauta-lummy-OXK8DpNpgdSxKxNZKtIyQynALBlh6n.svg',
                    height: isVerySmallScreen ? 250 : (isSmallScreen ? 300 : 380), // Mesmo tamanho do login
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
              
              // Formulário na parte inferior - ajustado para não empurrar o astronauta
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: FormTopClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: isVerySmallScreen ? screenHeight * 0.6 : screenHeight * 0.55,
                      maxHeight: isVerySmallScreen ? screenHeight * 0.8 : screenHeight * 0.75,
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
                            SizedBox(height: isVerySmallScreen ? 15 : (isSmallScreen ? 25 : 35)),
                            
                            // Título "Crie sua conta" - responsivo
                            Text(
                              'Crie sua conta',
                              style: GoogleFonts.inter(
                                fontSize: isVerySmallScreen ? 24 : 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 15 : 20),
                            
                            // Campo E-mail do responsável
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _emailFocused 
                                    ? const Color(0xFF4A90E2)
                                    : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: _emailFocused 
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
                                    _emailFocused = hasFocus;
                                  });
                                },
                                child: TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: GoogleFonts.poppins(
                                    fontSize: isVerySmallScreen ? 14 : 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'E-mail do responsável',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: isVerySmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: _emailFocused 
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
                                      return 'Por favor, insira o e-mail do responsável';
                                    }
                                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(value)) {
                                      return 'Por favor, insira um e-mail válido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 10 : 14),
                            
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
                                      return 'Por favor, insira sua senha';
                                    }
                                    if (value.length < 6) {
                                      return 'A senha deve ter pelo menos 6 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 10 : 14),
                            
                            // Campo Confirmar Senha
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _confirmPasswordFocused 
                                    ? const Color(0xFF4A90E2)
                                    : Colors.transparent,
                                  width: 2,
                                ),
                                boxShadow: _confirmPasswordFocused 
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
                                    _confirmPasswordFocused = hasFocus;
                                  });
                                },
                                child: TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: !_isConfirmPasswordVisible,
                                  style: GoogleFonts.poppins(
                                    fontSize: isVerySmallScreen ? 14 : 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Confirme sua Senha',
                                    hintStyle: GoogleFonts.poppins(
                                      color: Colors.grey[500],
                                      fontSize: isVerySmallScreen ? 14 : 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: _confirmPasswordFocused 
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
                                        _isConfirmPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: _confirmPasswordFocused 
                                          ? const Color(0xFF4A90E2)
                                          : Colors.grey[500],
                                        size: isVerySmallScreen ? 20 : 22,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                        });
                                      },
                                    ),
                                    errorStyle: GoogleFonts.poppins(
                                      fontSize: isVerySmallScreen ? 10 : 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, confirme sua senha';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'As senhas não coincidem';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            
                            SizedBox(height: isVerySmallScreen ? 15 : 20),
                            
                            // Botão Avançar com gradiente
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
                                onPressed: _isLoading ? null : _handleRegister,
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
                            
                            // Link para fazer login
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Já tem uma conta Lummy? ',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF9E9E9E),
                                          fontSize: isVerySmallScreen ? 12 : 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Faça Login',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0xFF003092),
                                          fontSize: isVerySmallScreen ? 12 : 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
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

// Reutilizando a mesma classe do login
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
