//
//  LocationDetailsView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI
import Combine
import RickMortySwiftApi

struct LocationDetailsView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var isLinkActive: Bool = false
    @State private var selecteId: Int = -1
    @State private var subscriptions = Set<AnyCancellable>()
    
    private var location: RMLocationModel {
        return viewModel.locations.first(where: { $0.id == locationId }) ?? viewModel.locations[0]
    }
    
    var locationId: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text(String(format: "labelType".localized, location.type))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(location.dimension)
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Divider()
                            .padding()
                        
                        Text("characters".localized)
                            .subtitleStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Divider()
                            .padding()
                        
                        LazyVStack {
                            ForEach(location.residents, id: \.self) { resident in
                                let temp = resident.split(separator: "/")
                                let characterId = Int(temp[temp.count - 1]) ?? 1
                                
                                Button(action: {
                                    withAnimation {
                                        self.selecteId = characterId
                                        self.isLinkActive = true
                                    }
                                }) {
                                    Text(String(format: "linkCharacter".localized, characterId))
                                        .linkStyle()
                                        .padding([.leading, .trailing])
                                        .padding([.bottom], Constants.textMargin)
                                        .frame(width: geometry.size.width, alignment: .leading)
                                }
                            }
                        }
                    }
                }
            }
            .background(navigationLink())
            .navigationBarTitle(location.name, displayMode: .large)
        }
    }
    
    private func navigationLink() -> some View {
        NavigationLink(destination: CharacterDetailsView(characterId: selecteId), isActive: $isLinkActive) {
            EmptyView()
        }
        .hidden()
    }
    
    private struct Constants {
        static let margin: CGFloat = 16
        static let textMargin: CGFloat = 2
    }
}

struct LocationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetailsView(locationId: 1)
    }
}
