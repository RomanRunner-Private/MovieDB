//
//  OverviewTableViewCell.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with overview: String) {
        overviewLabel.text = overview
    }
}
