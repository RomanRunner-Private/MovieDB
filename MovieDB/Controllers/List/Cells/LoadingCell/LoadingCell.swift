//
//  LoadingCell.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.clear
        activityIndicator.color = UIColor.systemRed
    }
    
    func setupCell(active: Bool) {
        switch active {
        case true:
            stackView.isHidden = false
            activityIndicator.startAnimating()
        default:
            activityIndicator.stopAnimating()
            stackView.isHidden = true
        }
    }
}
