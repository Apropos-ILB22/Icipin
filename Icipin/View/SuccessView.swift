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
                
                Circle().fill(Color.gray.opacity(0.45)).frame(width: UIScreen.main.bounds.width * 0.5 + 250, height: UIScreen.main.bounds.width * 0.5 + 250)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Circle().fill(Color.gray.opacity(0.35)).frame(width: UIScreen.main.bounds.width * 0.5 + 200, height: UIScreen.main.bounds.width * 0.5 + 200)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Circle().fill(Color.gray.opacity(0.25)).frame(width: UIScreen.main.bounds.width * 0.5 + 150, height: UIScreen.main.bounds.width * 0.5 + 150)
                    .scaleEffect(self.animate ? 1 : 0)
                
                Image("sandwich")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.3)
                    .padding(UIScreen.main.bounds.width * 0.1)
                    .background(Circle().foregroundColor(.white))
            }.onAppear{
                withAnimation(.linear(duration: 1).repeatForever(autoreverses: true)){
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
