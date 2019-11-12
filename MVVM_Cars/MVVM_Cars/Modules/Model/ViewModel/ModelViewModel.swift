//
//  ModelViewModel.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ModelViewModel {
    
    var page: Int = 0
    var pageCount = 0
    var modelList = [Output]()
    var error: String?
    var manufacturer: Input?
    
    struct Input {
        let code: String
        let name: String
    }
    
    struct Output {
        let code: String
        let name: String
    }
    
    func getNumberOfRows() -> Int {
        return modelList.count
    }
    
    func callNewPage(_ row: Int) -> Bool {
        if row == (self.getNumberOfRows() - 1) && (self.page) < (self.pageCount) {
            return true
        }
        return false
    }
    
    func getMessage(_ row: Int) -> String {
        return "(\(manufacturer?.name ?? ""), \(modelList[row].name))"
    }
    
    init(_ input: Input) {
        self.manufacturer = input
    }
    
    init(_ model: Model) {
        
        setupViewModel(model)
    }
    
    func setupViewModel(_ model: Model) {
        self.pageCount = model.totalPageCount ?? 0
        
        let listTemp = model.wkda?.map({ (code, name) -> Output in
            return Output(code: code, name: name)
        }) ?? [Output]()
        
        if self.modelList.count <= 0 {
            self.modelList = listTemp
        }else {
            self.modelList.append(contentsOf: listTemp)
        }
        
        self.page = (model.page ?? 0) + 1
    }
}
