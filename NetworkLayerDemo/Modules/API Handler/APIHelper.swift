//
//  APIHelper.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

//MARK: - HTTPMethod
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

//MARK: - APIHeaders
public enum APIHeaders {
    case ContentType
    
    var headerField: String {
        switch self {
        case .ContentType:
            return "Content-Type"
        }
    }
    
    var headerValue: String {
        switch self {
        case .ContentType:
            return "application/json"
        }
    }
}

//MARK: - Version
public enum APIVersion: String {
    case v1 = "/v1"
    case v2 = "/v2"
}

//MARK: - APIHelper
protocol APIHelper {}

extension APIHelper {
    //MARK: - URL
    func completeUrl(version: APIVersion, endPoint: EndPoints?) -> String {
        return "https://picsum.photos\(version.rawValue)\(endPoint?.rawValue ?? "")"
    }
}
