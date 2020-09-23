//
//  WebViewController.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private var url: URL?
    
    convenience init(url: URL) {
        self.init()
        self.url = url
    }
    
}
