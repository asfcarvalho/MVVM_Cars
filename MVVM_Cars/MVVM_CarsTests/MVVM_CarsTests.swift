//
//  MVVM_CarsTests.swift
//  MVVM_CarsTests
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import XCTest
@testable import MVVM_Cars

class MVVM_CarsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: testing manufacturerViewModel
    func testManufacturerViewModelSearchOutput() {
        let manufacturer = Manufacturer(page: 0, pageSize: 10, totalPageCount: 10, wkda: ["107": "Bentley"])
        let manufacturerViewModel = ManufacturerViewModel(manufacturer)
        
        manufacturerViewModel.searchValue("Ben")
        
        XCTAssertTrue(manufacturerViewModel.getNumberOfRows() > 0)
    }
    
    //Testing the tableview text
    func testManufacturerViewModel() {
        let manufacturer = Manufacturer(page: 0, pageSize: 10, totalPageCount: 10, wkda: ["107": "Bentley"])
        let manufacturerViewModel = ManufacturerViewModel(manufacturer)
        
        XCTAssertTrue(manufacturerViewModel.getNumberOfRows() > 0)
    }
    
    //MARK: testing modelViewModel
    
    //Testing the output message
    func testModelViewModelMessage() {
        let input = ModelViewModel.Input(code: "107", name: "Bentley")
        let model = Model(page: 0, pageSize: 10, totalPageCount: 1, wkda: ["Arnage": "Arnage"])
        let modelViewModel = ModelViewModel(model)
        modelViewModel.manufacturer = input
        
        let message = modelViewModel.getMessage(0)
        
        let modelOut = modelViewModel.modelList[0]
        
        XCTAssertEqual(message, "(\(modelViewModel.manufacturer?.name ?? ""), \(modelOut.name))")
    }
    
    //Testing the tableview text
    func testModelViewModel() {
        let input = ModelViewModel.Input(code: "107", name: "Bentley")
        let model = Model(page: 0, pageSize: 10, totalPageCount: 1, wkda: ["Arnage": "Arnage"])
        let modelViewModel = ModelViewModel(model)
        modelViewModel.manufacturer = input
        
        XCTAssertTrue(modelViewModel.getNumberOfRows() > 0)
    }

}
