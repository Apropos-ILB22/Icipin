//
//  IcipinApp.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 15/08/22.
//

import SwiftUI

@main
struct IcipinApp: App {
    @StateObject private var mapQuestViewModel = MapQuestViewModel()
    
    var body: some Scene {
        WindowGroup {
//            OnboardingView()
            NavigationView{
                MapQuestView()
            }.onAppear{
                mapQuestViewModel.loadJSONData()
            }
        }
    }
}
