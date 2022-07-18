//
//  CharacterListView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI
import Combine
import RickMortySwiftApi

struct CharacterListView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var isRefreshing = false
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        PullToRefreshView(isRefreshing: $isRefreshing, action: {
            viewModel.getFutureCharacters()
                .sink(receiveValue: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isRefreshing = false
                        }
                    }
                })
                .store(in: &subscriptions)
        }) {
            LazyVStack(spacing: Constants.margin) {
                ForEach(viewModel.characters) { character in
                    CardView(character: character)
                        .padding([.leading, .trailing], Constants.margin)
                }
            }
        }
        .onAppear {
            print("CharacterListView")
        }
    }
    
    private struct Constants {
        static let margin: CGFloat = 16
    }
}

fileprivate struct CardView: View {
    let character: RMCharacterModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(.white)
                .shadow(radius: Constants.shadowRadius)
            
            HStack {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .scaledToFill()
                                .onAppear {
                                    print(image)
                                }
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
                    .cornerRadius(Constants.cornerRadius)
                    .frame(width: Constants.size, height: Constants.size, alignment: .center)
                }
                
                VStack(alignment: .leading) {
                    Text(character.name)
                        .bodyStyle()
                        .padding([.bottom], Constants.textMargin)
                    
                    Text(character.gender)
                        .padding([.bottom], Constants.textMargin)
                        .bodyStyle()
                    
                    Text(character.status)
                        .bodyStyle()
                        .padding([.bottom], Constants.textMargin)
                    
                    Text(character.species)
                        .bodyStyle()
                        .padding([.bottom], Constants.textMargin)
                    
                    Text(character.type)
                        .bodyStyle()
                        .padding([.bottom], Constants.textMargin)
                }
            }
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 4
        static let size: CGFloat = 140
        static let textMargin: CGFloat = 2
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
            .environmentObject(AppComponent.shared.viewModel)
    }
}
