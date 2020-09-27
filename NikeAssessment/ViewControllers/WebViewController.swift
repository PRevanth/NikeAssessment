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
    private var webView: WKWebView?
    private let spinnerView = SpinnerView()
    
    convenience init(url: URL) {
        self.init()
        self.url = url
    }
    
    override func loadView() {
        setupWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAlbum()
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = webView
    }
    
    private func loadAlbum() {
        // Spinner Setup
        spinnerView.setup(view: self.view)
        spinnerView.startAnimating()
        
        guard let url = self.url else {
            // Should handle error.
            return
        }
        webView?.load(URLRequest(url: url))
        webView?.allowsBackForwardNavigationGestures = true
    }
    
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinnerView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinnerView.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // Should handle error if url failed to load webView
        spinnerView.stopAnimating()
    }
}
