//
//  LoadingViewController.swift
//  MovieDB
//
//  Created by Roman Bigun on 05.09.2022.
//

import UIKit

class LoadingViewController: UIViewController {

    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
            
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        
        blurEffectView.autoresizingMask = [
            .flexibleWidth, .flexibleHeight
        ]
        
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }

}
