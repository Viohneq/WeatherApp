import Foundation

struct OneCallResponse: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct HourlyWeather: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]
}

struct DailyWeather: Codable {
    let dt: Int
    let weather: [Weather]
    let temp: Temperature
}

struct Temperature: Codable {
    let day: Double
    let night: Double
}



