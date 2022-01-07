import Foundation
import CoreLocation

final class LocationService: NSObject {
    
    static let shared = LocationService()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation = CLLocation()
        
    func updateLocation() {
        locationManager.requestLocation()
        currentLocation = locationManager.location ?? CLLocation()
    }
    
    private func configureLocationManager() {
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
    }
    
}

extension LocationService : CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error:: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if locations.first != nil {
            print("location:: \(String(describing: locations.first))")
        }

    }

}

