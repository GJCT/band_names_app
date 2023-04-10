import 'package:band_names_app/models/band.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Héroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandsName', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) {
          return _bandTitle(bands[index]);
        } 
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_box),
        onPressed: addBand,
      ),
    );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        
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
    
            },
          ),
    );
  }

  addBand(){

    final textController = TextEditingController();
    
    showDialog(
      context: context, 
      builder: (contexr) {
        return AlertDialog(
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
        );
      }
    );
  }

  void addBandList(String name){
    if(name.length >1 ){
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 0
      ));
      setState(() {});
    }


    Navigator.pop(context);
  }

}