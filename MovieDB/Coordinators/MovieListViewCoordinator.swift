//
//  MovieListViewCoordinator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

protocol MovieListViewCoordinatorProtocol {
    func display(controller: MovieListViewController)
}

final class MovieListViewCoordinator: BaseCoordinator, MovieListViewCoordinatorProtocol {
    
    func display(controller: MovieListViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
