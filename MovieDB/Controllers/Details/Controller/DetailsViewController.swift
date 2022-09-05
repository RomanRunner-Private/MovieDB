//
//  DetailsViewController.swift
//  MovieDB
//
//  Created by Roman Bigun on 04.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setupTable()
        registerCells()
        setNavigationBarHidden(hidden: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setNavigationBarHidden(hidden: true)
    }
    
    private func setNavigation() {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = viewModel?.navigationViewTitle()
        self.navigationItem.title =  label.text
    }
    
    private func setupTable() {
        tableView.dataSource = self
    }
    
    private func setNavigationBarHidden(hidden: Bool) {
        self.navigationController?.navigationBar.isHidden = hidden
    }
    
    private func registerCells() {
        tableView.registerNib(PosterTableViewCell.self)
        tableView.registerNib(OverviewTableViewCell.self)
    }
}
