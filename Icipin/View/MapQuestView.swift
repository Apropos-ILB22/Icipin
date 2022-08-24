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
    @State private var chosenQuests : [Quest] = []
    
    @State private var showWelcomeModal = true
    @State private var showQuestModal = false
    @State var isSelectQuestActive = false
    @State var isStartJourneyActive = false
    @State private var showToScanModal = false
    @State private var directions: [String] = []
    @State private var showDirections = false
    
    @State var currentQuest: Quest?
    @State var currentPlace: Place?
    @State var prevQuest: Quest?
    @State var prevPlace: Place?
    @State var metricDistance: Double?
    @State var metricDuration: Double?
    @State var mapView: MKMapView? = MKMapView()
    
    var body: some View {
        ZStack {
            VStack {
                MapView(mapView: self.$mapView, directions: self.$directions,
                        showQuestModal: self.$showQuestModal,
                        showWelcomeModal: self.$showWelcomeModal,
                        isSelectQuestActive: self.$isSelectQuestActive,
                        isStartJourneyActive: self.$isStartJourneyActive,
                        currentQuest: self.$currentQuest,
                        currentPlace: self.$currentPlace,
                        prevQuest: self.$prevQuest,
                        prevPlace: self.$prevPlace,
                        metricDistance: self.$metricDistance,
                        metricDuration: self.$metricDuration,
                        mapQuestViewModel: self.mapQuestViewModel)
                    .onAppear{
                        mapQuestViewModel.checkLocationServicedIsEnabled()
//                                            mapQuestViewModel.saveQuest()
//                                            mapQuestViewModel.getAllQuest()
                    }
            }
            .ignoresSafeArea()
            
            WelcomeView(isShowing: $showWelcomeModal)
            QuestModalView(mapView: self.$mapView,
                           isSelectQuestActive: self.$isSelectQuestActive,
                           isStartJourneyActive: self.$isStartJourneyActive,
                           isShowing: self.$showQuestModal,
                           currentQuest: self.$currentQuest,
                           currentPlace: self.$currentPlace,
                           prevQuest: self.$prevQuest,
                           prevPlace: self.$prevPlace,
                           metricDistance: self.$metricDistance,
                           metricDuration: self.$metricDuration
            )
        }
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView //create alias for easiness
    @Binding var mapView: MKMapView?
    
    @Binding var directions: [String]
    @State var currentUserLocation: CLLocationCoordinate2D? = nil
    @Binding var showQuestModal: Bool
    @Binding var showWelcomeModal: Bool
    @Binding var isSelectQuestActive: Bool
    @Binding var isStartJourneyActive: Bool
    
    @Binding var currentQuest: Quest?
    @Binding var currentPlace: Place?
    @Binding var prevQuest: Quest?
    @Binding var prevPlace: Place?
    @Binding var metricDistance: Double?
    @Binding var metricDuration: Double?

    @StateObject var mapQuestViewModel: MapQuestViewModel
    var prevLocation = CLLocationManager().location?.coordinate
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(customView: self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        mapView!.delegate = context.coordinator
        mapView!.showsUserLocation = true
        
        mapView!.userTrackingMode = .followWithHeading
        mapView!.pointOfInterestFilter = .excludingAll
        mapView!.isRotateEnabled = true
        
        mapQuestViewModel.getAllQuest()
        let quests = mapQuestViewModel.quests
        
        for quest in quests {
            for place in quest.places?.allObjects as! [Place] {
                let annotation = CustomPointAnnotation()
                annotation.quest = quest
                annotation.place = place
                annotation.identifier = place.uuid
                annotation.title = quest.title!
                annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                mapView!.addAnnotation(annotation)
                
                print(quest.title!)
            }
        }
        return mapView!
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
            parent.currentUserLocation = userLocation.coordinate
            let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
            mapView.setRegion(region, animated: true)
        }
        
        //delegate function for route overlay
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor(Color("primary"))
            renderer.lineWidth = 3
            return renderer
        }
        
        //delegate to update the annotation
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
            if annotation is MKUserLocation {
                return nil
            }
            
            
//            let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//            mapView.setRegion(region, animated: true)
            
            
//            guard let selectedAnnotate = annotation as? CustomPointAnnotation else {
//                print("fail set data")
//                return
//            }
            let markAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN")
            if let selectedAnnotate = annotation as? CustomPointAnnotation {
                print(" debug mapuikit: \(selectedAnnotate.identifier)")
                markAnnotation.markerTintColor = selectedAnnotate.quest?.color
//                markAnnotation.glyphImage = UIImage(named: (selectedAnnotate.quest?.icon)!)
            }
            
            markAnnotation.glyphImage = UIImage(named:"test")
            
//            markAnnotation.glyphImage = UIImage(named: "test")
//            markAnnotation.canShowCallout = true
//            markAnnotation.isDraggable = true
//            markAnnotation.glyphTintColor = UIColor(Color.cyan.opacity(0.0))
//            markAnnotation.glyphImage = UIImage(named: "drink_icon_annotation")
//            markAnnotation.markerTintColor = UIColor(Color("primary").opacity(0.0))
            return markAnnotation
        }
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
            parent.showQuestModal = false
            parent.isStartJourneyActive = false
        }
        
        //delegate function for selected annotation
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let currAnnotation = view.annotation as? CustomPointAnnotation {
                
                if let userLocation = parent.currentUserLocation {
                    mapView.setCenter(view.annotation!.coordinate, animated: true)
                    parent.currentQuest = currAnnotation.quest
                    parent.currentPlace = currAnnotation.place
                    
                    parent.showQuestModal = true
                    parent.showWelcomeModal = false
                    
                    let p1 = MKPlacemark(coordinate: userLocation)
                    let p2 = MKPlacemark(coordinate: currAnnotation.coordinate)
        
                    let request = MKDirections.Request()
                    request.source = MKMapItem(placemark: p1)
                    request.destination = MKMapItem(placemark: p2)
                    request.transportType = .walking
                    
                    let directions = MKDirections(request: request)
                    directions.calculate{response, error in
                        guard let route = response?.routes.first else {return}
                        let distance = route.distance
                        let duration = route.expectedTravelTime
                        self.parent.metricDistance = distance
                        self.parent.metricDuration = duration
                        
//                        self.parent.currentPlaceMetric?.distance = distance
//                        self.parent.currentPlaceMetric?.duration = duration
//
//                        print(" debug mapuikit: \(self.parent.currentPlaceMetric?.distance)")
//                        print(" debug mapuikit: \(self.parent.currentPlaceMetric?.duration)")
                    }
                    
                }

            }
            
//            print(" debug mapuikit: \(parent.titleCurrentQuest)")
//
//            let selectedAnnotate = view.annotation as! CustomPointAnnotation
//            print(" debug mapuikit: \(selectedAnnotate.identifier)")

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
