//
//  ManufacturerDataModule.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ManufacturerDataModule {
    
    static let shared = ManufacturerDataModule()
    
    let pageSize = 10
    
    func manufacturerFetch(_ page: Int, callBack: @escaping (Manufacturer?, String?) -> Void) {
        
        let apiRequest = APIRequest()
        apiRequest.baseURL = URL(string: "\(URLDdefault)manufacturer?page=\(page)&pageSize=\(pageSize)&wa_key=\(keyDefault)")
        
        APICalling().fetch(apiRequest: apiRequest) { (result: Manufacturer?, error) in
            callBack(result, error)
        }
        
    }
}
