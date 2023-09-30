//
//  Networking.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Alamofire
import TMEndpoints

public protocol Networking: AnyObject {
    
    var accessTokenStorage: TokenStorage { get }
    
    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>,
        _ parameters: Parameters?,
        _ withRefreshingToken: Bool
    ) async throws -> Response
}

public extension Networking {
    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>,
        _ parameters: Parameters? = nil,
        _ withRefreshingToken: Bool = true
    ) async throws -> Response {
        try await request(endpoint, parameters, withRefreshingToken)
    }
}
