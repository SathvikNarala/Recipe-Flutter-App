import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider.dart';
import 'home.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState(){
    super.initState();
    context.read<Searchflow>().get('');
  }

  @override
  void dispose(){
    super.dispose();
    _search.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Searchflow flow = context.watch<Searchflow>();

    return SafeArea(
      child: Scaffold(
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
                    onPressed: (){
                      Dataflow dflow = context.read<Dataflow>();
                      context.read<Searchflow>().onSearch(_search.text, dflow);
    
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const App()
                        )
                      );
    
                      // List<Meal> fetched = await Logic.fetch(_search.text);
        
                      // setState(() {
                      //   isHome = false;
                      //   data.clear();
                      //   data.addAll(fetched);
                        
                      // });
                    },
                    icon: const Icon(Icons.search)
                  ),
                  hintText: 'Search for a Recipe'
                ),
                onChanged: (value){
                  context.read<Searchflow>().get(value);
                },
              ),
        
              const SizedBox(
                height: 50,
              ),
        
              Expanded(
                child: ListView.builder(
                  itemCount: flow.list.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: (){
                        _search.text = flow.list[index].query;
                      },
                      child: ListTile(
                        leading: const Icon(
                          Icons.history
                        ),
                        title: Text(flow.list[index].query),
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
