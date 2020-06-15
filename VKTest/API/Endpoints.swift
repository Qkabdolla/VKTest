//
//  Endpoints.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T>: Error {
    case success(T)
    case failure(String)
}

public protocol EndPointType {
    var scheme: String { get }
    var httpMethod: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var params: [String : String] { get }
}

enum Endpoints {
    case newsFeed
}
    
extension Endpoints: EndPointType {
    var scheme: String {
        switch self {
        case .newsFeed:
            return "https"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .newsFeed:
            return .get
        }
    }
    
    var host: String {
        switch self {
        case .newsFeed:
            return "api.vk.com"
        }
    }
    
    var path: String {
        switch self {
        case .newsFeed:
            return "/method/newsfeed.get"
        }
    }
    
    var params: [String : String] {
        switch self {
        case .newsFeed:
            return ["filters" : "post, photo"]
        }
    }
}
