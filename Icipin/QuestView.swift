//
//  MainView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 19/08/22.
//

import SwiftUI

struct QuestView: View {
    
    @Binding var isShowing: Bool
    @State private var showClueModal = false
    
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
            if showClueModal{
                QuestExtendedView(isShowingClue: $showClueModal)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        //        .animation(Animation.easeInOut, value: 100)
        //        .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack{
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
                    //show clue
                    showClueModal = true
                    isShowing = false
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
            Button(action: {
                //quest
            }, label: {
                Text("Pilih Quest")
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
        .frame(height: 200, alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(.white)
        .transition(.move(edge: .bottom))
    }
}

struct QuestView_Previews: PreviewProvider {
    static var previews: some View {
        QuestView(isShowing: .constant(true))
    }
}
