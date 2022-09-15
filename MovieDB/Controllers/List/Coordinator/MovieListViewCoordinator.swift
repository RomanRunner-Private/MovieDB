//
//  MovieListViewCoordinator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

protocol MovieListViewCoordinatorProtocol {
    func display(controller: MovieListViewController)
    func displayAlert()
}

final class MovieListViewCoordinator: BaseCoordinator, MovieListViewCoordinatorProtocol {
    
    func display(controller: MovieListViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func displayAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alert = UIAlertController(title: "Loading error!",
                                          message: "Try pull to refresh data!",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.navigationController?.present(alert, animated: true)
        }
    }
}
