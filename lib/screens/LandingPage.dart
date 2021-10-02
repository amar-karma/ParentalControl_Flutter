import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pca/models/api_response_model.dart';
import 'package:pca/utils/constants.dart';
import 'package:pca/utils/loadingAndErrorHandlerWidget.dart';
import 'package:pca/utils/pie_chart.dart';
import 'package:pca/utils/widget_functions.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool _isDataLoaded = false, _isError = false;
  APIResponseModel _apiData;
  List<int> _timeData = [];
  int _totalTime = 0;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() async {
    setState(() {
      _isDataLoaded = false;
      _isError = false;
    });
    _apiData = await _fecthData();
    print("API Data - $_apiData");
    if (_apiData == null) {
      // error
      _isError = false;
      _isDataLoaded = false;
      //
    } else {
      _isDataLoaded = true;
      _initTimeData(chartData: _apiData.chartData);
    }

    setState(() {});
  }

  _initTimeData({ChartData chartData}) {
    _timeData.add(int.parse(chartData.classTime.total));
    _timeData.add(int.parse(chartData.freeTime.total));
    _timeData.add(int.parse(chartData.studyTime.total));

    _totalTime = int.parse(_apiData.chartData.totalTime.total);
  }

  Future<APIResponseModel> _fecthData() async {
    // api call,
    try {
      var response =
          await Dio().get('https://api.mocklets.com/mock68182/screentime');
      print("Dio Error - $response");
      return APIResponseModel.fromJson(response.data[0]);
    } catch (e) {
      print("Dio Error - $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return SafeArea(
      child: !_isDataLoaded
          ? LoadingAndErrorHandlerWidget(
              boolCondition: _isError,
              onPressedCallBack: _loadData,
              message: "Error Occured, Please Try Again!!",
            )
          : Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: sidePadding,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(padding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 45,
                                color: COLOR_PINK,
                              ),
                              addHorizontalSpace(10),
                              Text(
                                "Michael",
                                style: themeData.textTheme.bodyText2,
                              ),
                            ],
                          ),
                          Icon(
                            Icons.settings,
                            color: COLOR_BLACK,
                          ),
                        ],
                      ),
                      addVerticalSpace(30),
                      Center(
                        child: Text(
                          "Dashboard",
                          style: themeData.textTheme.headline1,
                        ),
                      ),
                      // addVerticalSpace(10),
                      Center(
                        child: Container(
                          width: 250,
                          height: 280,
                          child: Stack(
                            children: [
                              PieChartMaker(
                                timeData: _timeData,
                                totalTime: _totalTime,
                              ),
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: COLOR_WHITE,
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 200,
                                  height: 220,
                                  padding: EdgeInsets.only(top: 80),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total",
                                        style: themeData.textTheme.headline2,
                                      ),
                                      Text(
                                        converter(
                                            "${_apiData.chartData.totalTime.total}"),
                                        style: themeData.textTheme.headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: sidePadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: COLOR_BLUE,
                                    ),
                                    addHorizontalSpace(5),
                                    Text(
                                      "Class",
                                      style: themeData.textTheme.bodyText2,
                                    )
                                  ],
                                ),
                                addVerticalSpace(5),
                                Text(
                                  converter(
                                      "${_apiData.chartData.classTime.total}"),
                                  style: themeData.textTheme.headline5,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: COLOR_ORANGE,
                                    ),
                                    addHorizontalSpace(5),
                                    Text(
                                      "Study",
                                      style: themeData.textTheme.bodyText2,
                                    )
                                  ],
                                ),
                                addVerticalSpace(5),
                                Text(
                                  converter(
                                      "${_apiData.chartData.studyTime.total}"),
                                  style: themeData.textTheme.headline5,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 15,
                                      color: COLOR_GREEN,
                                    ),
                                    addHorizontalSpace(5),
                                    Text(
                                      "Free-time",
                                      style: themeData.textTheme.bodyText2,
                                    )
                                  ],
                                ),
                                addVerticalSpace(5),
                                Text(
                                  converter(
                                      "${_apiData.chartData.freeTime.total}"),
                                  style: themeData.textTheme.headline5,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      addVerticalSpace(50),
                      Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      addVerticalSpace(30),
                      Center(
                        child: Text(
                          "Free-time Usage",
                          style: themeData.textTheme.headline2,
                        ),
                      ),
                      addVerticalSpace(30),
                      Padding(
                        padding: sidePadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Used",
                                  style: themeData.textTheme.headline4,
                                ),
                                addVerticalSpace(5),
                                Text(
                                  converter(
                                      "${int.parse(_apiData.deviceUsage.freeTime.mobile) + int.parse(_apiData.deviceUsage.freeTime.laptop)}"),
                                  style: TextStyle(
                                      color: COLOR_DARK_GREEN,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Max",
                                  style: themeData.textTheme.headline4,
                                ),
                                addVerticalSpace(5),
                                Text(
                                  converter("${_apiData.freeTimeMaxUsage}"),
                                  style: TextStyle(
                                      color: COLOR_BLACK,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(20),
                      Padding(
                        padding: sidePadding,
                        child: LayoutBuilder(builder: (context, constraints) {
                          return Stack(
                            children: [
                              Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: COLOR_LIGHT,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 300 *
                                    percentUsedBar(
                                        "${_apiData.freeTimeMaxUsage}",
                                        "${_apiData.deviceUsage.freeTime.mobile}",
                                        "${_apiData.deviceUsage.freeTime.laptop}"),
                                decoration: BoxDecoration(
                                  color: COLOR_GREEN,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomLeft: Radius.circular(20.0)),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                      addVerticalSpace(20),
                      Container(
                        margin: sidePadding,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: COLOR_BLUE, width: 2),
                        ),
                        child: Center(
                            child: Text(
                          "Extended Free-Time",
                          style: TextStyle(
                            color: COLOR_BLUE,
                            fontSize: 12,
                          ),
                        )),
                      ),
                      addVerticalSpace(30),
                      Container(
                        child: Center(
                          child: Text(
                            "Change Time Restrictions",
                            style: TextStyle(
                              color: COLOR_BLUE,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(30),
                      Divider(
                        height: 5,
                        thickness: 2,
                      ),
                      addVerticalSpace(30),
                      Container(
                        child: Center(
                          child: Text(
                            "By Devices",
                            style: themeData.textTheme.headline3,
                          ),
                        ),
                      ),
                      addVerticalSpace(30),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.smartphone,
                                size: 60,
                                color: COLOR_GREY,
                              ),
                              addHorizontalSpace(20),
                              Column(
                                children: [
                                  Text("Adi's Phone"),
                                  Text(
                                    converter(
                                        "${_apiData.deviceUsage.totalTime.mobile}"),
                                    style: TextStyle(color: COLOR_BLUE),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          addVerticalSpace(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.laptop,
                                size: 60,
                                color: COLOR_GREY,
                              ),
                              addHorizontalSpace(20),
                              Column(
                                children: [
                                  Text("Adi's Laptop"),
                                  Text(
                                    converter(
                                        "${_apiData.deviceUsage.totalTime.laptop}"),
                                    style: TextStyle(color: COLOR_BLUE),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          addVerticalSpace(30),
                          Text(
                            "See All Devices",
                            style: TextStyle(color: COLOR_BLUE),
                          ),
                          addVerticalSpace(20),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}

String result;
int timeInSeconds;
double percentUsed;

String converter(String time) {
  timeInSeconds = int.parse(time);
  if (timeInSeconds > 60) {
    result = "${(timeInSeconds / 60).floor()}h ${timeInSeconds % 60}m";
  } else {
    result = "$timeInSeconds" + "m";
  }
  return result;
}

double percentUsedBar(
    String freeTimeMax, String freeTimeMobile, String freeTimeLaptop) {
  percentUsed = (double.parse(freeTimeLaptop) + double.parse(freeTimeMobile)) /
      double.parse(freeTimeMax);
  return percentUsed;
}
