//
//  RequestManager.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

private var requestManager: RequestManager?

class RequestManager: NSObject {
    
    class var instance: RequestManager {
        
        if requestManager == nil {
            requestManager = RequestManager()
        }
        
        return requestManager!
    }
    
    func getUserInformations(completionHandler: @escaping (_ status:Bool,_ result: UserInformation) -> ()) {
        
        var status = false
        var result = UserInformation()
        
        let serviceURL = RestApiURLManager.mGetUserInfoURL
        
        let parameters: [String: AnyObject]? = [
            "id": "id" as AnyObject
        ]
        
        AlamofireManager.instance.request(serviceURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<UserInformation>) in
                
                status = response.result.isSuccess
                
                if status{
                    if let value = response.result.value{
                        status = value.status
                        if status{
                            result = value
                        }else{
                            AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                        }
                    }else{
                        status = false
                        AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                    }
                }else{
                    AlamofireManager.handleError(error: response.result.error as NSError?)
                }
                completionHandler(status,result)
                
        }
    }
    
    func getQuestion(questionNumber: Int,completionHandler: @escaping (_ status:Bool,_ result: Question) -> ()) {
        
        var status = false
        var result = Question()
        
        let serviceURL = RestApiURLManager.mGetQuestionsURL + "\(questionNumber)"
        
        let parameters: [String: AnyObject]? = [:]
        
        AlamofireManager.instance.request(serviceURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Question>) in
                
                status = response.result.isSuccess
                
                if status{
                    if let value = response.result.value{
                        status = value.status
                        if status{
                            result = value
                        }else{
                            AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                        }
                    }else{
                        status = false
                        AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                    }
                }else{
                    AlamofireManager.handleError(error: response.result.error as NSError?)
                }
                completionHandler(status,result)
                
        }
    }
    
    func getResults(completionHandler: @escaping (_ status:Bool,_ result: Results) -> ()) {
        
        var status = false
        var result = Results()
        
        let serviceURL = RestApiURLManager.mGetResultsURL
        
        let parameters: [String: AnyObject]? = [
            "id": "id" as AnyObject
        ]
        
        AlamofireManager.instance.request(serviceURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Results>) in
                
                status = response.result.isSuccess
                
                if status{
                    if let value = response.result.value{
                        status = value.status
                        if status{
                            result = value
                        }else{
                            AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                        }
                    }else{
                        status = false
                        AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                    }
                }else{
                    AlamofireManager.handleError(error: response.result.error as NSError?)
                }
                completionHandler(status,result)
                
        }
    }
    
    func sendAnswer(answer: String, completionHandler: @escaping (_ status:Bool,_ result: Answer) -> ()) {
        
        var status = false
        var result = Answer()
        
        let serviceURL = RestApiURLManager.mSendAnswerURL
        
        let parameters: [String: AnyObject]? = [
            "id": "id" as AnyObject,
            "cevap": answer as AnyObject
        ]
        
        AlamofireManager.instance.request(serviceURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<Answer>) in
                
                status = response.result.isSuccess
                
                if status{
                    if let value = response.result.value{
                        status = value.status
                        if status{
                            result = value
                        }else{
                            AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                        }
                    }else{
                        status = false
                        AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                    }
                }else{
                    AlamofireManager.handleError(error: response.result.error as NSError?)
                }
                completionHandler(status,result)
                
        }
    }
    
    func useWildCard(completionHandler: @escaping (_ status:Bool,_ result: WildCard) -> ()) {
        
        var status = false
        var result = WildCard()
        
        let serviceURL = RestApiURLManager.mUseWildCardURL
        
        let parameters: [String: AnyObject]? = [
            "id": "id" as AnyObject
        ]
        
        AlamofireManager.instance.request(serviceURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseObject { (response: DataResponse<WildCard>) in
                
                status = response.result.isSuccess
                
                if status{
                    if let value = response.result.value{
                        status = value.status
                        if status{
                            result = value
                        }else{
                            AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                        }
                    }else{
                        status = false
                        AlamofireManager.handleError(errorCode: 0 , errorMessage: nil)
                    }
                }else{
                    AlamofireManager.handleError(error: response.result.error as NSError?)
                }
                completionHandler(status,result)
                
        }
    }
    
    
    
    
    
    
}

