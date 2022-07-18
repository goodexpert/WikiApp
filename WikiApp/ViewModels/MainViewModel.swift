//
//  MainViewModel.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import Foundation
import Combine
import RickMortySwiftApi

class MainViewModel: ObservableObject {
    @Published var characters: [RMCharacterModel] = []
    @Published var episodes: [RMEpisodeModel] = []
    @Published var locations: [RMLocationModel] = []
    @Published var isLoading: Bool = false
    
    private let rmClient = RMClient()
    private var subscriptions = Set<AnyCancellable>()
    
    func getFutureCharacters() -> Future<Void, Never> {
        Future { promise in
            var temp: [RMCharacterModel] = []
            self.isLoading = true
            
            self.rmClient.character()
                .getAllCharacters()
                .timeout(.seconds(3), scheduler: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.characters = temp
                    self?.isLoading = false
                    promise(.success(()))
                }, receiveValue: { characters in
                    temp.append(contentsOf: characters)
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getFutureEpisodes() -> Future<Void, Never> {
        Future { promise in
            var temp: [RMEpisodeModel] = []
            self.isLoading = true
            
            self.rmClient.episode()
                .getAllEpisodes()
                .timeout(.seconds(3), scheduler: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.episodes = temp
                    self?.isLoading = false
                    promise(.success(()))
                }, receiveValue: { episodes in
                    temp.append(contentsOf: episodes)
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func getFutureLocations() -> Future<Void, Never> {
        Future { promise in
            var temp: [RMLocationModel] = []
            self.isLoading = true
            
            self.rmClient.location()
                .getAllLocations()
                .timeout(.seconds(3), scheduler: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] _ in
                    self?.locations = temp
                    self?.isLoading = false
                    promise(.success(()))
                }, receiveValue: { locations in
                    temp.append(contentsOf: locations)
                })
                .store(in: &self.subscriptions)
        }
    }
    
    func syncCharacters() {
        var temp: [RMCharacterModel] = []
        self.isLoading = true
        
        rmClient.character()
            .getAllCharacters()
            .sink(receiveCompletion: { [weak self] _ in
                self?.characters = temp
                self?.isLoading = false
            }, receiveValue: { characters in
                temp.append(contentsOf: characters)
            })
            .store(in: &subscriptions)
    }
    
    func syncEpisodes() {
        var temp: [RMEpisodeModel] = []
        self.isLoading = true
        
        rmClient.episode()
            .getAllEpisodes()
            .sink(receiveCompletion: { [weak self] _ in
                self?.episodes = temp
                self?.isLoading = false
            }, receiveValue: { episodes in
                temp.append(contentsOf: episodes)
            })
            .store(in: &subscriptions)
    }
    
    func syncLocation() {
        var temp: [RMLocationModel] = []
        self.isLoading = true
        
        rmClient.location()
            .getAllLocations()
            .sink(receiveCompletion: { [weak self] _ in
                self?.locations = temp
                self?.isLoading = false
            }, receiveValue: { locations in
                temp.append(contentsOf: locations)
            })
            .store(in: &subscriptions)
    }
}
