//
//  AlbumFetchNetworkService.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/27/20.
//

import Foundation

struct AlbumFetchNetworkService: NetworkProtocol {
    func execute<T, U>(request: T, completion: @escaping (U?, Error?) -> ()) where U : Decodable {
        guard let albumsRequest = request as? FetchAlbums else {
            return
        }
        Network().dataTask(albumsRequest) { (result) in
            switch result {
            case .success(let decodedModel):
                guard let response = decodedModel as? U else {
                    completion(nil, NetworkErrors.parsingFailed)
                    return
                }
                completion(response, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
