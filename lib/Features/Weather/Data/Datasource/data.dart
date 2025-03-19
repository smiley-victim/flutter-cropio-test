

class OpenWeatherAPI {

  String apiKey = 'a9d52bc87eaf4bfba06194610240910&';

  String apiUrl(lat, lon) {
    return 'https://api.weatherapi.com/v1/forecast.json?key=${apiKey}q=$lat,$lon&days=1&aqi=no&alerts=no';
  
  }
}

// class WeatherData {
//   Location location;
//   Current current;
//   Forecast forecast;
//   Alerts alerts;

//   WeatherData({
//     required this.location,
//     required this.current,
//     required this.forecast,
//     required this.alerts,
//   });
//   /// Factory constructor to create a [WeatherData] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns a [WeatherData] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns a [WeatherData] object.
//   factory WeatherData.fromJson(Map<String, dynamic> json) {
//     return WeatherData(
//       location: Location.fromJson(json['location'] as Map<String, dynamic>),
//       current: Current.fromJson(json['current'] as Map<String, dynamic>),
//       forecast: Forecast.fromJson(json['forecast'] as Map<String, dynamic>),
//       alerts: Alerts.fromJson(json['alerts'] as Map<String, dynamic>),
//     );
//   }

//   /// Converts the [WeatherData] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [WeatherData] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'location': location.toJson(),
//       'current': current.toJson(),
//       'forecast': forecast.toJson(),
//       'alerts': alerts.toJson(),
//     };
//   }
// }


// class Alerts {
//   List<Alert> alert;

//   Alerts({
//     required this.alert,
//   });

//   /// Factory constructor to create an [Alerts] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns an [Alerts] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns an [Alerts] object.
//   factory Alerts.fromJson(Map<String, dynamic> json) {
//     return Alerts(
//       alert: (json['alert'] as List<dynamic>)
//           .map((item) => Alert.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   /// Converts the [Alerts] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Alerts] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'alert': alert.map((item) => item.toJson()).toList(),
//     };
//   }
// }


// class Alert {
//   String headline;
//   String msgtype;
//   String severity;
//   String urgency;
//   String areas;
//   String category;
//   String certainty;
//   String event;
//   String note;
//   DateTime effective;
//   DateTime expires;
//   String desc;
//   String instruction;

//   Alert({
//     required this.headline,
//     required this.msgtype,
//     required this.severity,
//     required this.urgency,
//     required this.areas,
//     required this.category,
//     required this.certainty,
//     required this.event,
//     required this.note,
//     required this.effective,
//     required this.expires,
//     required this.desc,
//     required this.instruction,
//   });

//   /// Factory constructor to create an [Alert] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns an [Alert] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns an [Alert] object.
//   factory Alert.fromJson(Map<String, dynamic> json) {
//     return Alert(
//       headline: json['headline'] as String,
//       msgtype: json['msgtype'] as String,
//       severity: json['severity'] as String,
//       urgency: json['urgency'] as String,
//       areas: json['areas'] as String,
//       category: json['category'] as String,
//       certainty: json['certainty'] as String,
//       event: json['event'] as String,
//       note: json['note'] as String,
//       effective: DateTime.parse(json['effective'] as String),
//       expires: DateTime.parse(json['expires'] as String),
//       desc: json['desc'] as String,
//       instruction: json['instruction'] as String,
//     );
//   }

//   /// Converts the [Alert] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Alert] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'headline': headline,
//       'msgtype': msgtype,
//       'severity': severity,
//       'urgency': urgency,
//       'areas': areas,
//       'category': category,
//       'certainty': certainty,
//       'event': event,
//       'note': note,
//       'effective': effective.toIso8601String(),
//       'expires': expires.toIso8601String(),
//       'desc': desc,
//       'instruction': instruction,
//     };
//   }
// }


// class Current {
//   int? lastUpdatedEpoch;
//   String? lastUpdated;
//   double tempC;
//   double tempF;
//   int isDay;
//   Condition condition;
//   double windMph;
//   double windKph;
//   int windDegree;
//   WindDir windDir;
//   int pressureMb;
//   double pressureIn;
//   int precipMm;
//   int precipIn;
//   int humidity;
//   int cloud;
//   double feelslikeC;
//   double feelslikeF;
//   double windchillC;
//   double windchillF;
//   double heatindexC;
//   double heatindexF;
//   double dewpointC;
//   double dewpointF;
//   int visKm;
//   int visMiles;
//   double uv;
//   double gustMph;
//   double gustKph;
//   int? timeEpoch;
//   String? time;
//   int? snowCm;
//   int? willItRain;
//   int? chanceOfRain;
//   int? willItSnow;
//   int? chanceOfSnow;

//   Current({
//     this.lastUpdatedEpoch,
//     this.lastUpdated,
//     required this.tempC,
//     required this.tempF,
//     required this.isDay,
//     required this.condition,
//     required this.windMph,
//     required this.windKph,
//     required this.windDegree,
//     required this.windDir,
//     required this.pressureMb,
//     required this.pressureIn,
//     required this.precipMm,
//     required this.precipIn,
//     required this.humidity,
//     required this.cloud,
//     required this.feelslikeC,
//     required this.feelslikeF,
//     required this.windchillC,
//     required this.windchillF,
//     required this.heatindexC,
//     required this.heatindexF,
//     required this.dewpointC,
//     required this.dewpointF,
//     required this.visKm,
//     required this.visMiles,
//     required this.uv,
//     required this.gustMph,
//     required this.gustKph,
//     this.timeEpoch,
//     this.time,
//     this.snowCm,
//     this.willItRain,
//     this.chanceOfRain,
//     this.willItSnow,
//     this.chanceOfSnow,
//   });

//   /// Factory constructor to create a [Current] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns a [Current] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns a [Current] object.
//   factory Current.fromJson(Map<String, dynamic> json) {
//     return Current(
//       lastUpdatedEpoch: json['lastUpdatedEpoch'] as int?,
//       lastUpdated: json['lastUpdated'] as String?,
//       tempC: (json['tempC'] as num).toDouble(),
//       tempF: (json['tempF'] as num).toDouble(),
//       isDay: json['isDay'] as int,
//       condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
//       windMph: (json['windMph'] as num).toDouble(),
//       windKph: (json['windKph'] as num).toDouble(),
//       windDegree: json['windDegree'] as int,
//       windDir: WindDir.fromJson(json['windDir'] as String),
//       pressureMb: json['pressureMb'] as int,
//       pressureIn: (json['pressureIn'] as num).toDouble(),
//       precipMm: json['precipMm'] as int,
//       precipIn: json['precipIn'] as int,
//       humidity: json['humidity'] as int,
//       cloud: json['cloud'] as int,
//       feelslikeC: (json['feelslikeC'] as num).toDouble(),
//       feelslikeF: (json['feelslikeF'] as num).toDouble(),
//       windchillC: (json['windchillC'] as num).toDouble(),
//       windchillF: (json['windchillF'] as num).toDouble(),
//       heatindexC: (json['heatindexC'] as num).toDouble(),
//       heatindexF: (json['heatindexF'] as num).toDouble(),
//       dewpointC: (json['dewpointC'] as num).toDouble(),
//       dewpointF: (json['dewpointF'] as num).toDouble(),
//       visKm: json['visKm'] as int,
//       visMiles: json['visMiles'] as int,
//       uv: (json['uv'] as num).toDouble(),
//       gustMph: (json['gustMph'] as num).toDouble(),
//       gustKph: (json['gustKph'] as num).toDouble(),
//       timeEpoch: json['timeEpoch'] as int?,
//       time: json['time'] as String?,
//       snowCm: json['snowCm'] as int?,
//       willItRain: json['willItRain'] as int?,
//       chanceOfRain: json['chanceOfRain'] as int?,
//       willItSnow: json['willItSnow'] as int?,
//       chanceOfSnow: json['chanceOfSnow'] as int?,
//     );
//   }

//   /// Converts the [Current] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Current] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'lastUpdatedEpoch': lastUpdatedEpoch,
//       'lastUpdated': lastUpdated,
//       'tempC': tempC,
//       'tempF': tempF,
//       'isDay': isDay,
//       'condition': condition.toJson(),
//       'windMph': windMph,
//       'windKph': windKph,
//       'windDegree': windDegree,
//       'windDir': windDir.toJson(),
//       'pressureMb': pressureMb,
//       'pressureIn': pressureIn,
//       'precipMm': precipMm,
//       'precipIn': precipIn,
//       'humidity': humidity,
//       'cloud': cloud,
//       'feelslikeC': feelslikeC,
//       'feelslikeF': feelslikeF,
//       'windchillC': windchillC,
//       'windchillF': windchillF,
//       'heatindexC': heatindexC,
//       'heatindexF': heatindexF,
//       'dewpointC': dewpointC,
//       'dewpointF': dewpointF,
//       'visKm': visKm,
//       'visMiles': visMiles,
//       'uv': uv,
//       'gustMph': gustMph,
//       'gustKph': gustKph,
//       'timeEpoch': timeEpoch,
//       'time': time,
//       'snowCm': snowCm,
//       'willItRain': willItRain,
//       'chanceOfRain': chanceOfRain,
//       'willItSnow': willItSnow,
//       'chanceOfSnow': chanceOfSnow,
//     };
//   }
// }


// class Condition {
//   String text;
//   String icon;
//   int code;

//   Condition({
//     required this.text,
//     required this.icon,
//     required this.code,
//   });

//   /// Factory constructor to create a [Condition] instance from a JSON map.
//   factory Condition.fromJson(Map<String, dynamic> json) {
//     return Condition(
//       text: json['text'] as String,
//       icon: json['icon'] as String,
//       code: json['code'] as int,
//     );
//   }

//   /// Converts the [Condition] instance to a JSON map.
//   Map<String, dynamic> toJson() {
//     return {
//       'text': text,
//       'icon': icon,
//       'code': code,
//     };
//   }
// }


// enum Text {
//   CLEAR,
//   CLOUDY,
//   MIST,
//   OVERCAST,
//   PARTLY_CLOUDY,
//   SUNNY,
//   TEXT_PARTLY_CLOUDY;

//   /// Converts a string to the corresponding Text enum value.
//   ///
//   /// - [value]: The string representation of the weather condition.
//   ///
//   /// Returns the corresponding [Text] enum value.
//   static Text fromJson(String value) {
//     return Text.values.firstWhere((e) => e.toString().split('.').last == value);
//   }

//   /// Converts the Text enum value to its string representation.
//   ///
//   /// Returns a [String] representing the weather condition.
//   String toJson() {
//     return toString().split('.').last;
//   }
// }


// enum WindDir {
//   NW,
//   SSW,
//   SW,
//   W,
//   WNW,
//   WSW;

//   /// Converts a string to the corresponding WindDir enum value.
//   ///
//   /// - [value]: The string representation of the wind direction.
//   ///
//   /// Returns the corresponding [WindDir] enum value.
//   static WindDir fromJson(String value) {
//     return WindDir.values.firstWhere((e) => e.toString().split('.').last == value);
//   }

//   /// Converts the WindDir enum value to its string representation.
//   ///
//   /// Returns a [String] representing the wind direction.
//   String toJson() {
//     return toString().split('.').last;
//   }
// }


// class Forecast {
//   List<Forecastday> forecastday;

//   Forecast({
//     required this.forecastday,
//   });

//   /// Factory constructor to create a [Forecast] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns a [Forecast] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns a [Forecast] object.
//   factory Forecast.fromJson(Map<String, dynamic> json) {
//     return Forecast(
//       forecastday: (json['forecastday'] as List<dynamic>)
//           .map((item) => Forecastday.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   /// Converts the [Forecast] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Forecast] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'forecastday': forecastday.map((item) => item.toJson()).toList(),
//     };
//   }
// }


// class Forecastday {
//   DateTime date;
//   int dateEpoch;
//   Day day;
//   Astro astro;
//   List<Current> hour;

//   Forecastday({
//     required this.date,
//     required this.dateEpoch,
//     required this.day,
//     required this.astro,
//     required this.hour,
//   });

//   /// Factory constructor to create a [Forecastday] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns a [Forecastday] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns a [Forecastday] object.
//   factory Forecastday.fromJson(Map<String, dynamic> json) {
//     return Forecastday(
//       date: DateTime.parse(json['date'] as String),
//       dateEpoch: json['dateEpoch'] as int,
//       day: Day.fromJson(json['day'] as Map<String, dynamic>),
//       astro: Astro.fromJson(json['astro'] as Map<String, dynamic>),
//       hour: (json['hour'] as List<dynamic>)
//           .map((item) => Current.fromJson(item as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   /// Converts the [Forecastday] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Forecastday] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'date': date.toIso8601String(),
//       'dateEpoch': dateEpoch,
//       'day': day.toJson(),
//       'astro': astro.toJson(),
//       'hour': hour.map((item) => item.toJson()).toList(),
//     };
//   }
// }


// class Astro {
//   String sunrise;
//   String sunset;
//   String moonrise;
//   String moonset;
//   String moonPhase;
//   int moonIllumination;
//   int isMoonUp;
//   int isSunUp;

//   Astro({
//     required this.sunrise,
//     required this.sunset,
//     required this.moonrise,
//     required this.moonset,
//     required this.moonPhase,
//     required this.moonIllumination,
//     required this.isMoonUp,
//     required this.isSunUp,
//   });

//   /// Factory constructor to create an [Astro] instance from a JSON map.
//   ///
//   /// This method parses a JSON map and returns an [Astro] object.
//   ///
//   /// - [json]: A map representation of JSON data.
//   ///
//   /// Returns an [Astro] object.
//   factory Astro.fromJson(Map<String, dynamic> json) {
//     return Astro(
//       sunrise: json['sunrise'] as String,
//       sunset: json['sunset'] as String,
//       moonrise: json['moonrise'] as String,
//       moonset: json['moonset'] as String,
//       moonPhase: json['moonPhase'] as String,
//       moonIllumination: json['moonIllumination'] as int,
//       isMoonUp: json['isMoonUp'] as int,
//       isSunUp: json['isSunUp'] as int,
//     );
//   }

//   /// Converts the [Astro] instance to a JSON map.
//   ///
//   /// This method returns a map representation of the [Astro] object,
//   /// which can be used for JSON encoding.
//   ///
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'sunrise': sunrise,
//       'sunset': sunset,
//       'moonrise': moonrise,
//       'moonset': moonset,
//       'moonPhase': moonPhase,
//       'moonIllumination': moonIllumination,
//       'isMoonUp': isMoonUp,
//       'isSunUp': isSunUp,
//     };
//   }
// }


// class Day {
//   double maxtempC;
//   double maxtempF;
//   double mintempC;
//   double mintempF;
//   double avgtempC;
//   double avgtempF;
//   double maxwindMph;
//   double maxwindKph;
//   int totalprecipMm;
//   int totalprecipIn;
//   int totalsnowCm;
//   int avgvisKm;
//   int avgvisMiles;
//   int avghumidity;
//   int dailyWillItRain;
//   int dailyChanceOfRain;
//   int dailyWillItSnow;
//   int dailyChanceOfSnow;
//   Condition condition;
//   double uv;

//   Day({
//     required this.maxtempC,
//     required this.maxtempF,
//     required this.mintempC,
//     required this.mintempF,
//     required this.avgtempC,
//     required this.avgtempF,
//     required this.maxwindMph,
//     required this.maxwindKph,
//     required this.totalprecipMm,
//     required this.totalprecipIn,
//     required this.totalsnowCm,
//     required this.avgvisKm,
//     required this.avgvisMiles,
//     required this.avghumidity,
//     required this.dailyWillItRain,
//     required this.dailyChanceOfRain,
//     required this.dailyWillItSnow,
//     required this.dailyChanceOfSnow,
//     required this.condition,
//     required this.uv,
//   });

//   /// Factory constructor to create a [Day] instance from a JSON map.
//   /// 
//   /// This method parses a JSON map and returns a [Day] object.
//   /// 
//   /// - [json]: A map representation of JSON data.
//   /// 
//   /// Returns a [Day] object.
//   factory Day.fromJson(Map<String, dynamic> json) {
//     return Day(
//       maxtempC: (json['maxtempC'] as num).toDouble(),
//       maxtempF: (json['maxtempF'] as num).toDouble(),
//       mintempC: (json['mintempC'] as num).toDouble(),
//       mintempF: (json['mintempF'] as num).toDouble(),
//       avgtempC: (json['avgtempC'] as num).toDouble(),
//       avgtempF: (json['avgtempF'] as num).toDouble(),
//       maxwindMph: (json['maxwindMph'] as num).toDouble(),
//       maxwindKph: (json['maxwindKph'] as num).toDouble(),
//       totalprecipMm: json['totalprecipMm'] as int,
//       totalprecipIn: json['totalprecipIn'] as int,
//       totalsnowCm: json['totalsnowCm'] as int,
//       avgvisKm: json['avgvisKm'] as int,
//       avgvisMiles: json['avgvisMiles'] as int,
//       avghumidity: json['avghumidity'] as int,
//       dailyWillItRain: json['dailyWillItRain'] as int,
//       dailyChanceOfRain: json['dailyChanceOfRain'] as int,
//       dailyWillItSnow: json['dailyWillItSnow'] as int,
//       dailyChanceOfSnow: json['dailyChanceOfSnow'] as int,
//       condition: Condition.fromJson(json['condition'] as Map<String, dynamic>),
//       uv: (json['uv'] as num).toDouble(),
//     );
//   }

//   /// Converts the [Day] instance to a JSON map.
//   /// 
//   /// This method returns a map representation of the [Day] object, 
//   /// which can be used for JSON encoding.
//   /// 
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'maxtempC': maxtempC,
//       'maxtempF': maxtempF,
//       'mintempC': mintempC,
//       'mintempF': mintempF,
//       'avgtempC': avgtempC,
//       'avgtempF': avgtempF,
//       'maxwindMph': maxwindMph,
//       'maxwindKph': maxwindKph,
//       'totalprecipMm': totalprecipMm,
//       'totalprecipIn': totalprecipIn,
//       'totalsnowCm': totalsnowCm,
//       'avgvisKm': avgvisKm,
//       'avgvisMiles': avgvisMiles,
//       'avghumidity': avghumidity,
//       'dailyWillItRain': dailyWillItRain,
//       'dailyChanceOfRain': dailyChanceOfRain,
//       'dailyWillItSnow': dailyWillItSnow,
//       'dailyChanceOfSnow': dailyChanceOfSnow,
//       'condition': condition.toJson(),
//       'uv': uv,
//     };
//   }
// }


// class Location {
//   String name;
//   String region;
//   String country;
//   double lat;
//   double lon;
//   String tzId;
//   int localtimeEpoch;
//   String localtime;

//   Location({
//     required this.name,
//     required this.region,
//     required this.country,
//     required this.lat,
//     required this.lon,
//     required this.tzId,
//     required this.localtimeEpoch,
//     required this.localtime,
//   });

//   /// Factory constructor to create a [Location] instance from a JSON map.
//   /// 
//   /// This method parses a JSON map and returns a [Location] object.
//   /// 
//   /// - [json]: A map representation of JSON data.
//   /// 
//   /// Returns a [Location] object.
//   factory Location.fromJson(Map<String, dynamic> json) {
//     return Location(
//       name: json['name'] as String,
//       region: json['region'] as String,
//       country: json['country'] as String,
//       lat: json['lat'] as double,
//       lon: json['lon'] as double,
//       tzId: json['tzId'] as String,
//       localtimeEpoch: json['localtimeEpoch'] as int,
//       localtime: json['localtime'] as String,
//     );
//   }

//   /// Converts the [Location] instance to a JSON map.
//   /// 
//   /// This method returns a map representation of the [Location] object, 
//   /// which can be used for JSON encoding.
//   /// 
//   /// Returns a [Map<String, dynamic>] representing the JSON data.
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'region': region,
//       'country': country,
//       'lat': lat,
//       'lon': lon,
//       'tzId': tzId,
//       'localtimeEpoch': localtimeEpoch,
//       'localtime': localtime,
//     };
//   }
// }

