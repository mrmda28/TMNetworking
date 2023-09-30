//
//  TokenStorage.swift
//
//
//  Created by Dmitry Maslennikov on 30.09.2023.
//

import Foundation

public protocol TokenStorage: AnyObject {
    var accessToken: String? { get set }
}
