import 'package:flutter/material.dart';
import 'logic.dart';

List<Meal> data = [];
int view = -1;

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State{
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
    for(int i = 0; i < 12; i++){
      _fetch();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Recipe App')
        ),
        backgroundColor: Colors.green,
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      data.clear();
                      _fetch(value: _search.text);
                    });
                  },
                  icon: const Icon(Icons.search)
                ),
                hintText: 'Search for a Recipe'
              ),
              onSubmitted: (value) => setState(() {
                data.clear();
                _fetch(value: _search.text);
              }),
            ),
      
            const SizedBox(
              height: 50,
            ),
      
            _loading ? const Center(
              child: CircularProgressIndicator()
            )
              : Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12
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
                        child: GridTile(
                          footer: GridTileBar(
                              backgroundColor: Colors.black45,
                              title: Text(data[index].name),
                              subtitle: Text(data[index].category),
                            ),
                          child: Image(
                            image: NetworkImage(data[index].image)
                          )
                        )
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

} 