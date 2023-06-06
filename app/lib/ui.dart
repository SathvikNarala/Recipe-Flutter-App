import 'package:flutter/material.dart';
import 'logic.dart';

List<Meal> data = [];
int view = -1;

class AppState extends State{
  bool _loading = true;
  final TextEditingController _search = TextEditingController();

  void _fetch({String? value}) async{
    data.addAll(await Api.fetch(get: value)); 

    setState(() {  
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < 10; i++){
      _fetch();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe App'),
        backgroundColor: Colors.green,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for a Recipe'
              ),
              onChanged: (input) {
                setState(() {
                  data.clear();
                  _fetch(value: input);
                });
              },
            ),
      
            const SizedBox(
              height: 50,
            ),
      
            Expanded(
              child: _loading ? const Center(
                child: CircularProgressIndicator()
              )
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 50,
                            child: Image(
                              image: NetworkImage(data[index].image),
                              width: 500,
                              height: 500,
                            ),
                          ),
                          title: Text(data[index].name),
                          subtitle: Text(data[index].category),
                          focusColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.blueGrey,
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          onTap: (){
                            setState(() {
                              view = index;
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const Display()
                                )
                              );  
                            });
                            
                          },
                        ),
                      );
                    }
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class Display extends StatefulWidget{

  const Display({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return _DisplayState();
  }

}

class _DisplayState extends State<Display>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data[view].name),
      ),

      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            Image(
              image: NetworkImage(data[view].image),
              height: 300,
              width: 300,
            ),
            
            const SizedBox(
              height: 50,
            ),
            
            Expanded(
              child: SingleChildScrollView(
                child: Text(data[view].instructions,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

} 