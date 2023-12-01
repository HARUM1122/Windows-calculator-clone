import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_tile.dart';
import '../../../providers/memory/scientific_calc.dart';
class MemoryList extends StatelessWidget {
  const MemoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ScientificMemoryProvider>(
      builder: (context,memoryProv,_)=>memoryProv.memory.isNotEmpty?Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              physics:const BouncingScrollPhysics(),
              itemCount:memoryProv.memory.length,
              itemBuilder: (context,index)=>
                Dismissible(
                  key:UniqueKey(),
                  onDismissed: (direction)=>memoryProv.removeMemory(index),
                  child: MemoryTile(value:memoryProv.memory[index],
                  index:index
                )
              )
            ),
          ),
          TextButton(
            onPressed:memoryProv.clearMemory,
            style:const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
              overlayColor: MaterialStatePropertyAll<Color>(Colors.transparent),
            ),
            child:const Icon(
              Icons.delete_outlined,
              color:Colors.white,
              size:35 
            )
          )
        ],
      ):const Center(
        child:Text(
          "There's nothing saved in memory",
          style:TextStyle(
            color: Colors.white,
            fontSize:20
          )
        )
      )
    );
  }
}