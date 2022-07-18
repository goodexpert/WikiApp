//
//  EpisodeDetailsView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI
import Combine
import RickMortySwiftApi

struct EpisodeDetailsView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var isLinkActive: Bool = false
    @State private var selecteId: Int = -1
    @State private var subscriptions = Set<AnyCancellable>()
    
    var episodeId: Int
    
    private var episode: RMEpisodeModel {
        return viewModel.episodes.first(where: { $0.id == episodeId }) ?? viewModel.episodes[0]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text(String(format: "labelAirDate".localized, episode.airDate))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(String(format: "labelEpisode".localized, episode.episode))
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
                            ForEach(episode.characters, id: \.self) { character in
                                let temp = character.split(separator: "/")
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
            .navigationBarTitle(episode.name, displayMode: .large)
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

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(episodeId: 1)
    }
}
