import 'package:flutter/material.dart';

import 'house.dart';

class EpisodesPage extends StatefulWidget {
  final List<Episodes> episodes;
  final MyImage myImage;

  EpisodesPage({this.episodes, this.myImage});

  @override
  _EpisodesPageState createState() => _EpisodesPageState();
}

class _EpisodesPageState extends State<EpisodesPage> {
  BuildContext _context;

  showSummary(String summary) {
    showDialog(
        context: _context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                child: Card(
                  child: Text(summary),
                ),
              ),
            ));
  }

  Widget myBody() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.0),
      itemCount: widget.episodes.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          showSummary(widget.episodes[index].summary);
        },
        child: Card(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                widget.episodes[index].image.original,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      widget.episodes[index].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.episodes[index].season}-${widget.episodes[index].number}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Hero(
              tag: "g1",
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.myImage.original),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text("All Episodes")
          ],
        ),
      ),
      body: myBody(),
    );
  }
}
