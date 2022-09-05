//
//  MainCoordinator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import Foundation
import UIKit


enum AppRoute {
    case mainList
    case movieDetail(data: Result)
}

extension MainCoordinator {
    func routeTo(target: AppRoute) {
        switch target {
        case .mainList:
            navigateToMainList()
        case .movieDetail(let data):
            navigateToDetails(data: data)
        }
    }
}

class MainCoordinator: BaseCoordinator {
    // MARK: - Configurators
   private func navigateToMainList() {
       let coordinator = MovieListViewCoordinator(navigationController)
       MovieListConfigurator(coordinator: coordinator).assembleAndDisplay()
    }
    
    private func navigateToDetails(data: Result) {
        let coordinator = DetailsControllerCoordinator(navigationController)
        DetailsControllerConfigurator(coordinator: coordinator).assembleAndDisplay(data: data)
     }
}
