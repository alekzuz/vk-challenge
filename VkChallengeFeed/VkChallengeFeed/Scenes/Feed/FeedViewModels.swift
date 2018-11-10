//
//  FeedViewModels.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation

enum Feed {
    struct ViewModel {
        struct Cell: FeedCellViewModel {
            let iconUrlString: String
            let name: String
            let date: String
            let text: String?
            let moreTextTitle: String?
            let likes: String
            let comments: String
            let shares: String
            let views: String
        }
        let cells: [Cell]
    }
}
