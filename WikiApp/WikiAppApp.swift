//
//  WikiAppApp.swift
//  WikiApp
//
//  Created by Seongwuk Park on 15/07/22.
//

import SwiftUI

@main
struct WikiAppApp: App {
    @State private var isLoaded = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.background.edgesIgnoringSafeArea(.all)
                
                if !isLoaded {
                    SplashView(isLoaded: $isLoaded)
                } else {
                    HomeView()
                }
            }
            .environmentObject(AppComponent.shared.viewModel)
        }
    }
}
