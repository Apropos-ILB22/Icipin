//
//  MapQuestViewModel.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI
import MapKit
import CoreData

class MapQuestViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var userLocation = CLLocationCoordinate2D(latitude: -6.244702866167007, longitude: 106.79875999598278)
    
    @Published var quests: [Quest] = []
    
    func checkLocationServicedIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.delegate = self
        } else {
            print("alert to activate location permission")
        }
    }
    
    func getUserLocation(){
        guard let locationManager = locationManager else {
            return
        }
        userLocation = locationManager.location!.coordinate
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
    
    func getAllQuest(){
        quests = CoreDataManager.shared.getAllQuest()
        
        for quest in quests {
            print(quest.food_name)
            for clue in quest.clues?.allObjects as! [Clue]{
                print(clue.title)
            }
        }
    }
    
    func saveQuest() {
        let quest = Quest(context: CoreDataManager.shared.viewContext)
        quest.title = "Santan Kental"
        quest.food_name = "Soto Betawi"
        quest.status = false
        quest.story = "Makanan Khas Jakarta"
        quest.uuid = UUID()
        
        let clue1 = Clue(context: CoreDataManager.shared.viewContext)
        clue1.title = "Cari makanan kentalnya"
        
        let clue2 = Clue(context: CoreDataManager.shared.viewContext)
        clue2.title = "Cari Soto kentalnya"
        
        let clue3 = Clue(context: CoreDataManager.shared.viewContext)
        clue3.title = "Cari Tempat kentalnya"
        
        let clue4 = Clue(context: CoreDataManager.shared.viewContext)
        clue4.title = "Cari Minuman kentalnya"
        
        let place1 = Place(context: CoreDataManager.shared.viewContext)
        place1.uuid = UUID()
        place1.latitude = 4.143343
        place1.longitude = 151.23525335
        place1.rating = 4.5
        place1.name = "Rumah Jakarta"
        
        let place2 = Place(context: CoreDataManager.shared.viewContext)
        place2.uuid = UUID()
        place2.latitude = 4.143343
        place2.longitude = 151.23525335
        place2.rating = 4.5
        place2.name = "Rumah Betawi"
        
        let place3 = Place(context: CoreDataManager.shared.viewContext)
        place3.uuid = UUID()
        place3.latitude = 4.143343
        place3.longitude = 151.23525335
        place3.rating = 4.5
        place3.name = "Rumah Adat"
        
        quest.addToClues(clue1)
        quest.addToClues(clue2)
        quest.addToClues(clue3)
        quest.addToClues(clue4)
        
        quest.addToPlaces(place1)
        quest.addToPlaces(place2)
        quest.addToPlaces(place3)
        
        CoreDataManager.shared.saveContext()
    }
    
}
