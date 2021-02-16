//
//  APIEndpoints.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Moya

enum APIEndpoints {
    static private let publicKey = "1f6d4c274a4933e9409e77c8067053e6"
    static private let hash = "5b31c337393326e36841ed9276013ee6"            // md5(ts+privateKey+publicKey)
    
    case getCharacters(offset: Int)
    case getThumbnails(resourceURI: String)
}

extension APIEndpoints: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://gateway.marvel.com/v1/public") else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .getCharacters:
            return "\(baseURL)/characters"
        case .getThumbnails(let resourceURI):
            return resourceURI
        }
    }
    
    var method: Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getCharacters(let offset):
            return ["apikey":APIEndpoints.publicKey,
                    "hash":APIEndpoints.hash,
                    "limit":6,
                    "offset":offset,
                    "ts":1]
        case .getThumbnails:
            return ["apikey":APIEndpoints.publicKey,
                    "hash":APIEndpoints.hash,
                    "ts":1]
        }
    }
    
}
