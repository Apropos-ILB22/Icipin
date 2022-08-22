//
//  QuestExtendedView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 22/08/22.
//

import Foundation
import SwiftUI

struct QuestExtendedView: View {
    
    @Binding var isShowingClue: Bool
    @State private var showQuestModal = false
    
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowingClue {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingClue = false
                    }
                mainView
            }
            if showQuestModal {
                QuestView(isShowing: $showQuestModal)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
    }
    
    var mainView: some View {
        VStack{
//            Spacer()
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        Image("test_bolagurita")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .padding(.leading,30)
                        VStack(alignment: .leading) {
                            Text("Bola Gurita").fontWeight(.bold).font(.title2)
                            Text("Cemilan").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.red)
                        Text("2.5 km").fontWeight(.medium).font(.body)
                        Image(systemName: "clock")
                            .foregroundColor(.blue)
                        Text("15 mnt").fontWeight(.medium).font(.body)
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("4(5)").fontWeight(.medium).font(.body)
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //hide clue
                    isShowingClue = false
                    showQuestModal = true
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
            }
            .padding(.top,20)
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
                    Text("Pilih Quest")
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
        }
        .padding(.bottom,25)
        .frame(height: 550,alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(.white)
        .transition(.move(edge: .bottom))
    }
}

struct QuestExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        QuestExtendedView(isShowingClue: .constant(true))
    }
}
