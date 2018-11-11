//
//  FeedInteractor.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation

protocol FeedBusinessLogic: class {
    func getUser()
    func getFeed()
    func revealPost(for postId: Int)
}

final class FeedInteractor: FeedBusinessLogic {
    private let presenter: FeedPresentationLogic
    private let networkService: NetworkService
    
    private var userResponse: UserResponse?
    private var feedResponse: FeedResponse?
    private var revealedPostsIds = [Int]()
    
    init(presenter: FeedPresentationLogic, networkService: NetworkService) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    func getUser() {
        networkService.getUser(completion: { [weak self] user in
            self?.userResponse = user
            self?.presenter.presentUserInfo(user)
        }, failure: {
            //todo
        })
    }
    
    func getFeed() {
        networkService.getFeed(completion: { [weak self] feedResponse in
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }, failure: {
            //todo
        })
    }
    
    func revealPost(for postId: Int) {
        revealedPostsIds.append(postId)
        presentFeed()
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter.presentFeed(feedResponse, revealedPostsIds: revealedPostsIds)
    }
}
