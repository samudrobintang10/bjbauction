import 'package:flutter/material.dart';
import 'package:bjbauction/pages/loginscreen.dart';
import 'package:bjbauction/pages/surveyformscreen1.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  bool _isError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent resize when keyboard appears
      body: SafeArea(
        child: SingleChildScrollView( // Allow scrolling when keyboard shows
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Daftar Akun',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5B8F),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Daftarkan akunmu untuk mendapatkan',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'akses lebih luas!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                
                // Email field
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Masukkan email',
                    prefixIcon: Icon(Icons.email, color: Color(0xFF1A5B8F)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF1A5B8F)),
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Password field
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  decoration: InputDecoration(
                    hintText: 'Masukkan password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1A5B8F)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF1A5B8F)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                // Confirm password field
                Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_showConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Masukkan ulang password',
                    prefixIcon: Icon(Icons.lock, color: Color(0xFF1A5B8F)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xFF1A5B8F)),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _showConfirmPassword = !_showConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                                
                if (_isError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  ),
                
                SizedBox(height: 24), // Fixed height instead of Spacer()
                
                // Sign Up button
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _validateAndSignUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1A5B8F),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white, // Explicit color for visibility
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sudah memiliki akun? ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Masuk',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A5B8F),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSignUp() {
    // Reset error state
    setState(() {
      _isError = false;
      _errorMessage = '';
    });

    // Simple validation
    if (_emailController.text.isEmpty || 
        _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty) {
      setState(() {
        _isError = true;
        _errorMessage = 'Semua field harus diisi';
      });
      return;
    }

    if (!_emailController.text.contains('@')) {
      setState(() {
        _isError = true;
        _errorMessage = 'Email tidak valid';
      });
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _isError = true;
        _errorMessage = 'Password dan konfirmasi password tidak sama';
      });
      return;
    }

    // Simulate signup success and navigate to Survey Form
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SurveyFormScreen1()),
    );
  }
}