//
//  BrandDetector.swift
//  FinSub
//
//  Created by Michael on 12/03/26.
//

import Foundation

struct Brand {
    var domain : String
    var width : Int?
    var height : Int?
}

class BrandDetector : BrandDetectorProtocol {
    var baseURL = "https://cdn.brandfetch.io"
    var clientId : String
    
    init(clientId : String){
        self.clientId = clientId
    }
    
    func buildURL ( params : Brand) -> URL? {
        
        var path = "/\(params.domain)"
        
//        if let width = params.width, let height = params.height {
//            path += "/w/\(params.width)/h/\(params.height)"
//        }
        
        var component = URLComponents(string: baseURL + path)
        component?.queryItems = [URLQueryItem(name: "c", value: clientId)]
        
        return component?.url
    }
}


