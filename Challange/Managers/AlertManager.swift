//
//  AlertManager.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

private var alertManager: AlertManager?

class AlertManager: NSObject {
    
    class var instance: AlertManager {
        
        if alertManager == nil {
            alertManager = AlertManager()
        }
        
        return alertManager!
    }
    
    private var alertController: UIAlertController?
    
    func showAlert(title: String, message: String, type: UIAlertController.Style, buttonString: String,showCancel: Bool, action:@escaping ()->Void) {
        
        let cancelText = NSLocalizedString("id_iptal", comment: "")
        
        self.alertController = UIAlertController(title: title, message: message, preferredStyle: type)
        
        self.alertController?.addAction(.init(title: buttonString, style: .default, handler: { _ in
            action()
        }))
        
        if showCancel{
            self.alertController?.addAction(.init(title: cancelText, style: .cancel, handler: { _ in
                self.alertController?.dismiss(animated: true, completion: nil)
            }))
        }
        
        guard let alert = alertController else{
            return
        }
        
        HelperManager.topViewController()?.present(alert, animated: true, completion: nil)
        
    }
    
    func changeAlertText(title: Bool, newText: String){
   
        guard let alert = HelperManager.topViewController() as? UIAlertController else{
            return
        }
        
        if title{
            alert.title = newText
        }else{
            alert.message = newText
        }
        
    }
    
    func dismissAlert(){
        self.alertController?.dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(backgroundColor:UIColor, textColor:UIColor, message:String, controller: UIViewController, time: Double)
    {
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = backgroundColor.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        
        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = textColor
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.boldSystemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])
        
        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                })
            })
        })
    }
    
    func showPositiveMessage(message:String,time:Double, controller: UIViewController)
    {
        showAlert(backgroundColor: UIColor.init(hexString: "197519")!, textColor: UIColor.white, message: message, controller: controller,time: time)
    }
    func showNegativeMessage(message:String,time:Double, controller: UIViewController)
    {
        showAlert(backgroundColor: UIColor.red, textColor: UIColor.white, message: message, controller: controller, time: time)
    }
    
}




