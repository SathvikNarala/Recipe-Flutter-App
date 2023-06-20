import 'package:flutter/material.dart';
import 'logic.dart';

List<Meal> data = [];
int view = -1;
bool isHome = true;

class App extends StatefulWidget{
  const App({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State{

  void _fetch({String? value}) async{
    List<Meal> temp = await Logic.fetch(value);
    
    setState(() {
      data.addAll(temp);
    });
  }

  @override
  void initState() {
    super.initState();
    if(isHome){
      for(int i = 0; i < 12; i++){
        _fetch();
      }
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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
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
          ]
        ),
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(isHome){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchBar()
                )
              );
            }
            else if(Navigator.canPop(context)){
                Navigator.of(context).pop();
            }
            else{
              isHome = true;
            }
          });
        },
        child: const Icon(
          Icons.search_sharp
        )
      ),
    );
  }
}

//Handling Search bar and suggestions
class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _search = TextEditingController();
  List<Search> _list = [];

  void _get(String query) async{
    List<Search> search = await Logic.suggest(query);

    setState(() {
      _list = search;
    });
  }

  @override
  void initState(){
    super.initState();
    _get('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Search')
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextField(
              controller: _search,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async{
                    List<Meal> fetched = await Logic.fetch(_search.text);
                    _list = await Logic.suggest(_search.text, true);
      
                    setState(() {
                      isHome = false;
                      data.clear();
                      data.addAll(fetched);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const App()
                        )
                      );
                    });
                  },
                  icon: const Icon(Icons.search)
                ),
                hintText: 'Search for a Recipe'
              ),
              onChanged: (value) async{
                _get(value);
              },
            ),
      
            const SizedBox(
              height: 50,
            ),
      
            Expanded(
              child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        _search.text = _list[index].query;
                      });
                    },
                    child: ListTile(
                      leading: const Icon(
                        Icons.history
                      ),
                      title: Text(_list[index].query),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

//For Displaying the Recipe instructions
class Display extends StatelessWidget{
  const Display({super.key});

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