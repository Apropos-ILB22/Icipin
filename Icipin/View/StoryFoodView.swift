//
//  StoryFoodView.swift
//  Icipin
//
//  Created by Hisyam sanusi on 24/08/22.
//
import Foundation
import SwiftUI

struct StoryFoodView: View {
    @Binding var currentQuest: Quest?
    @Binding var isShowing: Bool
    @State private var isDragging = false
    @State private var showQuestModal = false
    
    @State private var curHeight: CGFloat = 450
    let minHeight: CGFloat = 550
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                mainView
            }

        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
    }
    
    var mainView: some View {
        VStack(alignment: .leading){
            ZStack{
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(Color.white.opacity(0.00001))
            .gesture(dragGesture)
            .padding(.top,2)
            
            VStack{
                Text((currentQuest?.food_name?.uppercased())!)
                    .fontWeight(.bold).font(.title2)
                    .multilineTextAlignment(.center)
                    .frame(width: 358, alignment: .center)
                    
                Text((currentQuest?.story!)!)
                    .font(.body)
                    .padding(.leading,15)
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("LANJUT PETUALANGAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(Color("primary"))
                .cornerRadius(20)
                Spacer()
            }
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
                    curHeight = minHeight
                    withAnimation {
                        isShowing = false
                    }
                }
            }
    }
}

