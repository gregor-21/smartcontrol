import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'global_state.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  List<String> irrigacaoIds = [];
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final TextEditingController _controller = TextEditingController();
  bool _isEditing = false;
  double? areaMetrosQuadrados;
  double? aguaMaxima;
  bool incluirEsgoto = false;

  void _showCalculationInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Como Calcular a Área'),
          content: Text(
            'A área do jardim pode ser calculada utilizando a fórmula: '
            'comprimento x largura.',
          ),
          actions: [
            TextButton(
              child: Text('Fechar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Veja como calcular a área:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: _showCalculationInfo,
                  tooltip: 'Como calcular a área',
                  color: Colors.white70,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                        focusColor: Colors.white70,
                        labelText: 'Área de Irrigação (m²)',
                        hintStyle: TextStyle(color: Colors.white70),
                        labelStyle: TextStyle(color: Colors.white70),
                        hintText: 'Insira a área em metros quadrados',
                        iconColor: Colors.white70),
                    cursorColor: Colors.white70,
                    style: TextStyle(color: Colors.white70),
                    onChanged: (value) {
                      String sanitizedValue = value.replaceAll(',', '.');
                      if (sanitizedValue.endsWith('.')) {
                        sanitizedValue = sanitizedValue.substring(
                            0, sanitizedValue.length - 1);
                      }
                      setState(() {
                        areaMetrosQuadrados = double.tryParse(sanitizedValue);
                      });
                    },
                    enabled: _isEditing,
                  ),
                ),
                if (_isEditing)
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: calcularAguaMaxima,
                    color: Colors.green,
                    tooltip: 'Salvar Área',
                  )
                else
                  IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.white70,
                    onPressed: () {
                      setState(() {
                        _isEditing = true;
                      });
                    },
                  ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.white70),
              title: const Text('Ativar ou desativar calculo do esgoto',
                  style: TextStyle(color: Colors.white70)),
              subtitle: const Text(
                  'Se em sua localidade é cobrado a taxa de esgoto, selecione para calcular o valor total de irrigação por mês.',
                  style: TextStyle(color: Colors.white70)),
              trailing: Switch(
                value: GlobalState.incluirEsgoto,
                onChanged: (bool? value) {
                  setState(() {
                    GlobalState.incluirEsgoto = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calcularAguaMaxima() {
    if (areaMetrosQuadrados != null) {
      String input = _controller.text.trim();
      if (input.isNotEmpty) {
        input = input.replaceAll(',', '.');
        if (input.endsWith('.')) {
          input = input.substring(0, input.length - 1);
        }
        areaMetrosQuadrados = double.tryParse(input);
        aguaMaxima = areaMetrosQuadrados! * 10;
        _databaseReference.child('comandos/aguamaxima').set(aguaMaxima);
        setState(() {
          _controller.text = areaMetrosQuadrados?.toString() ?? '';
          _isEditing = false;
        });
        FocusScope.of(context).unfocus();
      }
    }
  }
}
