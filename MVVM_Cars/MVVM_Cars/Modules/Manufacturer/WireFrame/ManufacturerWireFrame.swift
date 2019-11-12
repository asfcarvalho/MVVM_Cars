//
//  ManufacturerWireFrame.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

class ManufacturerWireFrame {
    
    func showModel(from viewController: UIViewController, manufacturer: ManufacturerViewModel?) {
        
        let storyBoard = viewController.storyboard
        
        guard let modelVC = storyBoard?.instantiateViewController(withIdentifier: "modelVC") as? ModelVC else { return }
        
        modelVC.modelViewModel = ModelViewModel(ModelViewModel.Input(code: manufacturer?.output?.code ?? "", name: manufacturer?.output?.name ?? ""))
        
        DispatchQueue.main.async {
            
            
            viewController.navigationController?.pushViewController(modelVC, animated: true)
        }
        
    }
}
