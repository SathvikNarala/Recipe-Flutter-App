import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import 'display.dart';
import 'search.dart' as use;

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State{

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(context.read<Dataflow>().isHome){//Used read only as the widget building is not started to listen to
        context.read<Dataflow>().fetch('');
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Dataflow flow = context.watch<Dataflow>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Recipe App')
        ),
        backgroundColor: Colors.green,
      ),
      
      body: flow.loading ?
      const Center(
        child: CircularProgressIndicator()
      ):
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12
          ),
          itemCount: flow.data.length,
          itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                context.read<Dataflow>().gridtap(index);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Display()
                  )
                );
              },
              child: GridTile(
                footer: GridTileBar(
                    backgroundColor: Colors.black45,
                    title: Text(flow.data[index].name),
                    subtitle: Text(flow.data[index].category),
                  ),
                child: Image(
                  image: NetworkImage(flow.data[index].image),
                )
              )
            );
          }
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(flow.isHome){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const use.SearchBar()
              )
            );
          }
          else if(Navigator.canPop(context)){
            Navigator.of(context).pop();
          }
          else{
            context.read<Dataflow>().setHome(true);
          }
        },
        child: const Icon(
          Icons.search_sharp
        )
      ),
    );
  }
}
