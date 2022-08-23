//
//  MapQuestView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI
import UIKit
import MapKit


struct MapQuestView: View {
    @StateObject private var mapQuestViewModel = MapQuestViewModel()
    
    @State private var showWelcomeModal = true
    @State private var showQuestModal = false
    @State private var showToScanModal = false
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    @State private var titleCurrentQuest: String? = nil
    
    
    var body: some View {
        ZStack {
            VStack {
                MapView(directions: self.$directions,
                        showQuestModal: self.$showQuestModal,
                        showWelcomeModal: self.$showWelcomeModal,
                        titleCurrentQuest: self.$titleCurrentQuest,
                        mapQuestViewModel: self.mapQuestViewModel)
                    .onAppear{
                        mapQuestViewModel.checkLocationServicedIsEnabled()
    //                                        mapQuestViewModel.saveQuest()
    //                                        mapQuestViewModel.getAllQuest()
                    }
            }
            .ignoresSafeArea()
            
            WelcomeView(isShowing: $showWelcomeModal)
            QuestModalView(isShowing: $showQuestModal, titleCurrentQuest: $titleCurrentQuest)
        }
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView //create alias for easiness
    let mapView = MKMapView()
    
    @Binding var directions: [String]
    @Binding var showQuestModal: Bool
    @Binding var showWelcomeModal: Bool
    @Binding var titleCurrentQuest: String?

    @StateObject var mapQuestViewModel: MapQuestViewModel
    var prevLocation = CLLocationManager().location?.coordinate
    
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(customView: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
        mapView.pointOfInterestFilter = .excludingAll
        
        mapQuestViewModel.getAllQuest()
        let quests = mapQuestViewModel.quests
        
        for quest in quests {
            for place in quest.places?.allObjects as! [Place] {
                let annotation = CustomPointAnnotation()
                annotation.identifier = place.uuid
                annotation.title = quest.title!
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                mapView.addAnnotation(annotation)
                
                print(quest.title!)
            }
        }
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        var cameraHeading: CLHeading?
        
        init(customView: MapView) {
            self.parent = customView
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(Color("primary"))
            renderer.lineWidth = 3
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
//            guard let selectedAnnotate = annotation as? CustomPointAnnotation else {
//                print("fail set data")
//                return
//            }
            
            if let selectedAnnotate = annotation as? CustomPointAnnotation {
                print(" debug mapuikit: \(selectedAnnotate.identifier)")
            }
            
            
            
            
            let markAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN")
//            markAnnotation.image = UIImage(systemName: "arrow.clockwise.heart.fill")
            markAnnotation.canShowCallout = true
            markAnnotation.isDraggable = true
            markAnnotation.glyphImage = UIImage(systemName: "arrow.clockwise.heart.fill")
            markAnnotation.markerTintColor = UIColor(Color("primary"))
            return markAnnotation
            
            
            
        }
        
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("select")
//
//            parent.showQuestModal = true
//            parent.showWelcomeModal = false
//            parent.titleCurrentQuest = view.annotation!.title!
//
//            print(" debug mapuikit: \(parent.titleCurrentQuest)")
//
//            let selectedAnnotate = view.annotation as! CustomPointAnnotation
//            print(" debug mapuikit: \(selectedAnnotate.identifier)")
//
//            let p1 = MKPlacemark(coordinate: parent.prevLocation!)
//            let p2 = MKPlacemark(coordinate: view.annotation!.coordinate)
//
//            let request = MKDirections.Request()
//            request.source = MKMapItem(placemark: p1)
//            request.destination = MKMapItem(placemark: p2)
//            request.transportType = .walking
//
//            let directions = MKDirections(request: request)
//            directions.calculate{response, error in
//                guard let route = response?.routes.first else {return}
//                print(route)
//
//                mapView.addOverlay(route.polyline)
//                mapView.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),  animated: true)
//            }
//
//            parent.prevLocation = view.annotation!.coordinate
        }
    }
}

class CustomPointAnnotation : MKPointAnnotation {
    var identifier: UUID?
    
}
