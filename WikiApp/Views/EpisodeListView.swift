//
//  EpisodeListView.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import SwiftUI
import Combine
import RickMortySwiftApi

struct EpisodeListView: View {
    @EnvironmentObject var viewModel: MainViewModel
    
    @State private var isLinkActive: Bool = false
    @State private var isRefreshing = false
    @State private var selecteId: Int = -1
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        PullToRefreshView(isRefreshing: $isRefreshing, action: {
            viewModel.getFutureEpisodes()
                .sink(receiveValue: { _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            self.isRefreshing = false
                        }
                    }
                })
                .store(in: &subscriptions)
        }) {
            LazyVStack {
                ForEach(viewModel.episodes) { episode in
                    CardView(episode: episode)
                        .padding([.leading, .trailing], Constants.margin)
                        .onTapGesture {
                            selecteId = episode.id
                            isLinkActive = true
                        }
                }
            }
        }
        .background(navigationLink())
        .onAppear {
            if viewModel.episodes.count == 0 {
                viewModel.syncEpisodes()
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
    }
}

fileprivate struct CardView: View {
    let episode: RMEpisodeModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .continuous)
                .fill(.white)
                .shadow(radius: Constants.shadowRadius)
            
            VStack(alignment: .leading) {
                Text(episode.name)
                    .subtitleStyle()
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .padding([.bottom], Constants.textMargin)
                
                Text(episode.airDate)
                    .bodyStyle()
                    .padding([.bottom], Constants.textMargin)
                
                Text(episode.episode)
                    .bodyStyle()
                    .padding([.bottom], Constants.textMargin)
            }
            .padding()
        }
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 4
        static let textMargin: CGFloat = 2
    }
}

struct EpisodeListView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeListView()
            .environmentObject(AppComponent.shared.viewModel)
    }
}
