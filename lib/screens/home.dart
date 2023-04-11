import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:band_names_app/models/band.dart';
import 'package:band_names_app/providers/socket.dart';

class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [];

  @override
  void initState() {

    final socketProvider = Provider.of<SocketProvider>(context, listen: false);

    socketProvider.socket.on('active-bands', (payload) {
      bands = (payload as List)
        .map((band) => Band.fromMap(band)).toList();
    });

    setState(() {});

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    final socketProvider = Provider.of<SocketProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('BandsName', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketProvider.serverStatus == ServerStatus.online) 
            ? const Icon(Icons.check_circle_rounded, color: Colors.blueAccent,)
            : const Icon(Icons.cancel, color: Colors.red,),
          )
        ],
      ),
      body: Column(
        children: [
          _showGrap(),
          Expanded(
            child:ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, index) {
                return _bandTitle(bands[index]);
              } 
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add_box,),
        onPressed: addBand,
      ),
    );
  }

  Widget _bandTitle(Band band) {

    final socketProvider = Provider.of<SocketProvider>(context, listen: false);

    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: ( _) {
        socketProvider.emit('delete-band', {
          'id': band.id
        });
        setState(() {});
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete', style: TextStyle(color: Colors.white),),
        ),
        color: Colors.red,
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text(band.name!.substring(0,2)),
              backgroundColor: Colors.deepPurple[200],
            ),
            title: Text(band.name!),
            trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20),),
            onTap: () {
              socketProvider.socket.emit('vote-bands',{
                'id': band.id
              });
              setState(() {});
            },
          ),
    );
  }

  addBand(){

    final textController = TextEditingController();
    
    showDialog(
      context: context, 
      builder: ( _) => AlertDialog(
          title: const Text('New band name:'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: const Text('Add'),
              textColor: Colors.deepPurple,
              onPressed: () => addBandList(textController.text)
          )
        ],
      )
    );
  }

  void addBandList(String name){

    final socketProvider = Provider.of<SocketProvider>(context, listen: false);

    if(name.length >1 ){
      //Agregar una nueva banda
      socketProvider.emit('add-bands',{
        'name': name
      });
      setState(() {});
    }
    Navigator.pop(context);
  }

  Widget _showGrap() {
    Map<String, double> dataMap = {};
    bands.forEach((band) {
      dataMap.putIfAbsent( band.name!, () => band.votes!.toDouble());
    });

    return Container(
      child: PieChart(
        dataMap: dataMap,
      ),
    );
  }

}