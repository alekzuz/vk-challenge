//
//  FeedViewController.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedDisplayLogic: class {
    func displayViewModel(_ viewModel: Feed.ViewModel)
}

final class FeedViewController: UIViewController, FeedDisplayLogic, UITableViewDelegate, UITableViewDataSource {
    private var interactor: FeedBusinessLogic!
    private var viewModel = Feed.ViewModel.init(cells: [])
    
    @IBOutlet private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assemble()
        table.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: FeedCell.reuseId)
        
        interactor.getFeed()
    }
    
    private func assemble() {
        let presenter = FeedPresenter(viewController: self)
        let authService = AppDelegate.shared().authService!
        let networkService = NetworkService(authService: authService)
        interactor = FeedInteractor(presenter: presenter, networkService: networkService)
    }

    // MARK: - FeedDisplayLogic
    
    func displayViewModel(_ viewModel: Feed.ViewModel) {
        self.viewModel = viewModel
        table.reloadData()
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.reuseId, for: indexPath) as! FeedCell
        let cellViewModel = viewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}

