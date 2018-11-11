//
//  FeedViewController.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedDisplayLogic: class {
    func displayUserVieModel(_ userViewModel: Feed.UserViewModel)
    func displayViewModel(_ viewModel: Feed.ViewModel)
}

final class FeedViewController: UIViewController, FeedDisplayLogic, UITableViewDelegate, UITableViewDataSource, FeedCellDelegate {
    private var interactor: FeedBusinessLogic!
    private var viewModel = Feed.ViewModel.init(cells: [])
    
    @IBOutlet private var table: UITableView!
    private lazy var titleView: TitleView = {
       return TitleView.loadFromNib()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assemble()
        setupTopBars()
        
        table.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: FeedCell.reuseId)
        
        interactor.getUser()
        interactor.getFeed()
    }
    
    private func assemble() {
        let screenWidth = min(UIScreen.main.bounds.width,  UIScreen.main.bounds.height)
        let feedCellLayoutCalculator = FeedCellLayoutCalculator(screenWidth:screenWidth)
        let presenter = FeedPresenter(viewController: self, cellLayoutCalculator: feedCellLayoutCalculator)
        let authService = AppDelegate.shared().authService!
        let networkService = NetworkService(authService: authService)
        interactor = FeedInteractor(presenter: presenter, networkService: networkService)
    }

    private func setupTopBars() {
        self.navigationController?.hidesBarsOnSwipe = true
        let topBar = UIView(frame: UIApplication.shared.statusBarFrame)
        topBar.backgroundColor = UIColor.white
        topBar.layer.shadowColor = UIColor.black.cgColor
        topBar.layer.shadowOpacity = 0.1
        topBar.layer.shadowOffset = CGSize.zero
        topBar.layer.shadowRadius = 8
        self.view.addSubview(topBar)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationItem.titleView = titleView
    }
    
    // MARK: - FeedDisplayLogic
    
    func displayUserVieModel(_ userViewModel: Feed.UserViewModel) {
        titleView.set(userViewModel: userViewModel)
    }
    
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
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    // MARK: - FeedCellDelegate
    
    func revealPost(for cell: FeedCell) {
        guard let indexPath = table.indexPath(for: cell) else { return }
        let cellViewModel = viewModel.cells[indexPath.row]
        interactor.revealPost(for: cellViewModel.postId)
    }
    
}

