//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: MovieListViewModel?
    
    var loadingVC: LoadingViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        registerCells()
        displayLoadingController(present: true)
        loadData()
    }
    
   private func loadData() {
        viewModel?.getMoviesFromLocalStorage(completion: { [weak self] result in
            guard let self = self else { return }
            if result == true {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.displayLoadingController(present: false)
                }
            } else {
                self.viewModel?.getMovies(completion: { [weak self] result in
                    guard let self = self else { return }
                    if result == true {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.displayLoadingController(present: false)
                        }
                    }
                })
            }
        })
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.registerNib(MovieTableViewCell.self)
        tableView.registerNib(LoadingCell.self)
    }
    
    private func displayLoadingController(present: Bool) {
        if present {
            loadingVC = LoadingViewController()
        } else {
            loadingVC?.dismiss(animated: true)
            return
        }
        
        if let loadingController = loadingVC {
            loadingController.modalPresentationStyle = .overCurrentContext
            loadingController.modalTransitionStyle = .crossDissolve
            self.present(loadingController, animated: true)
        }
    }
}
