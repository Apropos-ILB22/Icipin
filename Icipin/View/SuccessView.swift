//
//  SuccessView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI

struct SuccessView: View {
    @Binding var currentQuest: Quest?
    @Binding var currentPlace: Place?
    @Binding var chosenQuestList : [Quest]
    @Binding var chosenPlaceList : [Place]
    @Binding var chosenRouteDistance: [Double]
    @Binding var chosenRouteDuration: [Double]
    @State var showNextQuest = false
    @State var animate = false
    @State var index: Int = 0
    @State var showStoryOfFood = false
    
    var body: some View {
        ZStack{
            VStack{
                
                Spacer()
                
                Text("Selamat! Kamu Berhasil membuka quest \((currentQuest?.title?.uppercased())!)")
                    .font(.title2).fontWeight(.semibold)
                    .foregroundColor(Color("textcolor"))
                    .multilineTextAlignment(.center)
                Spacer()
                Button(action:{
                    withAnimation{
                        self.showStoryOfFood = true
                    }
                }){
                    ZStack{
                        
                        Circle().fill(Color("casper").opacity(0.1)).frame(width: UIScreen.main.bounds.width * 0.4 + 250, height: UIScreen.main.bounds.width * 0.4 + 250)
                            .scaleEffect(self.animate ? 1 : 0)
                        
                        Circle().fill(Color("casper").opacity(0.7)).frame(width: UIScreen.main.bounds.width * 0.4 + 200, height: UIScreen.main.bounds.width * 0.4 + 200)
                            .scaleEffect(self.animate ? 1 : 0)
                        
                        Circle().fill(Color("geyser")).frame(width: UIScreen.main.bounds.width * 0.4 + 150, height: UIScreen.main.bounds.width * 0.4 + 150)
                            .scaleEffect(self.animate ? 1 : 0)
                        
                        Circle().fill(Color("seashell")).frame(width: UIScreen.main.bounds.width * 0.4 + 100, height: UIScreen.main.bounds.width * 0.4 + 100)
                            .scaleEffect(self.animate ? 1 : 0)
                        
                        Image((currentQuest?.food_img!)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.3)
                            .padding(UIScreen.main.bounds.width * 0.1)
                            .background(Circle().foregroundColor(.white))
                    }.onAppear{
                        withAnimation(.linear(duration: 0.7).repeatForever(autoreverses: true)){
                            self.animate.toggle()
                        }
                    }
                }
                

                Text((currentQuest?.food_name!)!)
                    .font(.title).bold()
                    .foregroundColor(Color("textcolor"))
                
                Text("Tekan gambar untuk melihat informasi \n menarik tentang \((currentQuest?.food_name?.uppercased())!)")
                    .font(.body)
                    .foregroundColor(Color("textcolor"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                
                Spacer()
                
                Button(action: {
        
                }){
                    Text("LANJUT PETUALANGAN")
                        .font(.body).bold()
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 58)
                        .background(Color("primary"))
                        .cornerRadius(18)
                }
            }
            if showStoryOfFood {
                StoryFoodView(isShowing: self.$showStoryOfFood)
            }
        }
    }
}
