//
//  HomeView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 15/07/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Toolbar(selectedIndex: $selectedIndex)
                        
                        switch (selectedIndex) {
                        case 1:
                            EpisodeListView()
                        case 2:
                            LocationListView()
                        default:
                            CharacterListView()
                        }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                    }
                }
            }
            .navigationBarTitle("appName".localized, displayMode: .large)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
