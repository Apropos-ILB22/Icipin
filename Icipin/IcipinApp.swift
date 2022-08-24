//
//  IcipinApp.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 15/08/22.
//

import SwiftUI

@main
struct IcipinApp: App {
    let userDefaults = UserDefaults.standard
    @State var isOnboardShowed: Bool
    
    init(){
        if (userDefaults.bool(forKey: "onboard") == true){
            isOnboardShowed = true
        }else{
            isOnboardShowed = false
        }
    }
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView{
                if isOnboardShowed {
                    MapQuestView()
                }else{
                    OnboardingView()
                }
            }
        }
    }
}
