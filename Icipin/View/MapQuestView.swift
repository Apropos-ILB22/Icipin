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
                    mapQuestViewModel.saveQuest()
                    mapQuestViewModel.getAllQuest()
                }
        }
        .ignoresSafeArea()
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView //create alias for easiness
    
    @Binding var directions: [String]
    @StateObject var mapQuestViewModel: MapQuestViewModel
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.pointOfInterestFilter = .excludingAll
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
    }
}
