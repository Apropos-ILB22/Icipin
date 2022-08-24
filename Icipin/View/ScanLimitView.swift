//
//  ScanLimitView.swift
//  Icipin
//
//  Created by Hisyam sanusi on 22/08/22.
//

import SwiftUI

struct ScanLimitView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            VStack{
                Image("scan")
                    .resizable()
                    .frame(width: 187, height: 159)
                    Spacer()
                    .frame(height: 222)
                Text("How to Scan the Food")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Text("First, position your food in the camera frame. Then move your iPhone camera forward around the food, then move iPhone camera left and right around the food ")
                    .frame(width: 270, height: 100)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ScanLimitView_Previews: PreviewProvider {
    static var previews: some View {
        ScanLimitView()
    }
}
