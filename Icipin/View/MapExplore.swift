////
////  MapExplore.swift
////  ExploreMapkit
////
////  Created by Rivaldo Fernandes on 15/08/22.
////
//
//import SwiftUI
//import MapKit
//
//struct MapExplore: View {
//    @State private var directions: [String] = []
//    @State private var showDirections = false
//    
//    
//    var body: some View {
//        VStack {
//            MapView(directions: $directions)
//            
//            Button(action: {
//                self.showDirections.toggle()
//            }, label: {
//                Text("Show Directions")
//            })
//            .disabled(directions.isEmpty)
//            .padding()
//        }.sheet(isPresented: $showDirections, content: {
//            VStack {
//                Text("Directions")
//                    .font(.largeTitle)
//                    .bold()
//                    .padding()
//                
//                Divider().background(Color.blue)
//                
//                List {
//                    ForEach(0..<self.directions.count, id: \.self){ i in
//                        Text(self.directions[i])
//                            .padding()
//                    }
//                }
//            }
//        })
//    }
//}
//
//struct MapExplore_Previews: PreviewProvider {
//    static var previews: some View {
//        MapExplore()
//    }
//}
//
//struct MapView: UIViewRepresentable {
//    typealias UIViewType = MKMapView
//    
//    @Binding var directions: [String]
//    
//    
//    func makeCoordinator() -> MapViewCoordinator {
//        return MapViewCoordinator()
//    }
//    
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView()
//        mapView.delegate = context.coordinator
//        mapView.showsUserLocation = true
//        mapView.pointOfInterestFilter = .excludingAll
//        
//        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.71, longitude: -74), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//        
//        let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: -6.246281, longitude: 106.799436))
//        let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:  -6.243657677945562, longitude: 106.79665714354027))
//        
//        let annP1 = MKPointAnnotation()
//        annP1.title = "Rivaldo's House"
//        annP1.subtitle = "This is Rivaldo's House"
//        annP1.coordinate = CLLocationCoordinate2D(latitude: -6.233397658281518, longitude: 106.81225687109864)
//
//        
//        let annP2 = MKPointAnnotation()
//        annP2.title = "Institut Teknologi Sumatera"
//        annP2.subtitle = "This is Institut Teknologi Sumatera"
//        annP2.coordinate = CLLocationCoordinate2D(latitude: -5.35803997504787, longitude: 105.3148494971844)
//        
//        let request = MKDirections.Request()
//        request.source = MKMapItem(placemark: p1)
//        request.destination = MKMapItem(placemark: p2)
//        request.transportType = .walking
//        
//        let directions = MKDirections(request: request)
//        directions.calculate{response, error in
//            guard let route = response?.routes.first else {return}
//            mapView.addAnnotations([annP1, annP2])
//            
//            mapView.addOverlay(route.polyline)
//            mapView.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),  animated: true)
//            
//            self.directions = route.steps.map{
//                $0.instructions
//            }.filter{
//                !$0.isEmpty
//            }
//        }
//        
//        mapView.setRegion(region, animated: true)
//        return mapView
//    }
//    
//    
//    func updateUIView(_ uiView: MKMapView, context: Context) {
////        for annotation: MKAnnotation in uiView.annotations {
////            print("Hello")
////
////            let anView = uiView.view(for: annotation)
////
////            if (anView != nil)
////            {
////                anView?.image = UIImage(named: "arrow.clockwise.heart.fill")
////            }
////        }
////        context.self.image = UIImage(named: "arrow.clockwise.heart.fill")
//        
//    }
//    
//    class MapViewCoordinator: NSObject, MKMapViewDelegate {
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            let renderer = MKPolylineRenderer(overlay: overlay)
//            renderer.strokeColor = .orange
//            renderer.lineWidth = 5
//            return renderer
//        }
//        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let markAnnotation = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PIN")
////            markAnnotation.image = UIImage(systemName: "arrow.clockwise.heart.fill")
//            markAnnotation.canShowCallout = true
//            markAnnotation.isDraggable = true
//            markAnnotation.glyphImage = UIImage(systemName: "arrow.clockwise.heart.fill")
//            return markAnnotation
//        }
//        
//        
//    }
//    
//}
