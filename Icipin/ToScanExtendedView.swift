//
//  ToScanExtendedView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 20/08/22.
//

import SwiftUI

struct ToScanExtendedView: View {
    
    @Binding var isShowing: Bool
    @State private var isDragging = false
    
    @State private var curHeight: CGFloat = 550
    let minHeight: CGFloat = 550
    let maxHeight: CGFloat = 700
    
    var body: some View {
        ZStack(alignment: .bottom){
            //            if isShowing {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isShowing = false
                }
            mainView
            //            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
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
                    .padding(.leading,20)
                }
                Button(action: {
                    //hide route clue
                    withAnimation {
                        isShowing = false
                    }
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
            }
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            VStack (alignment: .leading){
                Text("Petunjuk")
                    .fontWeight(.bold).font(.title2)
                    .padding(.leading,20)
                Text("Makanan Khas Jepang")
                    .font(.title3)
                    .padding(.leading,15)
                    .padding(5)
                //                    .padding(.leading,20)
                //                    .padding(.top,5)
                //                    .padding(.bottom,5)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Terbuat dari tepung dan gurita")
                    .font(.title3)
                    .padding(.leading,15)
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Bentuknya seperti bola pingpong, biasa di sajikan bersama mayonaise dan serbuk ikan")
                    .font(.title3)
                    .padding(.leading,15)
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Rasanya gurih dan agak manis dari mayonaise")
                    .font(.title3)
                    .padding(.leading,15)
                    .padding(5)
                    .fixedSize(horizontal: false, vertical: true)
            }
                        Spacer()
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("SCAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(20)
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("AKHIRI PERJALANAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(.red)
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
                    curHeight = curHeight
                    withAnimation {
                        isShowing = false
                    }
                }
            }
    }
    
}

struct ToScanExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        ToScanExtendedView(isShowing: .constant(true))
    }
}
