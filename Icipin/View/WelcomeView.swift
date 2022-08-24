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
                Color.black
                    .opacity(0.7) //mark todo change background
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                VStack(alignment: .leading){
                    Text("Hai, Pemburu Kuliner!").fontWeight(.bold).font(.title2).padding(.bottom,5)
                    Text("Banyak quest menarik menunggu kamu nih! Ayo mulai perjalananmu dengan menekan salah satu quest!").fontWeight(.medium).font(.title3)
                    Spacer()
                }
                .padding()
                .padding(.top,20)
                .frame(height: 250, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack{
                        RoundedRectangle(cornerRadius: 30)
                        Rectangle()
                            .frame(height: 250/2)
                    }
                        .foregroundColor(.white)
                )
                .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation{
                isShowing = false
            }
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isShowing: .constant(true))
    }
}
