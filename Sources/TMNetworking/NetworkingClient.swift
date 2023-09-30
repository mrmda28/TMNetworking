//
//  NetworkingClient.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Alamofire
import TMEndpoints

public final class NetworkingClient: Networking {
    
    // MARK: - Properties
    
    private let baseURL = "https://crm.tba.one/"
    
    // MARK: - Initializet
    
    public static let shared = NetworkingClient()
    private init() { }
    
    // MARK: - Methods
    
    public func request<Response: Decodable>(_ endpoint: Endpoint<Response>, _ parameters: Parameters?) async throws -> Response {
        try await AF.request(
            "\(baseURL)\(endpoint.path)",
            method: endpoint.method,
            parameters: parameters
        )
        .validate()
        .serializingDecodable(Response.self)
        .value
    }
}
