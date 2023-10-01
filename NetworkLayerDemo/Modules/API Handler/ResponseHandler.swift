//
//  ResponseHandler.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

struct ServiceError: Error,Codable {
    let httpStatus: Int
    let message: String
}

protocol ResponseHandler {
    func parseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T
}

// MARK: - Response Handler Supporting methods
extension ResponseHandler {
    func defaultParseResponse<T: Codable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            if response.statusCode == 200 {
                return body
            } else {
                throw ServiceError(httpStatus: response.statusCode, message: "Unknown Error")
            }
        } catch {
            throw ServiceError(httpStatus: response.statusCode, message: error.localizedDescription)
        }
        
    }
}
