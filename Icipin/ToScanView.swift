//
//  ToScanView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 20/08/22.
//

import SwiftUI

struct ToScanView: View {
    
    @Binding var isShowing: Bool
    @State private var showToScanExtendedModal = false
    @State private var isDragging = false
    
    @State private var curHeight: CGFloat = 250
    let minHeight: CGFloat = 250
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing = false
                }
            mainView
            if showToScanExtendedModal{
                ToScanExtendedView(isShowing: $showToScanExtendedModal)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        //        .animation(Animation.easeInOut, value: 100)
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
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text("10 mnt").fontWeight(.bold).font(.title).foregroundColor(.blue)
                                Text("(2.5 km)").fontWeight(.medium).font(.title3)
                            }
                            Text("menuju BOLA GURITA").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //show clue
                    withAnimation {
                        showToScanExtendedModal = true
                    }
                }, label: {
                    Image(systemName: "key")
                        .font(.title2)
                })
                .padding(15)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Spacer()
            Button(action: {
                //quest
            }, label: {
                Text("PILIH QUEST")
                    .font(.body)
                    .bold()
            })
            .frame(width: UIScreen .main.bounds.width-20, height: 58, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .background(Color("PrimaryColor"))
            .cornerRadius(20)
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


struct ToScanView_Previews: PreviewProvider {
    static var previews: some View {
        ToScanView(isShowing: .constant(true))
    }
}
