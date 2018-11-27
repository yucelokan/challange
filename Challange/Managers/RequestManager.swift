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
            "deviceToken": "deviceToken" as AnyObject
        ]
        
        //üye bilgilerini almak için unique bir değer olarak device token kullanıldı her telefon sadece 1 üyelik kullanabilir. servis parametre olarak devicetoken alıyor eğer bu devicetoken bir üyeyse üyebilgisi geri  döndürüyor değilse yeni üye oluştur yeni oluşturduğu üye bilgilerini döndürüyor. gibi
        
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
        
        //sanki soket server dinleniyormuş gibi QuestionViewController içinde bu servis 10 saniyede 1 çağrıyılıyor.
        
        
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
        
        //yarışma bittiğinde sonuçları almak için parametre olarak kullanıcı id yani devicetoken alıyor
        // ve geriye yarışmacı ne kadar kazandı ve tüm soruları doğru yapan kişileri döndürüyor.
        
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
        
        //paremetre olarak devicetoken ve verilen cevabı alıyor
        //cevap sunucuya gönderiliyor.
        
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
        
        //wil card kullanıldığınca çalışır ve eğer kullanabiliyorsa servisten true kullanamıyorsa false döner ve kalan hakkı döner.
        
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

