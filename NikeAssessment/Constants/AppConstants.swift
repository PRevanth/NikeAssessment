//
//  AppConstants.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

let EMPTY_STRING = ""
let NOT_AVAILABLE = "N/A"
let SEPARATOR = ", "


// MARK:- HTTPMethods
public enum HTTPMethods: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

// MARK:- Navigation Constants
struct NavigationTitleConstants {
    static let albumList = NSLocalizedString("Album List", comment: EMPTY_STRING)
    static let albumDetails = NSLocalizedString("Album Detail", comment: EMPTY_STRING)
}

// MARK:- TableView Cell Constants
struct CellIdentifierConstants {
    static let albumCell = "AlbumCell"
}

struct RowHeightConstants {
    static let albumListRowHeight: CGFloat = 70
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
    
    func font(with size: FontSize) -> UIFont {
        guard let font =  UIFont(name: self.rawValue, size: size.rawValue) else {
            fatalError("\(self.rawValue) font is not available")
        }
        return font
    }
    
    
}

public enum FontSize: CGFloat {
    case defaultTextSize = 14.0
    case fontSize_16 = 16.0
    case fontSize_12 = 12.0
}

// MARK:- Network Error Constants
struct NetworkErrorConstants {
    static let failedToDownloadimage = "Failed to download the image for url %@ with error %@"
    static let unableToLoad = NSLocalizedString("Unable to Load the data", comment: EMPTY_STRING) 
}

// MARK:- App Constants
struct AppConstants {
    static let artistName = NSLocalizedString("Artist Name: %@", comment: EMPTY_STRING)
    static let genres = NSLocalizedString("Genres: %@", comment: EMPTY_STRING)
    static let releaseDate = NSLocalizedString("Release Date: %@", comment: EMPTY_STRING)
    static let copyright = NSLocalizedString("Copyright: %@", comment: EMPTY_STRING)
    static let iTunesButtonTitle = NSLocalizedString("iTunes store", comment: EMPTY_STRING)
}

