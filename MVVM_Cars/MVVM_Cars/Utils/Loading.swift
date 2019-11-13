//
//  Loading.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class Loading {
    
    static var shared = Loading()
    
    fileprivate var viewLoading: UIView?
    
    func showLoading(_ view: UIView) {
        
        stopLoading()
        
        viewLoading = UIView(frame: view.bounds)
        viewLoading?.backgroundColor = UIColor.gray.withAlphaComponent(0.9)
        
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.center = view.center
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        
        DispatchQueue.main.async {
            self.viewLoading?.addSubview(indicator)
            guard let value = self.viewLoading else { return }
            view.addSubview(value)
        }
        
    }
    
    func stopLoading() {
        self.viewLoading?.removeFromSuperview()
    }
}
