//
//  MapQuestViewModel.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI
import MapKit

class MapQuestViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var userLocation = CLLocationCoordinate2D(latitude: -6.244702866167007, longitude: 106.79875999598278)
    
    func checkLocationServicedIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("alert to activate location permission")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your Location is restricted likely due to parental contorls")
        case .denied:
            print("Your Location is denied this apps location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            userLocation = locationManager.location!.coordinate
        @unknown default:
            print("Unknown")
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
