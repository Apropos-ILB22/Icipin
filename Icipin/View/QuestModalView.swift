//
//  QuestView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 22/08/22.
//

import SwiftUI
import MapKit

struct QuestModalView: View {
    @StateObject private var mapQuestViewModel = MapQuestViewModel()
    @Binding var mapView: MKMapView?
    @Binding var chosenQuestList : [Quest]
    @Binding var chosenPlaceList : [Place]
    @Binding var chosenRouteDistance: [Double]
    @Binding var isSelectQuestActive: Bool
    @Binding var isStartJourneyActive: Bool
    @Binding var isShowToScan: Bool
    @Binding var isShowing: Bool
    @Binding var currentQuest: Quest?
    @Binding var currentPlace: Place?
    @Binding var currentUserLocation: CLLocationCoordinate2D?
    @Binding var prevQuest: Quest?
    @Binding var prevPlace: Place?
//    @Binding var currentPlaceMetric: PlaceMetric?
    @Binding var metricDistance: Double?
    @Binding var metricDuration: Double?
    
    @State private var showClueModal = false
    @State private var isDragging = false
    @State private var buttonText = ""
    
    @State private var curHeight: CGFloat = 250
    let minHeight: CGFloat = 250
    let maxHeight: CGFloat = 700
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing {
                Color.black
                    .opacity(0.0) //mark todo change background
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                if (currentQuest != nil){
                    mainView
                }
            }
            if showClueModal{
                QuestClueModalView(isShowingClue: self.$showClueModal, currentQuest: self.$currentQuest, currentPlace: self.$currentPlace, metricDistance: self.$metricDistance, metricDuration: self.$metricDuration)
            }
            
            if isStartJourneyActive{
                StartJourneyModalView(chosenQuestList: self.$chosenQuestList, chosenPlaceList: self.$chosenPlaceList, chosenRouteDistance: self.$chosenRouteDistance, currentQuest: self.$currentQuest, currentPlace: self.$currentPlace, currentUserLocation: self.$currentUserLocation ,metricDistance: self.$metricDistance, metricDuration: self.$metricDuration, showToScan: self.$isShowToScan, isShowing: self.$isStartJourneyActive)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .animation(Animation.easeInOut, value: isShowing)
        
        //        .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack{
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            .padding(.top,2)
            
//                Spacer()
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        Image("test_bolagurita")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .padding(.leading,30)
                        VStack(alignment: .leading) {
                            Text((currentQuest?.title)!).fontWeight(.bold).font(.title2)
                            Text((currentQuest?.category)!).fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                        Text("\(String(format: "%.1f", (metricDistance ?? 1) / 1000)) km").fontWeight(.medium).font(.body)
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                        Text("\(String(format: "%.0f", (metricDuration ?? 1) / 60)) mnt").fontWeight(.medium).font(.body)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(String(format: "%.1f", currentPlace?.rating ?? 0))").fontWeight(.medium).font(.body)
//                        Text("\()").fontWeight(.medium).font(.body)
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //show clue
                    withAnimation {
                        showClueModal = true
                    }
//                    isShowing = false
                }, label: {
                    Image(systemName: "key")
                        .font(.title2)
                })
                .padding(15)
                .foregroundColor(.white)
                .background(Color("primary"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Spacer()
            Button(action: {
                if(isSelectQuestActive == false){
                    isSelectQuestActive = true
                    
                    if(chosenPlaceList.count == 0){
                        isStartJourneyActive = true

                        withAnimation{
                            self.isShowing = false
                        }

                        self.chosenQuestList.append(currentQuest!)
                        self.chosenPlaceList.append(currentPlace!)
                        self.chosenRouteDistance.append(metricDistance!)

                        print("Debug quest modal : \(chosenPlaceList.count)")
                        print("Debug quest modal : \(chosenQuestList.count)")

                        self.prevQuest = currentQuest
                        self.prevPlace = currentPlace

                        drawRoute()
                    }
                }else{
                    
                    if(!chosenPlaceList.contains(currentPlace!)){
                        isStartJourneyActive = true

                        withAnimation{
                            self.isShowing = false
                        }
                        
                        self.chosenQuestList.append(currentQuest!)
                        self.chosenPlaceList.append(currentPlace!)
                        self.chosenRouteDistance.append(metricDistance!)
                        
                        print("Debug quest modal : \(chosenPlaceList.count)")
                        print("Debug quest modal : \(chosenQuestList.count)")
                        
                        self.prevQuest = currentQuest
                        self.prevPlace = currentPlace
                        
                        drawRoute()
                    }else{
                        if let indexPlace = chosenPlaceList.firstIndex(of: currentPlace!) {
                          chosenPlaceList.remove(at: indexPlace)
                            self.chosenRouteDistance.append(metricDistance!)
                        }

                        if let indexQuest = chosenQuestList.firstIndex(of: currentQuest!) {
                          chosenQuestList.remove(at: indexQuest)
                        }
                        
                        
                        drawRoute()
                    }
                    
                }
                self.isSelectQuestActive = true
            }, label: {
                Text(self.isSelectQuestActive ? (chosenPlaceList.contains(currentPlace!) ? "HAPUS QUEST" : "TAMBAH QUEST") : "PILIH QUEST")
                    .font(.body)
                    .bold()
                    .frame(width: UIScreen .main.bounds.width-20, height: 58, alignment: .center)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .background(Color("primary"))
                    .cornerRadius(20)
            })
            
        }
        .padding(.bottom,25)
        .frame(height: curHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack{
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: curHeight/2)
            }
                .foregroundColor(.white)
        )
        .animation(isDragging ? nil : .easeInOut(duration: 0.45), value: isDragging)
        .transition(.move(edge: .bottom))
        
    }
    
    func drawRoute(){
        mapView!.removeOverlays(mapView!.overlays)
        var currPlace = mapView?.userLocation.coordinate
        var prePlace = mapView?.userLocation.coordinate
        
        for place in self.chosenPlaceList {
            currPlace = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
                let p1 = MKPlacemark(coordinate: prePlace!)
                let p2 = MKPlacemark(coordinate: currPlace!)
                createPolyline(p1: p1, p2: p2)
            prePlace = currPlace
            
            print("debug drawing \(prePlace) kdlj \(currPlace)")
        }
        mapView!.removeOverlays(mapView!.overlays)
    }
    
    func createPolyline(p1: MKPlacemark, p2: MKPlacemark){
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: p1)
        request.destination = MKMapItem(placemark: p2)
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate{response, error in
            guard let route = response?.routes.first else {return}
            mapView!.addOverlay(route.polyline)
            mapView!.setVisibleMapRect(route.polyline.boundingMapRect,edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),  animated: true)
        }
    }
    
    @State private var prevDragTranslation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { val in
                if !isDragging {
                    isDragging = true
                }
                
                let dragAmount = val.translation.height - prevDragTranslation.height
                if curHeight > maxHeight || curHeight < minHeight {
                    curHeight -= dragAmount/6
                }else{
                     curHeight -= dragAmount
                }
                prevDragTranslation = val.translation
            }
            .onEnded { val in
                prevDragTranslation = .zero
                isDragging = false
                if curHeight > maxHeight {
                    curHeight = maxHeight
                }else if curHeight < minHeight {
                    curHeight = curHeight
                    withAnimation {
                        isShowing = false
                    }
                }
            }
    }
}

//struct QuestView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestModalView(isShowing: .constant(true), titleCurrentQuest: .constant(""))
//    }
//}
