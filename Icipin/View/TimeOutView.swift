//
//  TimeOutView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 21/08/22.
//

import SwiftUI

struct TimeOutView: View {
    var body: some View {
        VStack{
            
            Spacer()
            
            Text("Yahh, maaf waktu scanmu \n sudah habis")
                .font(.title2).fontWeight(.semibold)
                .foregroundColor(Color("textcolor"))
                .multilineTextAlignment(.center)
            
            Text("Tapi tenang aja, kamu masih bisa scan \n ulang kok!")
                .font(.body)
                .foregroundColor(Color("textcolor"))
                .multilineTextAlignment(.center)
                .padding(.top, 20)
            
            Spacer()
            
            Image("fail")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3)
                .padding(UIScreen.main.bounds.width * 0.1)
                .background(Circle().foregroundColor(.white))
            
            Spacer()
            
            Button(action: {}){
                Text("COBA SCAN ULANG")
                    .font(.body).bold()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 58)
                    .background(Color("primary"))
                    .cornerRadius(18)
            }

            Button(action: {}){
                Text("LEWATI QUEST")
                    .font(.body).bold()
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 58)
                    .background(Color("casper"))
                    .cornerRadius(18)
            }.padding(.top, 5)

        }
    }
}

struct TimeOutView_Previews: PreviewProvider {
    static var previews: some View {
        TimeOutView()
    }
}
