//
//  TableViewDelegate.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit

extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.items.count > 0 else { return }
        MainCoordinator(navigationController).routeTo(target: .movieDetail(data: viewModel.items[indexPath.row]))
    }
}
