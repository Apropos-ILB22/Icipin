//
//  SuccessView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Selamat! Kamu Berhasil membuka quest BOLA GURITA")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(Color("textcolor"))
                .multilineTextAlignment(.center)
            Spacer()
            Image("sandwich")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3)
            

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
