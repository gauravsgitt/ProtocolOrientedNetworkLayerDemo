//
//  GalleryAPIHandler.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

struct GalleryAPIHandler: APIHelper, RequestHandler, ResponseHandler {
    
    
    func makeRequest(param: [String: Any]?, urlVersion: APIVersion, endPoint: EndPoints?) -> URLRequest? {
        let urlString =  completeUrl(version: urlVersion, endPoint: endPoint)
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            if let param = param {
                guard let _ = try? setRequestBody(parameters: param, request: &urlRequest) else {
                    return nil
                }
            }
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        return try defaultParseResponse(data: data,response: response)
    }
}
