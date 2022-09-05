//
//  BaseCoordinator.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

enum NavigateType {
    case push
    case set
}

class BaseCoordinator {
    
    let navigationController: UINavigationController?
    
    init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func push(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
    func popViewController(animated: Bool, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func dismiss(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        viewController.dismiss(animated: animated, completion: completion)
    }
    
    func popToRoot(animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popToRootViewController(animated: animated)
        CATransaction.commit()
    }
    
    func pop(to viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        navigationController?.popToViewController(viewController, animated: animated)
        CATransaction.commit()
    }
    
}
