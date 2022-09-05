//
//  DetailsControllerConfigurator.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import Foundation

class DetailsControllerConfigurator {
    private let coordinator: DetailsControllerCoordinatorProtocol
    
    init(coordinator: DetailsControllerCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func assembleAndDisplay(data: Result) {
        let controller: DetailsViewController = .instantiate()
        let urlBuilder = URLBuilder()
        let ImageProcessing = ImageProcessing()
        let service = NetworkService(urlBuilder: urlBuilder,
                                     ImageProcessing: ImageProcessing)
        controller.viewModel = .init(coordinator: coordinator,
                                     networkService: service,
                                     data: data)
        coordinator.display(controller: controller)
    }
}
