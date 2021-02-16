//
//  NetworkManager.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 16/02/2021.
//  Copyright © 2021 Nada Kamel. All rights reserved.
//

import Moya
import ObjectMapper

protocol Networkable {
    var apiProvider: MoyaProvider<APIEndpoints> { get }
    
    func fetchCharacters(offset: Int, completion: @escaping (Result<[Character], Error>) -> ())
}

class NetworkManager: Networkable {

    static let endpointClosure = { (endpoint: APIEndpoints) -> Endpoint in
        return Endpoint(url: endpoint.path,
                        sampleResponseClosure: {.networkResponse(200, endpoint.sampleData)},
                        method: endpoint.method,
                        task: endpoint.task,
                        httpHeaderFields: endpoint.headers)
    }
    
    let apiProvider = MoyaProvider<APIEndpoints>(endpointClosure: endpointClosure)

    func fetchCharacters(offset: Int, completion: @escaping (Result<Array<Character>, Error>) -> ()) {
        request(target: .getCharacters(offset: offset), completion: completion)
    }
}

private extension NetworkManager {

    private func request<T>(target: APIEndpoints, completion: @escaping (Result<T, Error>) -> ()) {
        apiProvider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: response.data, options: .mutableContainers) as! NSDictionary
                    print(responseJSON)
                    switch target {
                    case .getCharacters:
                        print(responseJSON["status"] ?? "")
                        guard let characters = Mapper<Character>().mapArray(JSONObject: responseJSON) else {
                            print("*********** No Characters Data ***********")
                            break
                        }
                        completion(.success(characters as! T))
                    case .getThumbnails:
                        guard let thumbnails = Mapper<Thumbnail>().mapArray(JSONObject: responseJSON) else {
                            print("*********** No Thumbnails Data ***********")
                            break
                        }
                        completion(.success(thumbnails as! T))
                    }
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
