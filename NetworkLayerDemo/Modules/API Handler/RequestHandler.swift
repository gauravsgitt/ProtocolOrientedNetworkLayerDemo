//
//  RequestHandler.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

protocol RequestHandler {
    func makeRequest(param: [String: Any]?, urlVersion: APIVersion, endPoint: EndPoints?) -> URLRequest?
}

// MARK: Request Handler Supporting methods
extension RequestHandler {
    
    func setRequestBody(parameters:[String: Any], request: inout URLRequest) throws {
        do {
            let parameters = try JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = parameters
        } catch {
            throw error
        }
    }
    /*
     func setQueryParams(parameters:[String: Any], url: URL) -> URL {
         var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
         components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value) ) }
         return components?.url ?? url
     }
     */
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(APIHeaders.ContentType.headerValue, forHTTPHeaderField: APIHeaders.ContentType.headerField)
    }
}
