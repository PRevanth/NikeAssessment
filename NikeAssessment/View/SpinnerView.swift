//
//  SpinnerView.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit

class SpinnerView: UIActivityIndicatorView {
    private var activityIndicatorView: UIActivityIndicatorView?
    
    func  setup(view: UIView) {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .darkGray
        self.activityIndicatorView = activityIndicatorView
        view.addSubview(activityIndicatorView)
        self.activityIndicatorView?.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicatorView?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.activityIndicatorView?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func stopAnimating() {
        super.stopAnimating()
        activityIndicatorView?.stopAnimating()
    }
    
    override func startAnimating() {
        super.startAnimating()
        activityIndicatorView?.startAnimating()
    }
    
}
