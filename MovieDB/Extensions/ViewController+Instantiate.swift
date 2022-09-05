//
//  ViewController+Instantiate.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

extension UIViewController {
    
    class func instantiate<T>(from storyboard: UIStoryboard?) -> T {
        let identifier = String(describing: T.self)
        return instantiate(from: storyboard, with: identifier)
    }
    
    class func instantiate<T>(from storyboard: UIStoryboard?, with identifier: String) -> T {
        // swiftlint:disable:next force_unwrapping
        let controller = storyboard!.instantiateViewController(withIdentifier: identifier)
        // swiftlint:disable:next force_cast
        return controller as! T
    }
    
    class func instantiate<T>() -> T {
        let identifier = String(describing: T.self)
        let storyboard = UIStoryboard(name: identifier, bundle: nil)
        return instantiate(from: storyboard)
    }
}
