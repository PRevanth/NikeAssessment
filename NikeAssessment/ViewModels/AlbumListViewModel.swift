//
//  AlbumListViewModel.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumListViewModel: UIViewController {
    
    private var albumResults: [Results] = []
    var shouldReload: (() -> Void)?
    var displayError: (() -> Void)?
    
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
        
        Network().dataTask(request) { (result) in
            switch result {
            case .success(let decodedModel):
                guard let response = decodedModel as? RSSFeed else {
                    self.displayError?()
                    return
                }
                self.albumResults = response.feed.results
                self.shouldReload?()
            case .failure(let error):
                self.displayError?()
            }
        }
    }
    
}

private struct FetchAlbums: RequestProtocol {
    typealias ResponseType = RSSFeed
    
    let url = Network.Constants.baseURL
    let method: HTTPMethods = .get
    let parameters: [String : Any] = [:]
}


