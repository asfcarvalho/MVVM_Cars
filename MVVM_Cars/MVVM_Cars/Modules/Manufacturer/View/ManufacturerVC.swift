//
//  ManufacturerVC.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 11/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ManufacturerVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellName = "cell"
    var manufacturerViewModel: ManufacturerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ManufacturerCell", bundle: Bundle.main.self), forCellReuseIdentifier: cellName)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        fetchData()
        
    }
    
    fileprivate func fetchData() {
        let page = manufacturerViewModel?.page ?? 0
        ManufacturerDataModule.shared.manufacturerFetch(page) { [weak self] (result, error) in
            
            guard let result = result, error == nil else {
                print(error)
                return
            }
            
            if self?.manufacturerViewModel == nil {
                self?.manufacturerViewModel = ManufacturerViewModel(result)
            }else {
                self?.manufacturerViewModel?.setupViewModel(result)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
        }
        
    }
    
}

extension ManufacturerVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturerViewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? ManufacturerCell else { return UITableViewCell()}
        
        let item = manufacturerViewModel?.manufacturList[indexPath.row]
        
        cell.setupCell(item?.code, item?.name, indexPath.row)
        
        if manufacturerViewModel?.callNewPage(indexPath.row) == true {
            fetchData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        print(manufacturerViewModel?.manufacturList[indexPath.row].name)
    }
    
    
}
