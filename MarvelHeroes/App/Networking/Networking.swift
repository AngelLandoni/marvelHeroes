//
//  Networking.swift
//  MarvelHeroes
//
//  Created by Angel Land on 5/27/17.
//  Copyright © 2017 Landoni Angel. All rights reserved.
//

import Alamofire
import CryptoSwift

final class Networking {
    /// This method loads all the charecters by name.
    /// - parameters: withName: Name of the character.
    /// - parameters: success: Callback used when the call success.
    /// - parameters: fail: Callback used when the call fails.
    static func loadCharacters(withName name: String,
                               success: @escaping ([HeroBasicModel]) -> Void,
                               fail: () -> Void) {
        let finalUrl: String =
            NetConstants.baseURL +
            NetConstants.apiVersion +
            NetConstants.charectersEndPoint
        
        var parameters: [String:String] = getBasicParemeters()
        
        parameters["nameStartsWith"] = name
        
        Alamofire.request(finalUrl,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding(),
                          headers: nil).responseJSON { response in
            if let JSON = response.result.value {
                // Search the data needed.
                // TODO: Fix me!, Base the data parse in models.
                let jsonData: [String:Any] = JSON as! [String:Any]
                let jsonSubData: [String:Any] = (jsonData["data"] as! [String:Any])
                // Final list of heroes.
                var heroes: [HeroBasicModel] = []
                // Map the data.
                for item in (jsonSubData["results"] as! Array<[String:Any]>) {
                    let data: HeroBasicModel = HeroBasicModel(withDictionary: item)
                    heroes.append(data)
                }
                // Call the success method
                success(heroes)
            }
        }
    }
    
    /// This method generates the basic parameters used to 
    /// call the service.
    /// - returns: A dictionary with the specific parameters
    private static func getBasicParemeters() -> [String:String] {
        let timeStamp: String = Time.getCurrentTimestamp()
        return [
            "ts": timeStamp,
            "apikey": NetConstants.publicKey,
            "hash": generateToken(timeStamp: timeStamp)
        ]
    }
    
    /// This method generates the token used to validate 
    /// the request.
    /// - Algorithm: md5(ts+privateKey+publicKey)
    /// - parameters: timeStamp: Current time.
    private static func generateToken(timeStamp: String) -> String {
        return (timeStamp +
        NetConstants.privateKey +
        NetConstants.publicKey).md5()
    }
}
