//
//  MovieListConfigurator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import Foundation

protocol MovieListConfiguratorProtocol {
    
}

final class MovieListConfigurator: MovieListConfiguratorProtocol {
    // MARK: - coordinator is mandatory here so no any optionals for protocol!
    let coordinator: MovieListViewCoordinatorProtocol
    
    init(coordinator: MovieListViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func assembleAndDisplay() {
        let controller: MovieListViewController = .instantiate()
        controller.modalPresentationStyle = .overFullScreen
        let urlBuilder = URLBuilder()
        let ImageProcessing = ImageProcessing()
        let service = NetworkService(urlBuilder: urlBuilder, imageProcessing: ImageProcessing)
        controller.viewModel = .init(coordinator: coordinator, networkService: service)
        coordinator.display(controller: controller)
    }
}
