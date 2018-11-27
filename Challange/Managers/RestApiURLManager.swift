//
//  RestApiURLManager.swift
//  Challange
//
//  Created by Okan Yücel on 26.11.2018.
//  Copyright © 2018 Okan Yücel. All rights reserved.
//

import UIKit

class RestApiURLManager: NSObject {
    
    class var mPreffixURL: String  { return StaticVariables.ServiceURL }
    
    class var mGetUserInfoURL: String                { return mPreffixURL + "getUserInformations" }
    /*parametreler:
     deviceToken: String
     
     result
     {
        "status": true,
        "name": "Okan",
        "id": "id",
        "wildCardCount": 5
     }*/
    
    class var mGetQuestionsURL: String               { return mPreffixURL + "getQuestion" }
    
    //bu serivisin sonuna 1-2-3-4-5 ekleyerek 5 soruyu sırayla alıyorum getQuestion1,getQuestion2,getQuestion3 gibi
    /*parametreler:
        yok
     
     result
     {
        "status": true,
        "soru": "Mustafa Kemal Atatürk hangi yılda doğmuştur?",
        "cevaplar":[ "1801", "1881", "1818","1181" ], //istenildiği kadar cevap eklebilir.
        "dogruCevap": "1881",
        "soruSira": 1,
        "toplamSoru": 5
     }*/
    
    class var mGetResultsURL: String                 { return mPreffixURL + "getResults" }
    
    /*parametreler:
     id: String
     
     result
     {
     "status": true,
     "kazanilanPara": "15 TL",
     "  kazananlar": ["Mustafa Kemal Atatürk", "İsmet İnönü", "Albert Einstein"]
     }*/
    
    class var mUseWildCardURL: String                { return mPreffixURL + "useWildCard" }
    /*parametreler:
        id: String
     
     result
     {
        "status": true,
        "kullanildi": true,
        "kalanWildCard": "4"
     }*/
    
    class var mSendAnswerURL: String                 { return mPreffixURL + "sendAnswer" }
    /*parametreler:
        cevap: String
        id: String
    
    result
    {
        "status": true,
        "cevap": true,
        "dogruCevap": "2005"
    }*/
    
    
    

}
