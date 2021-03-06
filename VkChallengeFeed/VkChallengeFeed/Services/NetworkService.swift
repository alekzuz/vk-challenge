//
//  NetworkService.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void, failure: @escaping () -> Void) {
        guard let userId = authService.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        sendDataRequest(path: API.user, params: params, completion: { (user: UserResponseWrapped) -> Void in
            completion(user.response.first)
        }, failure: failure)
    }
    
    func getFeed(nextBatchFrom: String? = nil, completion: @escaping (FeedResponse) -> Void, failure: @escaping () -> Void) {
        var params = ["filters": "post,photo"]
        params["start_from"] = nextBatchFrom
        sendDataRequest(path: API.newsFeed, params: params, completion: { (feed: FeedResponseWrapped) -> Void in
            completion(feed.response)
        }, failure: failure)
    }
    
    func search(text: String, nextBatchFrom: String? = nil, completion: @escaping (FeedResponse) -> Void, failure: @escaping () -> Void) {
        guard let excapedText = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            failure()
            return
        }
        var params = ["q": excapedText]
        params["start_from"] = nextBatchFrom
//        sendDataRequest(path: API.search, params: params, completion: { (feed: FeedResponseWrapped) -> Void in
//            completion(feed.response)
//        }, failure: failure)
    }
    
    private func sendDataRequest<T: Decodable>(path: String,
                                 params: [String: String],
                                 completion: @escaping (T) -> Void,
                                 failure: @escaping () -> Void) {
        guard let token = authService.token else { return }
        let session = URLSession(configuration: .default)
        
        var paramsWithTokenAndVerion = params
        paramsWithTokenAndVerion["access_token"] = token
        paramsWithTokenAndVerion["v"] = API.version
        
        let url = self.url(from: path, params: paramsWithTokenAndVerion)
        print("Send request: \(url.absoluteString)")
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
//                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                    print("json \(json)")
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedResponse = try decoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(decodedResponse)
                    }
                } catch let deserialiationError {
                    print("deserialiationError: \(deserialiationError)")
                    DispatchQueue.main.async {
                        failure()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    failure()
                }
            }
        }
        dataTask.resume()
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var comps = URLComponents()
        comps.scheme = API.scheme
        comps.host = API.host
        comps.path = path
        comps.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return comps.url!
    }
}
