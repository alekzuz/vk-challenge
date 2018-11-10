//
//  FeedPresenter.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedPresentationLogic: class {
    func presentFeed(_ feedResponse: FeedResponse)
}

final class FeedPresenter: FeedPresentationLogic {
    private unowned let viewController: UIViewController & FeedDisplayLogic
    
    init(viewController: UIViewController & FeedDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentFeed(_ feedResponse: FeedResponse) {
        let cells = feedResponse.items.map { cellViewModel(from: $0) }
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel)
    }
    
    private func cellViewModel(from feedItem: FeedItem) -> Feed.ViewModel.Cell {
        return Feed.ViewModel.Cell.init(iconUrlString: "",
                                 name: "asd",
                                 date: "",
                                 text: feedItem.text,
                                 moreTextTitle: "",
                                 likes: String(feedItem.likes?.count ?? 0),
                                 comments: String(feedItem.comments?.count ?? 0),
                                 shares: String(feedItem.reposts?.count ?? 0),
                                 views: String(feedItem.views?.count ?? 0))
        
    }
    
}
