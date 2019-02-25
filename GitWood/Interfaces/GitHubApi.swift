//
//  GitHubApi.swift
//  GitWood
//
//  Created by Nour on 23/02/2019.
//  Copyright © 2019 Nour Saffaf. All rights reserved.
//

import Foundation

enum ApiError: Error {
    case ErrorConstrcutURL(String)
    case ErrorDecodeResponse(String)
    case ErrorNoResults(String)
    case ErrorHttpCode(String)
}

//Current Git API supports version 3 , to void refactoring, create another interface around the versioning
enum ApiVersion {
    case v3
    var model: APIModel {
        switch self {
        case .v3:
            return API3Model()

        }
    }
    
}

protocol APIModel {
    static var version: Int {get}
    var token: String? {get}
    static var baseUrl:String {get}
    func buildRequestUrl(_ requestType: RequestType, page: Int) throws -> URL
    func decode(response: Data, for responseType: ResponseType) throws -> [RepoModel]
    func validate(response: (HTTPURLResponse,Data)) throws -> Bool
}


extension APIModel {
    func validate(response: (HTTPURLResponse,Data)) throws -> Bool {
        let (httpResponse, data) = response
        
        if data.isEmpty {
           return false
        }
        
        if 200..<300 ~= httpResponse.statusCode {
            return true
        } else {
            throw ApiError.ErrorHttpCode(response.0.statusCode.description)
        }
    }
}
