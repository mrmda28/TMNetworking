//
//  Networking.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Alamofire
import TMEndpoints

public protocol Networking {
    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>,
        _ parameters: Parameters?
    ) async throws -> Response
}

public extension Networking {
    func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>,
        _ parameters: Parameters? = nil
    ) async throws -> Response {
        try await request(endpoint, parameters)
    }
}
