//
//  AppConstants.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

let EMPTY_STRING = ""


public enum HTTPMethods: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// MARK:- Navigation Constants
struct NavigationTitleConstants {
    static let albumList = NSLocalizedString("Album List", comment: EMPTY_STRING)
}

// MARK:- TableView Cell Constants
struct CellIdentifierConstants {
    static let albumCell = "AlbumCell"
}

// MARK:- Font Constants
public enum FontConstants: String {
    case helvetMedium = "HelveticaNeue-Medium"
    case helvetBold = "HelveticaNeue-Bold"
    case helvetLight = "HelveticaNeue-Light"
    
    var font: UIFont {
        guard let font = UIFont(name: self.rawValue, size: FontSize.defaultTextSize.rawValue) else {
            fatalError("\(self.rawValue) font is not available")
        }
        return font
    }
    
}

public enum FontSize: CGFloat {
    case defaultTextSize = 14.0
    case fontSize_16 = 16.0
}

// MARK:- Network Error Constants
struct NetworkErrorConstants {
    static let failedToDownloadimage = "Failed to download the image for url %@ with error %@"
    static let unableToLoad = NSLocalizedString("Unable to Load the data", comment: EMPTY_STRING) 
}
