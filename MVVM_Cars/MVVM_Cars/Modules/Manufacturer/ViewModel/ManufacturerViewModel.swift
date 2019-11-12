//
//  ManufacturerViewModel.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

class ManufacturerViewModel {
    var page: Int = 0
    var pageCount = 0
    var manufacturList = [Output]()
    var tempList = [Output]()
    var error: String?
    var output: Output?
    var isSearching = false
    
    struct Output {
        let code: String
        let name: String
    }
    
    func getNumberOfRows() -> Int {
        return manufacturList.count
    }
    
    func callNewPage(_ row: Int) -> Bool {
        if row == (self.getNumberOfRows() - 1) && (self.page) < (self.pageCount) && !isSearching {
            return true
        }
        return false
    }
    
    init(_ manufacturer: Manufacturer) {
        
        setupViewModel(manufacturer)
    }
    
    func setOutput(_ row: Int) {
        let temp = manufacturList[row]
        self.output = Output(code: temp.code, name: temp.name)
    }
    
    func setupViewModel(_ manufacturer: Manufacturer) {
        self.pageCount = manufacturer.totalPageCount ?? 0
        
        let listTemp = manufacturer.wkda?.map({ (code, name) -> Output in
            return Output(code: code, name: name)
        }) ?? [Output]()
        
        if self.manufacturList.count <= 0 {
            self.manufacturList = listTemp
        }else {
            self.manufacturList.append(contentsOf: listTemp)
        }
        self.tempList = self.manufacturList
        self.page = (manufacturer.page ?? 0) + 1
        
        self.isSearching = false
    }
    
    func searchValue(_ text: String) {
        if text.isEmpty {
            self.manufacturList = tempList
            self.isSearching = false
        }else {
            self.manufacturList = tempList.filter({ (item) -> Bool in
                return item.name.contains(text)
            })
            self.isSearching = true
        }
    }
}
