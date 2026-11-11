import 'package:flutter/material.dart';
import '../utils/validators.dart';

class ValidationDemoScreen extends StatefulWidget {
  const ValidationDemoScreen({super.key});

  @override
  State<ValidationDemoScreen> createState() => _ValidationDemoScreenState();
}

class _ValidationDemoScreenState extends State<ValidationDemoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _urlController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Semua input valid!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Validasi Latihan 3'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  hintText: 'Contoh: 081234567890',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validatePhone,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'URL Website',
                  hintText: 'Contoh: https://google.com',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateUrl,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Min 8 char, 1 kapital, 1 angka, 1 simbol',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validatePassword,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Uji Validasi Input'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}