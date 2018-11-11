//
//  UserResponse.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
