//
//  ContentView.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 15/08/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showWelcomeModal = false
    @State private var showQuestModal = false
    @State private var showToScanModal = false
    
    var body: some View {
        ZStack{
            VStack{
                Button{
                    showWelcomeModal = true
                } label: {
                    Text("Welcome")
                }
                .buttonStyle(.borderedProminent)
                Button{
                    showQuestModal = true
                } label: {
                    Text("Show Quest")
                }
                .buttonStyle(.borderedProminent)
                Button{
                    showToScanModal = true
                } label: {
                    Text("Show Journey")
                }
                .buttonStyle(.borderedProminent)
            }
            WelcomeView(isShowing: $showWelcomeModal)
            QuestView(isShowing: $showQuestModal)
            if showToScanModal{
                ToScanView(isShowing: $showToScanModal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
