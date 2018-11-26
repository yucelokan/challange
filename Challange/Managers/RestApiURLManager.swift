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
    class var mGetQuestionsURL: String               { return mPreffixURL + "getQuestion" }
    class var mGetResultsURL: String                 { return mPreffixURL + "getResults" }
    class var mUseWildCardURL: String                { return mPreffixURL + "useWildCard" }
    class var mSendAnswerURL: String                 { return mPreffixURL + "sendAnswer" }
    
    
    

}
