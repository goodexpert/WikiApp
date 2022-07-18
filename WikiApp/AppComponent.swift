//
//  AppComponent.swift
//  WikiApp
//
//  Created by Seongwuk Park on 18/07/22.
//

import Foundation

protocol AppComponentProtocol {
    var viewModel: MainViewModel { get }
}

final class AppComponent: AppComponentProtocol {
    static let shared: AppComponentProtocol = AppComponent()
    
    private lazy var mainViewModel: MainViewModel = {
        return MainViewModel()
    }()
    
    private init() { }
    
    var viewModel: MainViewModel {
        return mainViewModel
    }
}
