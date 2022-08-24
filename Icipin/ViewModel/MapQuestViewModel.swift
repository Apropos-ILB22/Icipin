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
    @Published var userLocation = CLLocationManager().location?.coordinate
    @Published var quest: Quest? = nil
    
    
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
    
    func loadJSONData(){
        guard let url = Bundle.main.url(forResource: "locations", withExtension: "json") else {
            fatalError("File json not found")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return
        }
//
//        guard let data = try? Data(contentsOf: url) else {
//            return
//        }
        
        guard let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return}
        
        print(prettyPrintedString)
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
    
    func getQuestByName(title: String) -> Quest? {
        let result = CoreDataManager.shared.getQuestByName(titleQuest: title)
        if(result.isEmpty){
            return nil
        }else{
            for quest in result {
                return quest
            }
        }
        return nil
    }
    
    func saveQuest() {
        let quest1 = Quest(context: CoreDataManager.shared.viewContext)
        
        quest1.title = "Bola Gurita"
        quest1.food_name = "Takoyaki"
        quest1.status = false
        quest1.story = "Makanan Khas Jakarta"
        quest1.hexcolor = "#AD23B4"
        quest1.icon = "drink_icon_annotation"
        quest1.uuid = UUID()
        
        let quest2 = Quest(context: CoreDataManager.shared.viewContext)
        quest2.title = "Martabak Jepang"
        quest2.food_name = "Okonomiyaki"
        quest2.status = false
        quest2.story = "Makanan Khas Jakarta"
        quest2.hexcolor = "#0082E3"
        quest2.icon = "maincourse_icon_annotation"
        quest2.uuid = UUID()
        
        let clue1 = Clue(context: CoreDataManager.shared.viewContext)
        clue1.title = "Cari makanan kentalnya"
        let clue2 = Clue(context: CoreDataManager.shared.viewContext)
        clue2.title = "Cari Soto kentalnya"
        let clue3 = Clue(context: CoreDataManager.shared.viewContext)
        clue3.title = "Cari Tempat kentalnya"
        let clue4 = Clue(context: CoreDataManager.shared.viewContext)
        clue4.title = "Cari Minuman kentalnya"
        
        let clue5 = Clue(context: CoreDataManager.shared.viewContext)
        clue5.title = "Ku tak tau"
        
        let clue6 = Clue(context: CoreDataManager.shared.viewContext)
        clue6.title = "dah pusing"
        
        let clue7 = Clue(context: CoreDataManager.shared.viewContext)
        clue7.title = "semoga selesai"
        
        let clue8 = Clue(context: CoreDataManager.shared.viewContext)
        clue8.title = "dahlah"
        
        let place1 = Place(context: CoreDataManager.shared.viewContext)
        place1.uuid = UUID()
        place1.latitude = -6.243657677945562
        place1.longitude = 106.79665714354027
        place1.rating = 4.5
        place1.name = "Rumah Bola"
        
        let place2 = Place(context: CoreDataManager.shared.viewContext)
        place2.uuid = UUID()
        place2.latitude = -6.243764329899769
        place2.longitude = 106.79967194645788
        place2.rating = 4.5
        place2.name = "Toko Bola"
        
        let place3 = Place(context: CoreDataManager.shared.viewContext)
        place3.uuid = UUID()
        place3.latitude = -6.245833373512986
        place3.longitude = 106.7963030919521
        place3.rating = 4.5
        place3.name = "Kios Bola"
        
        quest1.addToClues(clue1)
        quest1.addToClues(clue2)
        quest1.addToClues(clue3)
        quest1.addToClues(clue4)
        
        quest2.addToClues(clue5)
        quest2.addToClues(clue6)
        quest2.addToClues(clue7)
        quest2.addToClues(clue8)
        
        quest1.addToPlaces(place1)
        quest2.addToPlaces(place2)
        quest1.addToPlaces(place3)
        
        CoreDataManager.shared.saveContext()
    }
    
}
