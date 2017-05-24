//
//  Connect.swift
//  Game of Life
//
//  Created by Dan Beaulieu on 12/20/15.
//  Copyright © 2015 Dan Beaulieu. All rights reserved.
//

import Foundation
import Alamofire


class Connect {

    
    static func postNewScore() {
        let parameters = [
            "Moves": 25500,
            "UserName" : "Lifes Bot"
        ] as [String : Any]
       
        Alamofire.request("https://danbeaulieu.azurewebsites.net/postscore", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseString {
            response in
            print("Response String: \(String(describing: response.result.value))")
        }
    }

    func getAllScores(completion: @escaping (_ result: AnyObject) -> ()) {
        Alamofire.request("https://danbeaulieu.azurewebsites.net/api/scores", method: .get, parameters: nil).responseJSON {
            response in
            // Con GCD
            DispatchQueue.global().async {
                print("status \(String(describing: response.response))")
                
                if let JSON = response.result.value {
                    print(JSON)
                    completion(JSON as AnyObject)
                }
            }
/*            let backgroundQueue = OperationQueue()
            backgroundQueue.addOperation() {
                print("status \(String(describing: response.response))")
                
                if let JSON = response.result.value {
                    print(JSON)
                    completion(JSON as AnyObject)
                }
            } */
        }
    }
}


/*
let qualityOfServiceClass = QOS_CLASS_BACKGROUND
let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
dispatch_async(backgroundQueue, {
})
*/
