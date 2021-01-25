import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_demo_flutter/Models/MoviesByYearResponse.dart';
import 'package:movies_demo_flutter/api.dart';
import 'loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: BuildListView());
  }
}

class BuildListView extends StatefulWidget {
  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  final myController = TextEditingController();
  List<MoviesByYear> moviesByYear = List<MoviesByYear>();
  int total = 0;
  bool isloading = false;

  _getMovies({String title = ''}) {
    setState(() {
      isloading = true;
    });
    Api.getMoviesByTitle(title: title).then(
      (response) {
        setState(() {
          var data = json.decode(response.body);
          var listString = data["moviesByYear"];
          moviesByYear = List<MoviesByYear>.from(
              listString.map((model) => MoviesByYear.fromJson(model)).toList());
          total = data["total"];
          MoviesByYearResponse moviesByYearResponse =
              MoviesByYearResponse(moviesByYear: moviesByYear, total: total);
          isloading = false;
          return moviesByYearResponse;
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        elevation: 1,
        title: TextFormField(
          controller: myController,
          decoration: const InputDecoration(
            hintText: "search",
            hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
        centerTitle: true,
        leading: FlatButton(
          onPressed: () {
            _getMovies(title: myController.text);
          },
          child: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: listMovies(),
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 20,
            ),
            Visibility(
              child: Loader(),
              visible: isloading,
            ),
            Container(
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  'Total: ' + total.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  listMovies() {
    return ListView.builder(
      itemCount: moviesByYear.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Column(
            children: [
              Text("Year: " + moviesByYear[index].year.toString()),
              Text(" Movies: " + moviesByYear[index].movies.toString())
            ],
          ),
        );
      },
    );
  }
}
