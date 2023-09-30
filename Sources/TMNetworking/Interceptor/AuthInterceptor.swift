//
//  AuthInterceptor.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Foundation
import Alamofire

final class AuthInterceptor: RequestInterceptor {
    
    private let tokenStorage: TokenStorage
    
    init(tokenStorage: TokenStorage) {
        self.tokenStorage = tokenStorage
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer \(tokenStorage.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
}
