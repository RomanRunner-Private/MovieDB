//
//  MovieListConfigurator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

protocol MovieListConfiguratorProtocol {
    
}

final class MovieListConfigurator: MovieListConfiguratorProtocol {
    // MARK: - coordinator is mandatory here so no any optionals for protocol!
    let coordinator: MovieListViewCoordinatorProtocol
    
    init(coordinator: MovieListViewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func assembleAndDisplay() {
        let urlBuilder = URLBuilder()
        let ImageProcessing = ImageProcessing()
        let service = NetworkService(urlBuilder: urlBuilder, imageProcessing: ImageProcessing)
        let viewModel: MovieListViewModel = .init(coordinator: coordinator, networkService: service)
        let storyboardName = "MovieListViewController"
        
        let controller = UIStoryboard(name: storyboardName,bundle: .main)
            .instantiateViewController(identifier: storyboardName,
                                       creator: { coder -> MovieListViewController? in
            MovieListViewController(coder: coder,
                                    viewModel: viewModel)
        })
        
        controller.modalPresentationStyle = .overFullScreen
        coordinator.display(controller: controller)
    }
}
