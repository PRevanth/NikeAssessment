//
//  MockAlbumFetchService.swift
//  NikeAssessmentTests
//
//  Created by Pendyala Revanth on 9/27/20.
//

import Foundation

@testable import NikeAssessment

struct MockAlbumFetchSuccess: NetworkProtocol {
    func execute<T, U>(request: T, completion: @escaping (U?, Error?) -> ()) where U : Decodable {
        let albumResponse = JSONHelper.getJsonDecodeObject(type: RSSFeed.self, jsonFileName: "RSSFeedResponse", bundle: Bundle(for: NikeAssessmentTests.self)) as? U
        completion(albumResponse, nil)
    }
}

struct MockAlbumFetchFailure: NetworkProtocol {
    func execute<T, U>(request: T, completion: @escaping (U?, Error?) -> ()) where U : Decodable {
        completion(nil, NetworkErrors.requestFailed)
    }
}

struct MockAlbumFetchSuccessWithInavlid: NetworkProtocol {
    func execute<T, U>(request: T, completion: @escaping (U?, Error?) -> ()) where U : Decodable {
        let albumResponse = JSONHelper.getJsonDecodeObject(type: RSSFeed.self, jsonFileName: "EmptyResponse", bundle: Bundle(for: NikeAssessmentTests.self)) as? U
        completion(albumResponse, NetworkErrors.invalidURL)
    }
}
