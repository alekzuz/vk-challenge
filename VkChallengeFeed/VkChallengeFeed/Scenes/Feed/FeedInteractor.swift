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
    func getNextBatch()
    func revealPost(for postId: Int)
}

final class FeedInteractor: FeedBusinessLogic {
    private let presenter: FeedPresentationLogic
    private let networkService: NetworkService
    
    private var userResponse: UserResponse?
    private var feedResponse: FeedResponse?
    private var revealedPostsIds = [Int]()
    private var newFromInProcess: String?
    
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
        guard newFromInProcess == nil else { return }
        
        networkService.getFeed(completion: { [weak self] feedResponse in
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }, failure: {
            //todo
        })
    }
    
    func getNextBatch() {
        guard newFromInProcess == nil else { return }
        newFromInProcess = feedResponse?.nextFrom
        
        presenter.presentFooterLoader()
        networkService.getFeed(nextBatchFrom: feedResponse?.nextFrom, completion: { [weak self] feedResponse in
            self?.newFromInProcess = nil
            guard self?.feedResponse?.nextFrom != feedResponse.nextFrom else {
                return
            }
            self?.mergeResponse(feedResponse)
            self?.presentFeed()
        }, failure: { [weak self] in
                self?.newFromInProcess = nil
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
    
    private func mergeResponse(_ nextBatch: FeedResponse) {
        if feedResponse == nil {
            feedResponse = nextBatch
        } else {
            feedResponse?.items.append(contentsOf: nextBatch.items)
            
            var profiles = nextBatch.profiles
            if let oldProfiles = feedResponse?.profiles {
                let oldProfilesFiltered = oldProfiles.filter({ oldProfile -> Bool in
                    !nextBatch.profiles.contains(where: { $0.id == oldProfile.id })
                })
                profiles.append(contentsOf: oldProfilesFiltered)
            }
            feedResponse?.profiles = profiles
            
            var groups = nextBatch.groups
            if let oldGroups = feedResponse?.groups {
                let oldGroupsFiltered = oldGroups.filter({ oldGroup -> Bool in
                    !nextBatch.groups.contains(where: { $0.id == oldGroup.id })
                })
                groups.append(contentsOf: oldGroupsFiltered)
            }
            feedResponse?.groups = groups
            
            feedResponse?.nextFrom = nextBatch.nextFrom
        }
    }
    
}
