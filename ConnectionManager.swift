//
//  ConnectionManager.swift
//  Flyerbin
//
//  Created by Beegains-PC on 8/14/19.
//  Copyright © 2019 Beegains-PC. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

struct ConnectionToServer {
    
    static func makePOSTCall(URL_STRING : String,parameters : [String:Any],completionHandler: @escaping ([String : AnyObject]?, Error?) -> ()) {
        
        let URL = try! URLRequest(url: URL_STRING, method: .post)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters
            {
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
        }, with: URL, encodingCompletion:
            {
                encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
                        completionHandler(response.result.value  as? [String:AnyObject], nil)
                    }
                case .failure(let encodingError):
                    
                    completionHandler(nil,encodingError)
                }
        })
    }
    
    
    static func makeGETCall(URL_STRING : String,parameters : [String:Any],completionHandler: @escaping (AnyObject?, Error?) -> ()) {
        
        let URL = try! URLRequest(url: URL_STRING, method: .get)
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters
            {
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
        }, with: URL, encodingCompletion:
            {
                encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if response.response?.statusCode == 200 {
                            completionHandler(["statusCode":200,"result":response.result.value]  as? AnyObject, nil)
                        } else if response.response?.statusCode == 204 {
                            completionHandler(["statusCode":204,"result":"empty"]  as? AnyObject, nil)
                        }
                        
                    }
                case .failure(let encodingError):
                    
                    completionHandler(nil,encodingError)
                }
        })
        
    }
    
    
    static func makePOSTCallJsonEncoding(parameters:[String:Any],RequestingURL:String,completionHandler: @escaping ([String : AnyObject]?) -> ())
    {
        Alamofire.request(RequestingURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            
            .responseJSON { response in
                if (response.response?.statusCode) != nil {
                    
                    switch (response.response?.statusCode) {
                    case 200:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"success" as AnyObject])
                    case 500:
                        
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        break
                        
                    default:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        
                    }
                    
                }
                
        }
    }
    static func makeGETCallJsonEncoding(parameters:[String:Any],RequestingURL:String,completionHandler: @escaping ([String : AnyObject]?) -> ())
    {
        Alamofire.request(RequestingURL, method: .get, parameters: nil, encoding: JSONEncoding.default)
            
            .responseJSON { response in
                
                if (response.response?.statusCode) != nil {
                    
                    switch (response.response?.statusCode) {
                    case 200:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"success" as AnyObject])
                    case 500:
                        
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        break
                        
                    default:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        
                    }
                    
                }
                
        }
    }
    
    
    
    
    static func makeGETCallJsonEncodingWithHeader(parameters:[String:Any],RequestingURL:String,header:[String:String],completionHandler: @escaping ([String : AnyObject]?) -> ())
    {
        
        Alamofire.request(RequestingURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
            
            .responseJSON { response in
                
                if (response.response?.statusCode) != nil {
                    
                    switch (response.response?.statusCode) {
                    case 200:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"success" as AnyObject])
                    case 500:
                        
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        break
                        
                    default:
                        completionHandler(["result":(response.result.value)  as AnyObject,"status":"failed" as AnyObject])
                        
                    }
                    
                }
                
        }
    }
    static func makePOSTCallJsonEncodingWithHeader(parameters:[String:Any],header:[String:String],RequestingURL:String,completionHandler: @escaping ([String : AnyObject]?) -> ())
    {
        Alamofire.request(RequestingURL, method: .post, parameters: parameters,encoding: JSONEncoding.default, headers:header).responseJSON {
            response in
            switch response.result {
            case .success:
                completionHandler(["result":(response.result.value)  as AnyObject,"status":"success" as AnyObject] )
                break
            case .failure(let error):
                completionHandler(["result":(error.localizedDescription)  as AnyObject,"status":"failed" as AnyObject])
            }
        }
        
    }
}
