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
    private let dateFormatter: DateFormatter
    
    init(viewController: UIViewController & FeedDisplayLogic) {
        self.viewController = viewController
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
    }
    
    func presentFeed(_ feedResponse: FeedResponse) {
        let cells = feedResponse.items.map { cellViewModel(from: $0, profiles: feedResponse.profiles, groups: feedResponse.groups) }
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel)
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> Feed.ViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)        
        return Feed.ViewModel.Cell.init(iconUrlString: "",
                                 name: profile?.name ?? "Noname",
                                 date: dateTitle,
                                 text: feedItem.text,
                                 moreTextTitle: "",
                                 likes: formattedCounter(feedItem.likes?.count),
                                 comments: formattedCounter(feedItem.comments?.count),
                                 shares: formattedCounter(feedItem.reposts?.count),
                                 views: formattedCounter(feedItem.views?.count))
    }
    
    private func profile(for id: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable? {
        let profiles: [ProfileRepresentable] = id >= 0 ? profiles : groups
        let normalizedId = id >= 0 ? id : -id
        return profiles.first(where: { $0.id == normalizedId })
    }

    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0  else { return nil }
        return String(counter)
    }
}
