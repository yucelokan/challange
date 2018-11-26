//
//  AlamofireManager.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit
import Alamofire

private var alamofireManager : Alamofire.SessionManager?

class AlamofireManager: NSObject {
    
    class var instance: Alamofire.SessionManager {
        
        if alamofireManager == nil {
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForResource = 60 // seconds
            
            
            alamofireManager = Alamofire.SessionManager(configuration: configuration)
            
            
        }
        
        return alamofireManager!
    }
    
    internal static func handleError(error: NSError?) {
        
        let title = NSLocalizedString("id_hata", comment: "")
        let message = NSLocalizedString("id_internetKontrol", comment: "")
        
        AlertManager.instance.showAlert(title: title, message: error?.localizedDescription ?? message , type:
        .alert, buttonString: "Tamam", showCancel: false, action: {
            AlertManager.instance.dismissAlert()
        })
        
    }
    
    internal static func handleError(errorCode: Int?, errorMessage: String?) {
        
        let title = NSLocalizedString("id_hata", comment: "")
        let message = NSLocalizedString("id_dahaSonraDene", comment: "")
        let buttonText = NSLocalizedString("id_internetKontrol", comment: "")
        
        AlertManager.instance.showAlert(title: title, message: errorMessage ?? message, type: .alert, buttonString: buttonText, showCancel: false, action: {
            AlertManager.instance.dismissAlert()
        })
        
        
        if let code = errorCode{
            
            switch code {
                
            case 1:
                break
            case 2:
                break
            default:
                break
            }
            
        }
        
    }
    
}


