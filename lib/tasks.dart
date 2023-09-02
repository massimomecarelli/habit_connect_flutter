import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/database.dart';
import '../util/new_task_dialog.dart';
import 'dart:developer';
import 'package:flutter_slidable/flutter_slidable.dart';



class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  // reference the hive box
  final _myBox = Hive.box('taskbox');
  AppDatabase db = AppDatabase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TASKSLIST") != null) {
      db.loadData();
    }
    super.initState();
  }

  // text controller
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  // è stato cliccato l'elemento, passa l'indice per prenderlo nella lista
  void goalChanged(int index) {
    log("dentro tap");
    setState(() { // se obiettivo non a zero, lo decrementa
      if (db.tasksList[index][1] > 0)
        db.tasksList[index][1] --;
      if (db.tasksList[index][1] == 0)
      // lo segna completo = true
        db.tasksList[index][2] = true;
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      if (_controller1.text == ""){
        _controller1.text = "Nuovo Task";
      }
      if (_controller2.text == ""){
        _controller2.text = "1";
      }
      db.tasksList.add([_controller1.text, int.parse(_controller2.text), false]);
      _controller1.clear();
      _controller2.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // crea nuovo task ritornando l'apposita dialog
  void createNewTask() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return NewTaskDialog(
          controller1: _controller1,
          controller2: _controller2,
          onSave: saveNewTask,
        );
      },
    );
  }

  // elimina il task che corrisponde all'indice nella box che viene passato
  void deleteTask(int index) {
    setState(() {
      db.tasksList.removeAt(index);
    });
    db.updateDataBase();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Task deleted')));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Tasks'),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text(
            "ADD TASK",
            style: TextStyle(color: Colors.white)
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100)
        ),
        backgroundColor: Colors.blue[400],
        icon: const Icon(Icons.bookmark_add, color: Colors.white),
        onPressed: createNewTask,
      ),
      body: ListView.builder(
        itemCount: db.tasksList.length,
        itemBuilder: (context, index) {
          return
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
              child: Slidable(
                startActionPane: ActionPane(
                  motion: StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => deleteTask(index),
                    icon: Icons.delete,
                    backgroundColor: const Color.fromARGB(200, 250, 5, 5),
                    borderRadius: BorderRadius.circular(12),
          )
          ],
          ),
                endActionPane: ActionPane(
                  motion: StretchMotion(),
                  dragDismissible: true,
                  children: [
                    SlidableAction(
                      onPressed: (context) => deleteTask(index),
                      icon: Icons.delete,
                      backgroundColor: const Color.fromARGB(200, 250, 5, 5),
                      borderRadius: BorderRadius.circular(12),
          )
          ],
          ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: db.tasksList[index][2] ?
                  BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(12),
                  )
                  :  BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.blueGrey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12),
                    ),
                  child: ListTile(
                    // icona, proprietà del testo e background, cambiano a seconda
                    // se il task è completato o meno
                    leading: Icon(db.tasksList[index][2]
                      ? Icons.check
                      : Icons.bookmark,
                    color: Colors.blue[400]),
                    title: Text(
                      db.tasksList[index][0],
                      style: TextStyle(
                      color: db.tasksList[index][2]
                        ? Colors.white
                        : Colors.black,
                      decoration: db.tasksList[index][2]
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                      ),
                    ),
                    // in fondo metto il counter dell'obiettivo
                    trailing: Text(
                      db.tasksList[index][1].toString(),
                      style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[400],
                      ),
                    ),
                    onTap: () => goalChanged(index),
          ),
          ),

          ),

            );
        },
      ),
    );
  }
}