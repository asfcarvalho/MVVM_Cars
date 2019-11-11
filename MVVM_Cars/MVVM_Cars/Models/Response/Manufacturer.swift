//
//  Manufacturer.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

struct Manufacturer: Codable {
    let page: Int?
    let pageSize: Int?
    let totalPageCount: Int?
    let wkda: [String: String]?
}
