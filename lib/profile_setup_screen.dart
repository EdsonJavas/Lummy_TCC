import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';

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
  void initState() {
    super.initState();
  }

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
      
      // Navegar para a HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  void _selectProfileImage() {
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

    // Sistema de responsividade
    final isExtraSmallScreen = screenHeight < 600;
    final isVerySmallScreen = screenHeight < 650;
    final isSmallScreen = screenHeight < 700;
    final isMediumScreen = screenHeight < 800;

    // Tamanhos adaptativos
    final astronautSize = isExtraSmallScreen ? 350.0 :
                          isVerySmallScreen ? 420.0 :
                          isSmallScreen ? 480.0 :
                          isMediumScreen ? 550.0 : 600.0;

    final profileImageSize = isExtraSmallScreen ? 100.0 :
                             isVerySmallScreen ? 120.0 :
                             isSmallScreen ? 140.0 : 160.0;

    final formHeightRatio = isExtraSmallScreen ? 0.65 :
                            isVerySmallScreen ? 0.60 :
                            isSmallScreen ? 0.55 : 0.50;

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
              // Fundo azul com gradiente
              Container(
                width: double.infinity,
                height: screenHeight,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4A90E2),
                      Color(0xFF357ABD),
                      Color(0xFF2E5F8F),
                    ],
                    stops: [0.0, 0.6, 1.0],
                  ),
                ),
              ),

              // Astronauta na posição original
              Positioned(
                top: isExtraSmallScreen ? -20 :
                      isVerySmallScreen ? -10 :
                      isSmallScreen ? 10 : 30,
                right: isExtraSmallScreen ? -100 :
                        isVerySmallScreen ? -120 :
                        isSmallScreen ? -140 : -160,
                child: Transform.rotate(
                  angle: -0.2,
                  child: SvgPicture.network(
                    'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Design%20sem%20nome%20%281%29-3cva84Hcw1yVzTEgDHAc16jDZNkolI.svg',
                    height: astronautSize,
                    width: astronautSize,
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => Container(
                      height: astronautSize,
                      width: astronautSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(astronautSize / 2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: astronautSize * 0.4,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),

              // Campo de foto SIMPLES com cores do app
              Positioned(
                top: isExtraSmallScreen ? screenHeight * 0.12 :
                      isVerySmallScreen ? screenHeight * 0.14 :
                      isSmallScreen ? screenHeight * 0.16 :
                      screenHeight * 0.18,
                left: screenWidth * 0.08,
                child: Stack(
                  children: [
                    // Container principal com cores do app
                    Container(
                      width: profileImageSize,
                      height: profileImageSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4A90E2), // Azul do app
                          width: isExtraSmallScreen ? 3 : 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4A90E2).withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FBFF), // Azul muito claro
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: profileImageSize * 0.3,
                                  color: const Color(0xFF4A90E2),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Adicionar foto',
                                  style: GoogleFonts.poppins(
                                    fontSize: isExtraSmallScreen ? 10 : 12,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4A90E2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Botão de adicionar simples
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _selectProfileImage,
                        child: Container(
                          width: isExtraSmallScreen ? 36 : 40,
                          height: isExtraSmallScreen ? 36 : 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A90E2), // Azul do app
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF4A90E2).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: isExtraSmallScreen ? 18 : 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Formulário
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: FormTopClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight * formHeightRatio,
                      maxHeight: screenHeight * (formHeightRatio + 0.15),
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 25,
                          offset: const Offset(0, -10),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        left: isExtraSmallScreen ? 16.0 : 20.0,
                        right: isExtraSmallScreen ? 16.0 : 20.0,
                        top: isExtraSmallScreen ? 16.0 : 20.0,
                        bottom: (isExtraSmallScreen ? 16.0 : 20.0) + keyboardHeight,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isExtraSmallScreen ? 15 :
                                              isVerySmallScreen ? 20 :
                                              isSmallScreen ? 25 : 35),

                            // Título "Seja Lummy"
                            Center(
                              child: Column(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Seja ',
                                          style: GoogleFonts.inter(
                                            fontSize: isExtraSmallScreen ? 22 :
                                                      isVerySmallScreen ? 24 : 26,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'Lu',
                                          style: GoogleFonts.paytoneOne(
                                            fontSize: isExtraSmallScreen ? 22 :
                                                      isVerySmallScreen ? 24 : 26,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'm',
                                          style: GoogleFonts.paytoneOne(
                                            fontSize: isExtraSmallScreen ? 22 :
                                                      isVerySmallScreen ? 24 : 26,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFFFF8C42),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'm',
                                          style: GoogleFonts.paytoneOne(
                                            fontSize: isExtraSmallScreen ? 22 :
                                                      isVerySmallScreen ? 24 : 26,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF003092),
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'y',
                                          style: GoogleFonts.paytoneOne(
                                            fontSize: isExtraSmallScreen ? 22 :
                                                      isVerySmallScreen ? 24 : 26,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: isExtraSmallScreen ? 4 : 6),
                                  Text(
                                    'Configure seu perfil',
                                    style: GoogleFonts.poppins(
                                      fontSize: isExtraSmallScreen ? 12 : 14,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: isExtraSmallScreen ? 16 : 20),

                            // Campos do formulário
                            _buildTextField(
                              controller: _nameController,
                              hintText: 'Digite seu nome',
                              icon: Icons.person_outline,
                              isFocused: _nameFocused,
                              onFocusChange: (hasFocus) => setState(() => _nameFocused = hasFocus),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite seu nome';
                                }
                                if (value.length < 2) {
                                  return 'Nome deve ter pelo menos 2 caracteres';
                                }
                                return null;
                              },
                              isExtraSmallScreen: isExtraSmallScreen,
                            ),

                            SizedBox(height: isExtraSmallScreen ? 10 : 12),

                            _buildTextField(
                              controller: _ageController,
                              hintText: 'Quem você é!',
                              icon: Icons.psychology_outlined,
                              isFocused: _ageFocused,
                              onFocusChange: (hasFocus) => setState(() => _ageFocused = hasFocus),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite quem você é';
                                }
                                return null;
                              },
                              isExtraSmallScreen: isExtraSmallScreen,
                            ),

                            SizedBox(height: isExtraSmallScreen ? 10 : 12),

                            _buildTextField(
                              controller: _passwordController,
                              hintText: 'Sua Senha',
                              icon: Icons.lock_outline,
                              isFocused: _passwordFocused,
                              onFocusChange: (hasFocus) => setState(() => _passwordFocused = hasFocus),
                              isPassword: true,
                              isPasswordVisible: _isPasswordVisible,
                              onTogglePassword: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, digite sua senha';
                                }
                                if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                              isExtraSmallScreen: isExtraSmallScreen,
                            ),

                            SizedBox(height: isExtraSmallScreen ? 16 : 20),

                            // Botão Avançar
                            Container(
                              width: double.infinity,
                              height: isExtraSmallScreen ? 48 : 52,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8C42),
                                    Color(0xFFFF7A28),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(isExtraSmallScreen ? 24 : 26),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF8C42).withOpacity(0.4),
                                    blurRadius: 15,
                                    offset: const Offset(0, 6),
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
                                    borderRadius: BorderRadius.circular(isExtraSmallScreen ? 24 : 26),
                                  ),
                                ),
                                child: _isLoading
                                    ? SizedBox(
                                        height: isExtraSmallScreen ? 16 : 18,
                                        width: isExtraSmallScreen ? 16 : 18,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'Avançar',
                                        style: GoogleFonts.poppins(
                                          fontSize: isExtraSmallScreen ? 15 : 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),

                            SizedBox(height: isExtraSmallScreen ? 12 : 16),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isFocused,
    required Function(bool) onFocusChange,
    required String? Function(String?) validator,
    required bool isExtraSmallScreen,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused ? const Color(0xFF4A90E2) : Colors.transparent,
          width: 2,
        ),
        boxShadow: isFocused
            ? [
                BoxShadow(
                  color: const Color(0xFF4A90E2).withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Focus(
        onFocusChange: onFocusChange,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword && !isPasswordVisible,
          keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.text,
          textCapitalization: isPassword ? TextCapitalization.none : TextCapitalization.words,
          style: GoogleFonts.poppins(
            fontSize: isExtraSmallScreen ? 13 : 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey[500],
              fontSize: isExtraSmallScreen ? 13 : 15,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(
              icon,
              color: isFocused ? const Color(0xFF4A90E2) : Colors.grey[500],
              size: isExtraSmallScreen ? 18 : 20,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: isFocused ? const Color(0xFF4A90E2) : Colors.grey[500],
                      size: isExtraSmallScreen ? 18 : 20,
                    ),
                    onPressed: onTogglePassword,
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isExtraSmallScreen ? 14 : 16,
              vertical: isExtraSmallScreen ? 12 : 14,
            ),
            errorStyle: GoogleFonts.poppins(
              fontSize: isExtraSmallScreen ? 10 : 11,
            ),
          ),
          validator: validator,
        ),
      ),
    );
  }
}

class FormTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 50);

    path.quadraticBezierTo(
      size.width * 0.8, 15,
      size.width * 0.5, 15,
    );

    path.quadraticBezierTo(
      size.width * 0.2, 15,
      0, 50,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
