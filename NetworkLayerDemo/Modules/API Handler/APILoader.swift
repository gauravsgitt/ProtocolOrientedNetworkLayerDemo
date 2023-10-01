//
//  APILoader.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

struct APILoader {
    
    private let urlSession: URLSession = .shared
    
    //MARK: - GET API Request
    func loadGETAPIRequest(urlRequest: URLRequest, completionHandler: @escaping (Any?, ServiceError?) -> ()) {
        
        debugPrint("URL===========", urlRequest.url?.absoluteString ?? "")
        debugPrint("Header===========", urlRequest.allHTTPHeaderFields ?? NIL)
        if let body = urlRequest.httpBody, let param = try? JSONSerialization.jsonObject(with: body) as? [String: Any] {
            debugPrint("Body===========", param)
        }
        
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                debugPrint("Response===========", httpResponse)
                guard error == nil else {
                    completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? SOME_ERROR_OCCURRED)"))
                    return
                }
                
                guard let responseData = data else {
                    completionHandler(nil, ServiceError(httpStatus: httpResponse.statusCode, message: "ServiceError : \(error?.localizedDescription ?? SOME_ERROR_OCCURRED)"))
                    return
                }
                
                do {
                    let parsedResponse = try JSONSerialization.jsonObject(with: responseData)
                    completionHandler(parsedResponse, nil)
                    debugPrint("ResponseData===========", parsedResponse)
                } catch {
                    debugPrint("Error===========", "ServiceError : \(error.localizedDescription)")
                    completionHandler(nil, ServiceError(httpStatus:  httpResponse.statusCode, message: "ServiceError : \(error.localizedDescription)"))
                }
            } else {
                completionHandler(nil, ServiceError(httpStatus: -1, message: SOME_ERROR_OCCURRED))
            }
        }.resume()
    }
}
