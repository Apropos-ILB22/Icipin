//
//  QuestExtendedView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 22/08/22.
//

import Foundation
import SwiftUI

struct QuestClueModalView: View {
    
    @Binding var isShowingClue: Bool
    @State private var isDragging = false
    @State private var showQuestModal = false
    @Binding var currentQuest: Quest?
    @Binding var currentPlace: Place?
    @Binding var metricDistance: Double?
    @Binding var metricDuration: Double?
    
    @State private var curHeight: CGFloat = 550
    let minHeight: CGFloat = 550
    let maxHeight: CGFloat = 700

    var body: some View {
        ZStack(alignment: .bottom){
            if isShowingClue {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingClue = false
                    }
                if(currentQuest != nil){
                    mainView
                }
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
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        Image("test_bolagurita")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .padding(.leading,30)
                        VStack(alignment: .leading) {
                            Text((currentQuest?.title)!).fontWeight(.bold).font(.title2)
                            Text("Cemilan").fontWeight(.medium).font(.title3)
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
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //hide clue
//                    withAnimation {
//                        isShowingClue = false
////                        showQuestModal = true
//                    }
                    
                    withAnimation(.easeOut, {
                        isShowingClue = false
                        
                    })
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("primary"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            VStack (alignment: .leading){
                Text("Petunjuk")
                    .fontWeight(.bold).font(.title2)
                    .padding(.leading,20)
                
                ForEach(self.currentQuest?.clues?.allObjects as! [Clue], id: \.id){ clue in
                    Text(clue.title!)
                        .font(.title3)
                        .padding(.leading,15)
                        .padding(5)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("PILIH QUEST")
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
                        isShowingClue = false
                    }
                }
            }
    }
}

//struct QuestExtendedView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestClueModalView(isShowingClue: .constant(true))
//    }
//}
