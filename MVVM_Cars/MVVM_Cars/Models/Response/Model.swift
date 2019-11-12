//
//  Model.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import Foundation

struct Model: Codable {
    let page: Int?
    let pageSize: Int?
    let totalPageCount: Int?
    let wkda: [String: String]?
}
