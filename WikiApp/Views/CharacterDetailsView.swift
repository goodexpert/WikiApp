//
//  CharacterDetailsView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI
import Combine
import RickMortySwiftApi

struct CharacterDetailsView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var isLoading: Bool = false
    @State private var isLinkActive: Bool = false
    @State private var selecteId: Int = -1
    @State private var subscriptions = Set<AnyCancellable>()
    
    var characterId: Int
    
    private var character: RMCharacterModel {
        return viewModel.characters.first(where: { $0.id == characterId }) ?? viewModel.characters[0]
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        AsyncImage(url: URL(string: character.image)) { phase in
                            switch phase {
                            case .success(let image):
                                image.resizable()
                                    .scaledToFit()
                            case .empty:
                                ProgressView()
                            case .failure(_):
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(height: geometry.size.width)
                        .padding([.leading, .trailing])
                        
                        Text(String(format: "labelName".localized, character.name))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(String(format: "labelGender".localized, character.gender))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(String(format: "labelSpecies".localized, character.species))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(String(format: "labelStatus".localized, character.status))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Text(String(format: "labelType".localized, character.type))
                            .labelStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Divider()
                            .padding()
                        
                        Text("episodes".localized)
                            .subtitleStyle()
                            .padding([.leading, .trailing])
                            .padding([.bottom], Constants.textMargin)
                            .frame(width: geometry.size.width, alignment: .leading)
                        
                        Divider()
                            .padding()
                        
                        LazyVStack {
                            ForEach(character.episode, id: \.self) { episode in
                                let temp = episode.split(separator: "/")
                                let episodeId = Int(temp[temp.count - 1]) ?? 1
                                
                                Button(action: {
                                    if viewModel.episodes.count == 0 {
                                        withAnimation {
                                            isLoading = true
                                        }
                                        viewModel.getFutureEpisodes()
                                            .sink(receiveValue: { _ in
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                                    if viewModel.episodes.count > 0 {
                                                        withAnimation {
                                                            self.selecteId = episodeId
                                                            self.isLinkActive = true
                                                        }
                                                    }
                                                    withAnimation {
                                                        isLoading = false
                                                    }
                                                }
                                            })
                                            .store(in: &subscriptions)
                                    } else {
                                        withAnimation {
                                            self.selecteId = episodeId
                                            self.isLinkActive = true
                                        }
                                    }
                                }) {
                                    Text(String(format: "linkEpisode".localized, episodeId))
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
            .navigationBarTitle(character.name, displayMode: .large)
            .overlay(alignment: .center) {
                if isLoading {
                    ProgressView(style: .large)
                }
            }
        }
    }
    
    private func navigationLink() -> some View {
        NavigationLink(destination: EpisodeDetailsView(episodeId: selecteId), isActive: $isLinkActive) {
            EmptyView()
        }
        .hidden()
    }
    
    private struct Constants {
        static let margin: CGFloat = 16
        static let textMargin: CGFloat = 2
    }
}

struct CharacterDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailsView(characterId: 1)
    }
}
