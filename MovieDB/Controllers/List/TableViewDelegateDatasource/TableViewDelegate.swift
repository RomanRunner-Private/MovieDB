//
//  TableViewDelegate.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        MainCoordinator(navigationController).routeTo(target: .movieDetail(data: viewModel.items[indexPath.row]))
    }
}
