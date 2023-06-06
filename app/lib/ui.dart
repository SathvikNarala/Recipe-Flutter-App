import 'package:flutter/material.dart';
import 'logic.dart';

List<Meal> data = [];
int view = -1;

class AppState extends State{
  bool _loading = true;

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
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index){
                      return InkWell(
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
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                image: NetworkImage(data[index].image),
                                width: 150,
                                height: 150,
                              ),
                      
                              Text(data[index].name, 
                                style: const TextStyle(
                                  fontSize: 15
                                ),
                              ),
                      
                              Text(data[index].category)
                            ],
                          ),
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