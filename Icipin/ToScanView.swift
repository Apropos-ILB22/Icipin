//
//  ToScanView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 20/08/22.
//

import SwiftUI

struct ToScanView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom){
            mainView
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
                        VStack(alignment: .leading) {
                            HStack{
                                Text("10 mnt").fontWeight(.bold).font(.title).foregroundColor(.blue)
                                Text("(2.5 km)").fontWeight(.medium).font(.title3)
                            }
                            Text("menuju BOLA GURITA").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //show clue
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
        .frame(height: 100, alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(.white)
        .transition(.move(edge: .bottom))
    }
}


struct ToScanView_Previews: PreviewProvider {
    static var previews: some View {
        ToScanView(isShowing: .constant(true))
    }
}
