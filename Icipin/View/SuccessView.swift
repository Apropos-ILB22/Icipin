//
//  SuccessView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI

struct SuccessView: View {
    @State var animate = false
    
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Selamat! Kamu Berhasil membuka quest BOLA GURITA")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(Color("textcolor"))
                .multilineTextAlignment(.center)
            Spacer()
            ZStack{
                
                Circle().fill(Color("casper").opacity(0.1)).frame(width: UIScreen.main.bounds.width * 0.4 + 250, height: UIScreen.main.bounds.width * 0.4 + 250)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Circle().fill(Color("casper").opacity(0.7)).frame(width: UIScreen.main.bounds.width * 0.4 + 200, height: UIScreen.main.bounds.width * 0.4 + 200)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Circle().fill(Color("geyser")).frame(width: UIScreen.main.bounds.width * 0.4 + 150, height: UIScreen.main.bounds.width * 0.4 + 150)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Circle().fill(Color("seashell")).frame(width: UIScreen.main.bounds.width * 0.4 + 100, height: UIScreen.main.bounds.width * 0.4 + 100)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Image("sandwich")
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
            

            Text("TAKOYAKI")
                .font(.title).bold()
                .foregroundColor(Color("textcolor"))
            
            Text("Tekan gambar untuk melihat informasi \n menarik tentang Takoyaki")
                .font(.body)
                .foregroundColor(Color("textcolor"))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Spacer()
            
            Button(action: {}){
                Text("Lanjut Petualangan")
                    .font(.body).bold()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 58)
                    .background(Color("primary"))
                    .cornerRadius(18)
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView()
    }
}