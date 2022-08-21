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
            
            Text("Selamat! Kamu Berhasil membuka quest Bola Gurita")
                .font(.title2).bold()
            Image("sandwich")
            
            Spacer()
            
            Text("TAKOYAKI")
            
            Text("Tekan gambar untuk melihat informasi \n menarik tentang Takoyaki")
            
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
