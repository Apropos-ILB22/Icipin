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
    
    
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    
    var body: some View {
        VStack {
            MapView(directions: self.$directions, mapQuestViewModel: self.mapQuestViewModel)
                .onAppear{
                    mapQuestViewModel.checkLocationServicedIsEnabled()
//                                        mapQuestViewModel.saveQuest()
//                                        mapQuestViewModel.getAllQuest()
                }
        }
        .ignoresSafeArea()
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView //create alias for easiness
    
    @Binding var directions: [String]
    @StateObject var mapQuestViewModel: MapQuestViewModel
    var prevLocation = CLLocationManager().location?.coordinate
    
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(customView: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = .excludingAll
        
        mapQuestViewModel.getAllQuest()
        let quests = mapQuestViewModel.quests
        
        for quest in quests {
            for place in quest.places?.allObjects as! [Place] {
                let annotation = MKPointAnnotation()
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
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(customView: MapView) {
            self.parent = customView
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5
            return renderer
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let p1 = MKPlacemark(coordinate: parent.prevLocation!)
            let p2 = MKPlacemark(coordinate: view.annotation!.coordinate)
            
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: p1)
            request.destination = MKMapItem(placemark: p2)
            request.transportType = .walking

            let directions = MKDirections(request: request)
            directions.calculate{response, error in
                guard let route = response?.routes.first else {return}
                print(route)

                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),  animated: true)
            }
            
            parent.prevLocation = view.annotation!.coordinate
        }
    }
}
