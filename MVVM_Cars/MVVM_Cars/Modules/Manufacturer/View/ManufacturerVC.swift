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
    let manufacturerWireFrame = ManufacturerWireFrame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ManufacturerCell", bundle: Bundle.main.self), forCellReuseIdentifier: cellName)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.searchBar.delegate = self
        
        fetchData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Manufacturer"
    }
    
    fileprivate func fetchData() {
        
        Loading.shared.showLoading(self.view)
        
        let page = manufacturerViewModel?.page ?? 0
        ManufacturerDataModule.shared.manufacturerFetch(page) { [weak self] (result, error) in
            
            guard let result = result, error == nil else {
                
                self?.stopLoading()
                
                UIAlertCustom.shared.showAlert(from: self, message: error, prefferedStyle: UIAlertController.Style.alert)
                
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
            self?.stopLoading()
            
            
        }
        
    }
    
    private func stopLoading() {
        Loading.shared.stopLoading()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
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
        self.hideKeyboard()
        self.tableView.deselectRow(at: indexPath, animated: false)
        manufacturerViewModel?.setOutput(indexPath.row)
        manufacturerWireFrame.showModel(from: self, manufacturer: manufacturerViewModel)
    }
    
    
}

extension ManufacturerVC: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        manufacturerViewModel?.searchValue(searchText)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
}
