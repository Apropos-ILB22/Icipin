//
//  OnboardingView.swift
//  Icipin
//
//  Created by Hisyam sanusi on 23/08/22.
//

import SwiftUI

struct OnboardingView: View {
    init() {
              UIPageControl.appearance().currentPageIndicatorTintColor = .systemTeal
              UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemTeal.withAlphaComponent(0.2)
           }
    
    @State var selectedItem = 0
    var body: some View {
        VStack {
            TabView(selection: $selectedItem){
                PageView(
                    title: "Pilih Quest",
                    subtitle: "Tentukan quest yang ingin kamu selesaikan",
                    imageName: "onboarding1")
                .tag(0)
                PageView(
                    title: "Ikuti Rute",
                    subtitle: "Menuju lokasi quest dengan mengikuti rute",
                    imageName: "onboarding2")
                .tag(1)
                PageView(
                    title: "Gunakan Scan",
                    subtitle: "Scan makanan atau minumanmu untuk mendapat jawaban dari quest yang kamu pilih",
                    imageName: "onboarding3")
                .tag(2)
            }
            .background(
                Image("bgonboarding")
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            if selectedItem == 2{
                Button(action: {
                    
                }, label: {
                    Text("Mulai Perjalanan")
                        .foregroundColor(.white)
                        .frame(width: 358, height: 58)
                        .background(Color("Color1"))
                        .cornerRadius(20)
                })
            }
        }
    }
}

struct PageView: View {
    let title: String
    let subtitle: String
    let imageName: String

    
    var body: some View {
        VStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 195, height: 246)
                .padding()
            Spacer()
                .frame(height: 135)
            Text(title)
                .fontWeight(.bold)
                .font(.largeTitle)
                .frame(width: 359, alignment: .leading)
            Spacer()
                .frame(height: 9)
            Text(subtitle)
                .font(.body)
                .foregroundColor(.black)
                .frame(width: 359, alignment: .leading)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
