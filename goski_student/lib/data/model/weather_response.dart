class WeatherResponse {
  double temp;
  String weather;
  String description;
  String iconUrl;

  WeatherResponse({
    required this.temp,
    required this.weather,
    required this.description,
    required this.iconUrl,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> weatherList = json['weather'];
    Map<String, dynamic> weather = weatherList.first;
    Map<String, dynamic> main = json['main'];

    return WeatherResponse(
      temp: main['temp'] as double,
      weather: weather['main'] as String,
      description: weather['description'] as String,
      iconUrl: weather['icon'] as String,
    );
  }

  @override
  String toString() {
    return 'WeatherResponse{temp: $temp, weather: $weather, description: $description, iconUrl: $iconUrl}';
  }
}

class Weather {
  int temp;
  String weather;
  String description;
  String iconUrl;

  Weather({
    required this.temp,
    required this.weather,
    required this.description,
    required this.iconUrl,
  });

  @override
  String toString() {
    return 'Weather{temp: $temp, weather: $weather, description: $description, iconUrl: $iconUrl}';
  }
}

extension WeatherResponseToWeather on WeatherResponse {
  Weather toWeather() {
    return Weather(
      temp: temp.toInt(),
      weather: weather,
      description: description,
      iconUrl: 'https://openweathermap.org/img/wn/$iconUrl@2x.png',
    );
  }
}
