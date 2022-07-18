//
//  SplashView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 15/07/22.
//

import SwiftUI
import Combine

struct SplashView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @Binding var isLoaded: Bool
    
    @State private var opacity = 0.5
    @State private var scale = 0.8
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        ZStack {
            Color.splash.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image(name: .splash)
            }
            .opacity(opacity)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.easeIn(duration: 0.5)) {
                    self.opacity = 1.0
                    self.scale = 1.0
                }
            }
            
            if !self.isLoaded {
                VStack {
                    Spacer()
                    
                    ProgressView()
                        .padding()
                }
            }
        }
        .onAppear {
            viewModel.getFutureCharacters()
                .sink(receiveValue: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isLoaded = true
                        }
                    }
                })
                .store(in: &subscriptions)
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(isLoaded: .constant(true))
    }
}
