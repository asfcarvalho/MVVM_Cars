//
//  ModelVC.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ModelVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellName = "cell"
    
    var modelViewModel: ModelViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ModelCell", bundle: Bundle.main.self), forCellReuseIdentifier: cellName)
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Model"
    }
    
    fileprivate func fetchData() {
        
        Loading.shared.showLoading(self.view)
        
        let page = modelViewModel?.page ?? 0
        let modelId = modelViewModel?.manufacturer?.code ?? ""
        ModelDataModule.shared.modelFetch(modelId, page) { [weak self] (result, error) in
            
            guard let result = result, error == nil else {
                
                DispatchQueue.main.async {
                    self?.stopLoading()
                    
                    UIAlertCustom.shared.showAlert(from: self, message: error, prefferedStyle: UIAlertController.Style.alert)
                }
                
                return
            }
            
            if self?.modelViewModel == nil {
                self?.modelViewModel = ModelViewModel(result)
            }else {
                self?.modelViewModel?.setupViewModel(result)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopLoading()
            }
            
            
        }
        
    }
    
    private func stopLoading() {
        Loading.shared.stopLoading()
    }

}

extension ModelVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelViewModel?.getNumberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellName) as? ModelCell else { return UITableViewCell()}
        
        let item = modelViewModel?.modelList[indexPath.row]
        
        cell.setupCell(item?.name, indexPath.row)
        
        if modelViewModel?.callNewPage(indexPath.row) == true {
            fetchData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let message = modelViewModel?.getMessage(indexPath.row)
        UIAlertCustom.shared.showAlert(from: self, title: "(manufacturer, model)", message: message, prefferedStyle: UIAlertController.Style.alert)
    }
}
