import 'package:flutter/material.dart';

import '../apis/figure_detail_api.dart';
import '../models/figure.dart';
import '../models/figure_detail.dart';


class FigureDetailPage extends StatefulWidget {
  final String figureName;
  const FigureDetailPage({Key? key, required this.figureName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FigureDetailPageState();
}


class _FigureDetailPageState extends State<FigureDetailPage> {
  FigureDetail? figureDetail;
  //dit is mogelijks de figure ipv de figure_detail ???
  List<FigureDetail> figureDetailList = [];

  TextEditingController figureNameController = TextEditingController();
  TextEditingController textReviewController = TextEditingController();
  TextEditingController starsController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _getFigureDetail(widget.figureName); 
  }

  void _getFigureDetail(String figureName) {
    FigureDetailApi.fetchFigureDetails(figureName).then((result) {
      setState(() {
        figureDetailList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Figure details"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: _figureDetails(),
      ),
    );
  }

  _figureDetails() {
    if (figureDetail == null) {
      // show a ProgressIndicator as long as there's no user info
      return const Center(child: CircularProgressIndicator());
    } else {
      TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

      figureNameController.text = figureDetail!.figureName; // show the user info using the TextEditingController's
      textReviewController.text = figureDetail!.textReview;
      starsController.text = figureDetail!.stars as String;

      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: figureNameController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Name of the figure",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            TextField(
              controller: textReviewController,
              style: textStyle,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Last Name",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Container(
              height: 15,
            ),
            TextField(
              controller: starsController,
              style: textStyle,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}