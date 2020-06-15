//
//  NetworkService.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import Foundation
import VKSdkFramework

final class NetworkService {
    
    private let networkManager: NetworkManager = NetworkManager()
    
    static let shared = NetworkService()
    
    func getNewsFeed(startFrom: String?, complitionHandler: @escaping ((FeedResponseWrapped)->Void), complitionHandlerError: @escaping ((String) -> Void)) {
        
        let endpoint = Endpoints.newsFeed
        networkManager.makeRequest(endpoint: endpoint, startFrom: startFrom) { (result: Result<FeedResponseWrapped>) in
            switch result {
            case .failure(let error):
                complitionHandlerError(error)
            case .success(let result):
                complitionHandler(result)
            }
        }
        
    }
}
