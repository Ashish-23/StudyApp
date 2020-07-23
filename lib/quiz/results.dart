import 'package:flutter/material.dart';
import 'package:flutterapp3/widget/widget.dart';
import 'package:pie_chart/pie_chart.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  Results({this.incorrect, this.total, this.correct, this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  Map<String, double> data = new Map();
  bool _loadChart = false;

  @override
  void initState() {
    data.addAll({
      'Correct': widget.correct.toDouble(),
      'Incorrect': widget.incorrect.toDouble(),
      'Not Attempt': widget.notattempted.toDouble(),
    });
    super.initState();
  }

  List<Color> _colors = [
    Colors.green,
    Colors.red,
    Colors.amber
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:AppLogo(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Center(
          child: ListView(
           // mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Your result',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold,color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              PieChart(
                dataMap: data,
                colorList:
                _colors,
                // if not declared, random colors will be chosen
                animationDuration: Duration(milliseconds: 1500),
                chartLegendSpacing: 32.0,
                chartRadius: MediaQuery
                    .of(context)
                    .size
                    .width /
                    2.7,
                //determines the size of the chart
                showChartValuesInPercentage: true,
                showChartValues: true,
                showChartValuesOutside: true,
                chartValueBackgroundColor: Colors.grey[200],
                showLegends: true,
                legendPosition:
                LegendPosition.right,
                //can be changed to top, left, bottom
                decimalPlaces: 1,
                showChartValueLabel: true,
                initialAngle: 0,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.blueGrey[900].withOpacity(0.9),
                ),
                chartType: ChartType.ring, //can be changed to ChartType.ring
              ) ,

              SizedBox(
                height: 50,
              ),
              /*RaisedButton(
                color: Colors.blue,
                child: Text('Click to Show Chart', style: TextStyle(
                    color: Colors.white
                ),),
                onPressed: () {
                  setState(() {
                    _loadChart = true;
                  });
                },

              ),*/

              Center(child: Text("${widget.correct}/ ${widget.total}", style: TextStyle(fontSize: 45,fontWeight:FontWeight.bold,color: Colors.blue),)),
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "You answered ${widget.correct} answers correctly and ${widget.incorrect} answeres incorrectly", style:
                TextStyle(fontSize: 30,fontWeight:FontWeight.w600,color: Colors.green),
                  textAlign: TextAlign.center,),

              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Center(child: Text("Go to home", style: TextStyle(color: Colors.white, fontSize: 19),)),
                ),
              )
            ],),
        ),
      ),
    );
  }
}


