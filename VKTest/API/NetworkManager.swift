//
//  NetworkManager.swift
//  VKTest
//
//  Created by Мадияр on 6/5/20.
//  Copyright © 2020 Мадияр. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let parser: Parser
    var manager: Session?
    
    init() {
        self.parser = DecodeParser()
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        manager = Session(configuration: configuration)
    }
     
    func makeRequest<T: Decodable>(endpoint: EndPointType, startFrom: String?, completion: @escaping (Result<T>) -> Void) {
        guard let token = AuthService.shared.token else { return }
        var allParams = endpoint.params
        allParams["access_token"] = token
        allParams["v"] = "5.107"
        allParams["start_from"] = startFrom
        let url = self.url(from: endpoint, params: allParams)
        
        print(url)
        
        manager?.request(url, method: endpoint.httpMethod, encoding: JSONEncoding.default).validate(statusCode: 200..<300).responseJSON { (response) in
            print(response)
            completion(self.parser.parse(response: response))
        }
    }
    
    private func url(from path: EndPointType, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = path.scheme
        components.host = path.host
        components.path = path.path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}
