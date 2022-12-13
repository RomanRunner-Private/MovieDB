//
//  DetailsControllerCoordinator.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import Foundation
import UIKit

protocol DetailsControllerCoordinatorProtocol {
    func display(controller: DetailsViewController)
    func backAction()
}

class DetailsControllerCoordinator: BaseCoordinator, DetailsControllerCoordinatorProtocol {
    
    func display(controller: DetailsViewController) {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationItem.titleView?.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.foregroundColor : UIColor.white ]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
