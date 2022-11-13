import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info"),
      ),
      body: Container(
        color: Colors.blue[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Text(
              "Lego Builder info:",
              style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            Text(
              "Met deze app kan je verschillende stappen in een legoboekje inscannen om te kijken hoeveel sterren je dit figuurtje geeft, dit doe je via het tweede tab vanonder. Indien je nog geen review hebt gemaakt over het figuurtje kan je terecht in onze laatste tab. Hier staan de verschillende figuurtjes die je een review kan geven.",
              style: TextStyle(
                  fontSize: 20.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 200,),
            Text("Veel plezier met onze app!",
            style: TextStyle(
              fontSize: 40,
              color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
