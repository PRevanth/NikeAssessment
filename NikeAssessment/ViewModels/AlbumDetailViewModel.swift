//
//  AlbumDetailViewModel.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class AlbumDetailViewModel {
    
    var eachAlbum: Results?
    
    init() {    }
    
    func downloadImage(with urlString: String, completion: @escaping (Result<UIImage, NetworkErrors>) -> Void) {
        _ = Network().downloadTask(urlString: urlString, completion)
    }
    
}
