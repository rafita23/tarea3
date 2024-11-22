import 'package:flutter/material.dart';

void main() => runApp(ICPCMultiToolsApp());

class ICPCMultiToolsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ICPC Tools',
      home: BottomNavigationMenu(),
    );
  }
}

class BottomNavigationMenu extends StatefulWidget {
  @override
  _BottomNavigationMenuState createState() => _BottomNavigationMenuState();
}

class _BottomNavigationMenuState extends State<BottomNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    PalindromeScreen(),
    FriendlyNumbersScreen(),
    BinaryConverterScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.text_fields),
            label: 'Palíndromo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Números Amigos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: 'Binario',
          ),
        ],
      ),
    );
  }
}

class PalindromeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  bool isPalindrome(String text) {
    String cleanText = text.replaceAll(RegExp(r'[\W_]+'), '').toLowerCase();
    int n = cleanText.length;
    for (int i = 0; i < n ~/ 2; i++) {
      if (cleanText[i] != cleanText[n - i - 1]) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificar Palíndromo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese una oración',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final result = isPalindrome(_controller.text)
                    ? 'Es un palíndromo'
                    : 'No es un palíndromo';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}

class FriendlyNumbersScreen extends StatelessWidget {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();

  int sumOfDivisors(int num) {
    int sum = 1;
    for (int i = 2; i * i <= num; i++) {
      if (num % i == 0) {
        sum += i;
        if (i != num ~/ i) sum += num ~/ i;
      }
    }
    return sum;
  }

  bool areFriendlyNumbers(int a, int b) {
    return sumOfDivisors(a) == b && sumOfDivisors(b) == a;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Identificar Números Amigos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _number1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número 1',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _number2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número 2',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final num1 = int.tryParse(_number1Controller.text) ?? 0;
                final num2 = int.tryParse(_number2Controller.text) ?? 0;
                final result = areFriendlyNumbers(num1, num2)
                    ? 'Son números amigos'
                    : 'No son números amigos';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              },
              child: Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}

class BinaryConverterScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  String convertToBinary(int num) {
    if (num == 0) return '0';
    String binary = '';
    while (num > 0) {
      binary = '${num % 2}' + binary;
      num ~/= 2;
    }
    return binary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convertidor a Binario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ingrese un número entero',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final num = int.tryParse(_controller.text) ?? 0;
                final result = 'Binario: ${convertToBinary(num)}';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              },
              child: Text('Convertir'),
            ),
          ],
        ),
      ),
    );
  }
}
