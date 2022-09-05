//
//  TableViewDataSource.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//
import UIKit

extension MovieListViewController: UITableViewDataSource {
    
    func checkLoadingCellDisplayNeeded() -> Bool {
        return (viewModel?.items.count ?? 0 < viewModel?.totalResults ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel?.items.count ?? 0
        } else if section == 1 && checkLoadingCellDisplayNeeded() {
            return 1
        } else {
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
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell",
                                                     for: indexPath) as! MovieTableViewCell
            if let viewModel = viewModel {
                cell.configure(with: viewModel.items[indexPath.row], viewModel: viewModel)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell",
                                                     for: indexPath) as! LoadingCell
            if let viewModel = viewModel {
                cell.setupCell(active: viewModel.items.count == viewModel.totalResults ? false : true)
            }
            return cell
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
