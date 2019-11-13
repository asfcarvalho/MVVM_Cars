//
//  ModelDataModule.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ModelDataModule {
    
    static let shared = ModelDataModule()
    
    let pageSize = 15
    
    func modelFetch(_ id: String, _ page: Int, callBack: @escaping (Model?, String?) -> Void) {
        
        let apiRequest = APIRequest()
        apiRequest.baseURL = URL(string: "\(URLDdefault)main-types?manufacturer=\(id)&page=\(page)&pageSize=\(pageSize)&wa_key=\(keyDefault)")
        
        APICalling().fetch(apiRequest: apiRequest) { (result: Model?, error) in
            callBack(result, error)
        }
        
    }
}
