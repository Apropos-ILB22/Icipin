//
//  ToScanExtendedView.swift
//  Icipin
//
//  Created by Ditha Nurcahya Avianty on 20/08/22.
//

import SwiftUI

struct ToScanExtendedView: View {
    
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom){
//            if isShowing {
                mainView
//            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
        
    }
    
    var mainView: some View {
        VStack(alignment: .leading){
            HStack {
                VStack (alignment: .leading){
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text("10 mnt").fontWeight(.bold).font(.title).foregroundColor(.blue)
                                Text("(2.5 km)").fontWeight(.medium).font(.title3)
                            }
                            .padding(.bottom,2)
                            Text("menuju BOLA GURITA").fontWeight(.medium).font(.title3)
                        }
                        Spacer()
                    }
                    .padding(.leading,30)
                }
                Button(action: {
                    //hide route clue
                }, label: {
                    Image(systemName: "chevron.down")
                        .font(Font.system(size: 33, weight: .bold))
                })
                .foregroundColor(Color("PrimaryColor"))
                .cornerRadius(11)
                .padding(.trailing,20)
                
            }
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            VStack (alignment: .leading){
                Text("Petunjuk")
                    .fontWeight(.bold).font(.title2)
                    .padding(.leading,30)
                Text("Makanan Khas Jepang")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Terbuat dari tepung dan gurita")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                Text("Bentuknya seperti bola pingpong, biasa di sajikan bersama mayonaise dan serbuk ikan")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
                    .lineLimit(nil)
                Text("Rasanya gurih dan agak manis dari mayonaise")
                    .font(.title3)
                    .padding(.leading,30)
                    .padding(.top,5)
                    .padding(.bottom,5)
            }
            .padding(.bottom,30)
            Divider().frame(maxWidth:UIScreen.main.bounds.width-20, maxHeight:10)
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("SCAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(Color("PrimaryColor"))
                .cornerRadius(20)
                Spacer()
            }
            HStack{
                Spacer()
                Button(action: {
                    //quest
                }, label: {
                    Text("AKHIRI PERJALANAN")
                        .font(.body)
                        .bold()
                })
                .frame(width: UIScreen.main.bounds.width-20, height: 58, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .background(.red)
                .cornerRadius(20)
                Spacer()
            }
        }
        .padding(.bottom,25)
        .frame(height: 550,alignment: .bottom)
        .frame(maxWidth: .infinity)
        .background(.white)
        .transition(.move(edge: .bottom))
    }

}

struct ToScanExtendedView_Previews: PreviewProvider {
    static var previews: some View {
        ToScanExtendedView(isShowing: .constant(true))
    }
}
