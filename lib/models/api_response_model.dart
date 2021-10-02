class APIResponseModel {
  ChartData chartData;
  String freeTimeMaxUsage;
  ChartData deviceUsage;

  APIResponseModel({this.chartData, this.freeTimeMaxUsage, this.deviceUsage});

  APIResponseModel.fromJson(Map<String, dynamic> json) {
    chartData = json['chartData'] != null
        ? ChartData.fromJson(json['chartData'])
        : null;
    freeTimeMaxUsage =
        json['freeTimeMaxUsage'] != null ? json['freeTimeMaxUsage'] : null;
    deviceUsage = json['deviceUsage'] != null
        ? ChartData.fromJson(json['deviceUsage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.chartData != null) {
      data['chartData'] = this.chartData.toJson();
    }
    data['freeTimeMaxUsage'] = this.freeTimeMaxUsage;
    if (this.deviceUsage != null) {
      data['deviceUsage'] = this.deviceUsage.toJson();
    }
    return data;
  }
}

class ChartData {
  TotalTime totalTime;
  TotalTime studyTime;
  TotalTime classTime;
  TotalTime freeTime;

  ChartData({this.totalTime, this.studyTime, this.classTime, this.freeTime});

  ChartData.fromJson(Map<String, dynamic> json) {
    totalTime = json['totalTime'] != null
        ? TotalTime.fromJson(json['totalTime'])
        : null;
    studyTime = json['studyTime'] != null
        ? TotalTime.fromJson(json['studyTime'])
        : null;
    classTime = json['classTime'] != null
        ? TotalTime.fromJson(json['classTime'])
        : null;
    freeTime =
        json['freeTime'] != null ? TotalTime.fromJson(json['freeTime']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.totalTime != null) {
      data['totalTime'] = this.totalTime.toJson();
    }
    if (this.studyTime != null) {
      data['studyTime'] = this.studyTime.toJson();
    }
    if (this.classTime != null) {
      data['classTime'] = this.classTime.toJson();
    }
    if (this.freeTime != null) {
      data['freeTime'] = this.freeTime.toJson();
    }
    return data;
  }
}

class TotalTime {
  String mobile;
  String laptop;
  String total;

  TotalTime({this.mobile, this.laptop, this.total});

  TotalTime.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'] != null ? json['mobile'] : null;
    laptop = json['laptop'] != null ? json['laptop'] : null;
    total = json['total'] != null ? json['total'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['laptop'] = this.laptop;
    data['total'] = this.total;
    return data;
  }
}
