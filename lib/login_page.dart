// login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _emailFocused = false;
  bool _passwordFocused = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
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
          content: const Text('Login realizado com sucesso!'),
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
    
    return Scaffold(
      resizeToAvoidBottomInset: true, // Importante para responsividade do teclado
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
              
              // Logo no topo com cores ajustadas e peso do bold suavizado
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, top: 30),
                  child: Row(
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Lu',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Fustat',
                                color: Color(0xFF333333),
                              ),
                            ),
                            TextSpan(
                              text: 'm',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Fustat',
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: 'm',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Fustat',
                                color: Color(0xFF003092),
                              ),
                            ),
                            TextSpan(
                              text: 'y',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Fustat',
                                color: Color(0xFF333333),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Astronauta - responsivo baseado no tamanho da tela
              Positioned(
                top: screenHeight * 0.10,
                left: screenWidth * 0.15,
                right: screenWidth * 0.05,
                child: Center(
                  child: SvgPicture.network(
                    'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/astronauta-lummy-OXK8DpNpgdSxKxNZKtIyQynALBlh6n.svg',
                    height: screenHeight < 700 ? 300 : 380, // Responsivo baseado na altura da tela
                    fit: BoxFit.contain,
                    placeholderBuilder: (context) => Container(
                      height: screenHeight < 700 ? 300 : 380,
                      width: screenHeight < 700 ? 300 : 380,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(screenHeight < 700 ? 150 : 190),
                      ),
                      child: Icon(
                        Icons.person,
                        size: screenHeight < 700 ? 120 : 180,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Formulário na parte inferior - totalmente responsivo
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipPath(
                  clipper: FormTopClipper(),
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: screenHeight * 0.5,
                      maxHeight: screenHeight * 0.7, // Máximo para não ultrapassar
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
                        left: 24.0,
                        right: 24.0,
                        top: 24.0,
                        bottom: 24.0 + keyboardHeight, // Ajusta para o teclado
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight < 700 ? 30 : 50), // Responsivo
                            
                            // Título "Faça Login" com fonte Fustat e peso suavizado
                            const Text(
                              'Faça Login',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Fustat',
                                color: Color(0xFF333333),
                              ),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            // Campo Email estilizado
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Seu E-mail',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: _emailFocused 
                                        ? const Color(0xFF4A90E2)
                                        : Colors.grey[500],
                                      size: 22,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                    errorStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor, insira seu e-mail';
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
                            
                            const SizedBox(height: 16),
                            
                            // Campo Senha estilizado
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
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Sua Senha',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.grey[500],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                      color: _passwordFocused 
                                        ? const Color(0xFF4A90E2)
                                        : Colors.grey[500],
                                      size: 22,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 18,
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: _passwordFocused 
                                          ? const Color(0xFF4A90E2)
                                          : Colors.grey[500],
                                        size: 22,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible = !_isPasswordVisible;
                                        });
                                      },
                                    ),
                                    errorStyle: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
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
                            
                            const SizedBox(height: 30),
                            
                            // Botão Login com gradiente
                            Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFFF8C42),
                                    Color(0xFFFF7A28),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(28),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF8C42).withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            Colors.white,
                                          ),
                                        ),
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                              ),
                            ),
                            
                            const SizedBox(height: 30),
                            
                            // Link para criar conta
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Navegar para tela de cadastro'),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                },
                                child: RichText(
                                  text: const TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Ainda não tem uma conta? ',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF9E9E9E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Crie uma conta',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF003092),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
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

// Classe personalizada para criar a curva na parte superior do formulário
class FormTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Começar do canto inferior esquerdo
    path.moveTo(0, size.height);
    
    // Linha para o canto inferior direito
    path.lineTo(size.width, size.height);
    
    // Linha para o canto superior direito (mas um pouco abaixo para criar a curva)
    path.lineTo(size.width, 60);
    
    // Criar uma curva suave na parte superior
    path.quadraticBezierTo(
      size.width * 0.75, 20,  // Ponto de controle
      size.width * 0.5, 20,   // Ponto médio
    );
    
    path.quadraticBezierTo(
      size.width * 0.25, 20,  // Ponto de controle
      0, 60,                  // Ponto final
    );
    
    // Fechar o caminho
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}