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
    
    private let baseURL = "https://app.logwork.io/"
    private let authInterceptor: RequestInterceptor
    
    public var accessTokenStorage: TokenStorage
    
    // MARK: - Initializet
    
    public static let shared = NetworkingClient()
    
    private init() {
        accessTokenStorage = KeychainTokenStorage()
        authInterceptor = AuthInterceptor(tokenStorage: accessTokenStorage)
    }
    
    // MARK: - Methods
    
    public func request<Response: Decodable>(
        _ endpoint: Endpoint<Response>,
        _ parameters: Parameters? = nil,
        _ withRefreshingToken: Bool = true
    ) async throws -> Response {
        
        try await AF.request(
            "\(baseURL)\(endpoint.path)",
            method: endpoint.method,
            parameters: parameters,
            interceptor: withRefreshingToken ? authInterceptor : nil
        )
        .validate()
        .serializingDecodable(Response.self)
        .value
    }
}
