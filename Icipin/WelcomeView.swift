//
//  WelcomeView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 20/08/22.
//

import SwiftUI

struct WelcomeView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom){
            if isShowing {
                //map view
                VStack(alignment: .leading){
                    Text("Hai, Pemburu Kuliner!").fontWeight(.bold).font(.title2)
                    Text("Banyak quest menarik menunggu kamu nih! Ayo mulai perjalananmu dengan menekan salah satu quest!").fontWeight(.medium).font(.title3)
                }
                .padding(.top,20)
                .frame(height: 200, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(.white)
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .onTapGesture {
            isShowing = false
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isShowing: .constant(true))
    }
}
