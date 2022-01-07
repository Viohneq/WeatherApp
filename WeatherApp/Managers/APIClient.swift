import Foundation

struct Constants {
    static let API_KEY = "353506011d4eaf9e64bbdd436a57dfe1"
    static let baseURL = "https://api.openweathermap.org/"
}

enum APIError: Error {
    case failedGetData
}

class APIClient {

    static let shared = APIClient()
    
    func oneCall(_ latitude: Double, _ longitude: Double,
                           completion: @escaping (Result<OneCallResponse, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.API_KEY)&units=metric") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { responseData, _, error in
            guard let data = responseData, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(OneCallResponse.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        }
        
        task.resume()
    }
    
    func reverseGeoCoding(_ latitude: Double, _ longitude: Double,
                          completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)geo/1.0/reverse?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.API_KEY)") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { responseData, _, error in
            guard let data = responseData, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode([ReverseGeoCodeResponse].self, from: data)
                completion(.success(results[0].name))
            } catch {
                completion(.failure(APIError.failedGetData))
            }
        })
        
        task.resume()
    }
}
