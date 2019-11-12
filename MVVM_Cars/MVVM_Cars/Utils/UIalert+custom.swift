//
//  UIalert+custom.swift
//  MVVM_Cars
//
//  Created by Anderson F Carvalho on 12/11/2019.
//  Copyright © 2019 Anderson F Carvalho. All rights reserved.
//

import UIKit

struct ButtonType {
    let alertEnum: String!
    let handler: ((UIAlertAction) -> Void)?
}

class UIAlertCustom: NSObject {
    
    static var shared = UIAlertCustom()
    
    func showAlert(from viewController: UIViewController?, title: String? = nil, message: String? = nil, buttonType: [ButtonType]? = nil, alertAction: [UIAlertAction]? = nil, prefferedStyle: UIAlertController.Style = UIAlertController.Style.alert) {
        let title = title ?? NSLocalizedString("Attention", comment: "")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: prefferedStyle)
        
        
        if let buttonType = buttonType {
            for type in buttonType {
                let title = type.alertEnum
                alert.addAction(UIAlertAction(title: title, style: UIAlertAction.Style.default, handler: type.handler))
            }
        } else if let alertAction = alertAction {
            for value in alertAction {
                alert.addAction(value)
            }
        }else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
        }
        
        if let viewController = viewController {
            viewController.present(alert, animated: true, completion: nil)
        }else {
            let rootViewController = UIAlertCustom.topMostController()
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

