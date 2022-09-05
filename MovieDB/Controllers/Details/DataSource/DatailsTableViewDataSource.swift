//
//  DatailsTableViewDataSource.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import Foundation
import UIKit

extension DetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PosterTableViewCell",
                                                     for: indexPath) as! PosterTableViewCell
            if let viewModel = viewModel {
                cell.configure(viewModel: viewModel)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewTableViewCell",
                                                     for: indexPath) as! OverviewTableViewCell
            if let viewModel = viewModel {
                cell.configure(with: viewModel.overviewForMovie())
            }
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 502
        } else if indexPath.section == 1 {
            return 114
        }
        
        return 0
    }
}
