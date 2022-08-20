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
            MapView(directions: self.$directions)
                .onAppear{
                    mapQuestViewModel.checkLocationServicedIsEnabled()
                }
        }
        .ignoresSafeArea()
        
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView //create alias for easiness
    
    @Binding var directions: [String]
    
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
        
    }
}
