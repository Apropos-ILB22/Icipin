//
//  StartJourneyModalView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 23/08/22.
//

import Foundation

//
//  ToScanView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 22/08/22.
//

import SwiftUI
import MapKit

struct StartJourneyModalView: View {
    
    @Binding var chosenQuestList : [Quest]
    @Binding var chosenPlaceList : [Place]
    @Binding var chosenRouteDistance: [Double]
    @Binding var chosenRouteDuration: [Double]
    @Binding var currentQuest: Quest?
    @Binding var currentPlace: Place?
    @Binding var currentUserLocation: CLLocationCoordinate2D?
    @Binding var metricDistance: Double?
    @Binding var metricDuration: Double?
    @Binding var showToScan: Bool
    @Binding var isShowing: Bool
    @State private var isDragging = false
    
    
    @State private var curHeight: CGFloat = 250
    let minHeight: CGFloat = 250
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            mainView
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
        if(showToScan){
//            ToScanView(isShowing: self.$showToScan)
            
            ToScanView(chosenQuestList: self.$chosenQuestList, chosenPlaceList: self.$chosenPlaceList, chosenRouteDistance: self.$chosenRouteDistance,chosenRouteDuration: self.$chosenRouteDuration, currentQuest: self.$currentQuest, currentPlace: self.$currentPlace, currentUserLocation: self.$currentUserLocation, metricDistance: self.$metricDistance, metricDuration: self.$metricDuration, isShowing: self.$showToScan)
        }
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
            Text("Yeay, rutemu berhasil dibuat, kamu bisa menambah quest dengan menekan quest lainnya loh!")
                .font(.title3).fontWeight(.semibold)
                .padding(10)
            Spacer()
            Button(action: {
                
                withAnimation{
                    self.showToScan = true
//                    self.isShowing = false
                }
                
            }, label: {
                Text("MULAI PETUALANGAN")
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


