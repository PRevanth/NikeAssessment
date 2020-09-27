//
//  AlbumListViewModel.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumListViewModel {
    
    private var albumResults: [Results] = []
    var shouldReload: (() -> Void)?
    var displayError: (() -> Void)?
    var service: NetworkProtocol
    
    init() {
        service = AlbumFetchNetworkService()
    }
    
    var numberOfRows: Int {
        return albumResults.count
    }
    
    func dataForRow(at index: Int) -> Results? {
        guard albumResults.count > index else {
            return nil
        }
        return albumResults[index]
    }
    
    func fetchAlbums() {
        let request = FetchAlbums()
        service.execute(request: request) { (response: RSSFeed?, _) in
            guard let albumResponse = response else {
                self.displayError?()
                return
            }
            self.albumResults = albumResponse.feed.results
            self.shouldReload?()
        }
    }
    
}

struct FetchAlbums: RequestProtocol {
    typealias ResponseType = RSSFeed
    
    let url = Network.Constants.baseURL
    let method: HTTPMethods = .get
    let parameters: [String : Any] = [:]
}


