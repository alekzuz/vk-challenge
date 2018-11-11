//
//  FeedPresenter.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedPresentationLogic: class {
    func presentUserInfo(_ userResponse: UserResponse?)
    func presentFeed(_ feedResponse: FeedResponse, revealedPostsIds: [Int])
}

final class FeedPresenter: FeedPresentationLogic {
    private unowned let viewController: UIViewController & FeedDisplayLogic
    private let cellLayoutCalculator: FeedCellLayoutCalculatorProtocol
    private let dateFormatter: DateFormatter
    
    init(viewController: UIViewController & FeedDisplayLogic, cellLayoutCalculator: FeedCellLayoutCalculatorProtocol ) {
        self.viewController = viewController
        self.cellLayoutCalculator = cellLayoutCalculator
        dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
    }
    
    func presentUserInfo(_ userResponse: UserResponse?) {
        viewController.displayUserVieModel(Feed.UserViewModel.init(photoUrlString: userResponse?.photo100))
    }
    
    func presentFeed(_ feedResponse: FeedResponse, revealedPostsIds: [Int]) {
        let cells = feedResponse.items.map { cellViewModel(from: $0,
                                                           profiles: feedResponse.profiles,
                                                           groups: feedResponse.groups,
                                                           revealedPostsIds: revealedPostsIds) }
        let viewModel = Feed.ViewModel.init(cells: cells)
        viewController.displayViewModel(viewModel)
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostsIds: [Int]) -> Feed.ViewModel.Cell {
        let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachments = self.photoAttachments(feedItem: feedItem)
        let isFullSized = revealedPostsIds.contains(feedItem.postId ?? 0)
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        let sizes = cellLayoutCalculator.sizes(postText: postText,
                                               isFullSizedPost: isFullSized,
                                               photoAttachments: photoAttachments)
        return Feed.ViewModel.Cell.init(postId: feedItem.postId ?? 0,
                                        iconUrlString: profile?.photo ?? "",
                                 name: profile?.name ?? "Noname",
                                 date: dateTitle,
                                 text: postText,                                 
                                 photoAttachments: photoAttachments,
                                 likes: formattedCounter(feedItem.likes?.count),
                                 comments: formattedCounter(feedItem.comments?.count),
                                 shares: formattedCounter(feedItem.reposts?.count),
                                 views: formattedCounter(feedItem.views?.count),
                                 sizes: sizes)
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
    
    private func photoAttachments(feedItem: FeedItem) -> [Feed.ViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap({ attachment -> Feed.ViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return Feed.ViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBig,
                                                        width: photo.width,
                                                        height: photo.height)
        })
    }
}
