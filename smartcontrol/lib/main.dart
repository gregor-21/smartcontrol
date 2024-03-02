import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:logger/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

class IrrigationApp extends StatefulWidget {
  const IrrigationApp({super.key});

  @override
  _IrrigationAppState createState() => _IrrigationAppState();
}

class _IrrigationAppState extends State<IrrigationApp> {
  late IO.Socket socket;
  bool modoAutomatico = false;
  bool motorLigado = false;
  final Logger logger = Logger();

  late FirebaseMessaging _firebaseMessaging;

  @override
  void initState() {
    initializeFirebase();
    super.initState();
    // initializeSocket(); // Comentado para não conectar ao Arduino
  }

  void initializeFirebase() async {
    _firebaseMessaging = FirebaseMessaging.instance;

    // Restante do seu código de inicialização Firebase

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Mensagem em primeiro plano: $message");
      // Adicione aqui o código para lidar com a notificação em primeiro plano
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("Aplicativo aberto a partir de uma notificação: $message");
      // Adicione aqui o código para lidar com a notificação quando o aplicativo é aberto a partir dela
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("Mensagem recebida em segundo plano: $message");
      // Adicione aqui o código para lidar com a notificação em segundo plano
    });
  }

  void initializeSocket() {
    // Conectar ao servidor do Arduino mudar apos com a porta do arduino
    socket = IO.io('http://dummy_socket_server:3000');
    socket.connect();

    // Ouvir mensagens do servidor
    socket.on('umidade_solo', (data) {
      logger.d('Umidade do solo: $data');
      // Atualiza a interface do usuário com os dados de umidade recebidos
    });

    socket.on('temperatura_ambiente', (data) {
      logger.i('Temperatura ambiente: $data');
      // Atualiza a interface do usuário com os dados de temperatura recebidos
    });

    socket.on('motor_ligado', (data) {
      logger.i('Motor ligado');
      setState(() {
        motorLigado = true; // Atualiza o estado do motor na tela
      });
    });

    socket.on('motor_desligado', (data) {
      logger.i('Motor desligado');
      setState(() {
        motorLigado = false; // Atualiza o estado do motor na tela
      });
    });
  }

  @override
  void dispose() {
    // socket.disconnect(); // Comentado para não desconectar do servidor do Arduino
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irrigação Automática'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Estado do Motor: ${motorLigado ? 'Ligado' : 'Desligado'}',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Umidade do Solo:',
                  style: TextStyle(fontSize: 18),
                ),
                const Text(
                  'Temperatura Ambiente:',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text('Operação Manual'),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      // socket.emit('ligar_motor', 'ligar'); // Comentado para não enviar comando ao Arduino
                      setState(() {
                        motorLigado = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: const Text('Ligar Motor'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // socket.emit('desligar_motor', 'desligar'); // Comentado para não enviar comando ao Arduino
                      setState(() {
                        motorLigado = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Desligar Motor'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                modoAutomatico = !modoAutomatico;
                if (modoAutomatico) {
                  // socket.emit('modo_automatico', 'ativar'); // Comentado para não enviar comando ao Arduino
                } else {
                  // socket.emit('modo_automatico', 'desativar'); // Comentado para não enviar comando ao Arduino
                }
              });
            },
            child: Text(
              modoAutomatico
                  ? 'Modo Automático: Ligado'
                  : 'Modo Automático: Desligado',
            ),
          ),
        ],
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }

  runApp(MaterialApp(
    title: 'Irrigação Automática',
    theme: ThemeData(
      primaryColor: Colors.green,
    ),
    home: const IrrigationApp(),
  ));
}
