//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by Roman Bigun on 03.09.2022.
//

import UIKit

final class MovieListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let viewModel: MovieListViewModel
    
    private var loadingVC: LoadingViewController?
   
    private let refreshControl = UIRefreshControl()
    
    init?(coder: NSCoder, viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to initialize an `MovieListViewController` instance.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupTable()
        setupRefresh()
        registerCells()
        displayLoadingController(present: true, showHint: false)
    }
    
    private func setupRefresh() {
        refreshControl.tintColor = .red
        refreshControl.attributedTitle = NSAttributedString(AttributedString("Loading..."))
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        refreshControl.beginRefreshing()
        loadData()
    }
    
   private func loadData() {
        viewModel.getMoviesFromLocalStorage(completion: { [weak self] result in
            guard let self = self else { return }
            self.handleResponce(isSuccess: result)
        })
    }
    
    private func displayHint() {
        viewModel.displayAlert()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func registerCells() {
        tableView.registerNib(MovieTableViewCell.self)
        tableView.registerNib(LoadingCell.self)
        tableView.registerNib(EmptyTableViewCell.self)
    }
    
    private func handleResponce(isSuccess: Bool) {
        if isSuccess == true {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.displayLoadingController(present: false, showHint: false)
            }
        } else {
            self.viewModel.getMovies(completion: { [weak self] result in
                guard let self = self else { return }
                if result == true {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.refreshControl.endRefreshing()
                        self.displayLoadingController(present: false, showHint: false)
                    }
                } else {
                    self.displayLoadingController(present: false, showHint: true)
                }
            })
        }
    }
}

extension MovieListViewController {
    private func displayLoadingController(present: Bool, showHint: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if present {
                self.loadingVC = LoadingViewController()
            } else {
                self.loadingVC?.dismiss(animated: true, completion: {
                    if showHint {
                        self.displayHint()
                    }
                })
                return
            }
            
            if let loadingController = self.loadingVC {
                loadingController.modalPresentationStyle = .overCurrentContext
                loadingController.modalTransitionStyle = .crossDissolve
                self.present(loadingController, animated: true)
            }
        }
    }
}
