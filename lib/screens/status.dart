import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_names_app/providers/socket.dart';

class StatusScreen extends StatelessWidget {
   
  const StatusScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final socketProvider = Provider.of<SocketProvider>(context);

    return Scaffold(
      body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ServerStatus: ${socketProvider.serverStatus}')
          ],
         ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.send, color: Colors.deepPurple,),
        onPressed: () {
          socketProvider.emit('emitir-mensaje', {
            'nombre': 'Flutter',
            'mensaje': 'Emitiendo...'
          });
        },
      ),
    );
  }
}