//
//  GalleryViewModel.swift
//  NetworkLayerDemo
//
//  Created by Gaurav Bisht on 24/06/23.
//

import Foundation

import Foundation

class GalleryViewModel: DataModelProtocol {
    
    private let galleryAPIHandler: GalleryAPIHandler
    private let apiLoader: APILoader
    
    init(galleryAPIHandler: GalleryAPIHandler, apiLoader: APILoader) {
        self.galleryAPIHandler = galleryAPIHandler
        self.apiLoader = apiLoader
    }
    
    func getGalleryList(completion: @escaping (_ resposeData: Gallery?, _ error: ServiceError?) -> Void) {
        guard let urlRequest = galleryAPIHandler.makeRequest(param: nil, urlVersion: .v2, endPoint: .galleryList) else {
            completion(nil, ServiceError(httpStatus: -1, message: RequestBodyFailure))
            return
        }
        
        apiLoader.loadGETAPIRequest(urlRequest: urlRequest) { (responseJSON, error) in
            if let error = error {
                completion(nil, error)
            } else if let responseJSON = responseJSON {
                if let galleryModel = self.decode(dataDict: responseJSON, ofType: Gallery.self) {
                    completion(galleryModel, nil)
                } else {
                    completion(nil, ServiceError(httpStatus: -1, message: JSONSerializationFailed))
                }
            } else {
                completion(nil, ServiceError(httpStatus: -1, message: SOME_ERROR_OCCURRED))
            }
        }
    }
    
    private func galleryAPIParameter() -> [String: Any]? {
        return nil
    }
}
