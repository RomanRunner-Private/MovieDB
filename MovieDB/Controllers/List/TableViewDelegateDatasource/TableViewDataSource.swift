//
//  TableViewDataSource.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//
import UIKit

fileprivate enum DetailsTableSections: Int {
    case poster = 0
    case loading
}

extension MovieListViewController: UITableViewDataSource {
    
    func loadingCellDisplayNeeded() -> Bool {
        return (viewModel?.items.count ?? 0 < viewModel?.totalResults ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionName = DetailsTableSections(rawValue: section)
        switch sectionName {
        case .poster:
            return viewModel?.items.count ?? 0
        case .loading:
            if loadingCellDisplayNeeded() {
                return 1
            }
            return 0
        default:
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 520
        }
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionName = DetailsTableSections(rawValue: indexPath.section)
        switch sectionName {
        case .poster:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell",
                                                     for: indexPath) as! MovieTableViewCell
            if let viewModel = viewModel {
                cell.configure(with: viewModel.items[indexPath.row], viewModel: viewModel)
            }
            return cell
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell",
                                                     for: indexPath) as! LoadingCell
            if let viewModel = viewModel {
                cell.setupCell(active: viewModel.items.count == viewModel.totalResults ? false : true)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let viewModel = self.viewModel {
            if indexPath.row == viewModel.items.count - 5 {
                viewModel.loadMore(completion: { loaded in
                    if loaded {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                })
            }
        }
    }
}
