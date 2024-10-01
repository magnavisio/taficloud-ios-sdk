//
//  MediaResponse.swift
//  Taficloud
//
//  Created by Adedamola Adeyemo on 01.10.24.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    let statusCode: Int
    let message: String
    let data: T
}

public struct MultipleMedia: Codable {
    let media: [Media]
}

// Data model for the file
public struct Media: Codable {
    let id: Int
    let organizationId: Int
    let name: String
    let url: String
    let key: String
    let bucket: String
    let mimetype: String
    let size: Double
    let updatedAt: String
    let createdAt: String
}

public struct MediaMetadata: Decodable {
    let format: String
    let size: Int
    let width: Int
    let height: Int
    let space: String
    let channels: Int
    let depth: String
    let density: Int
    let isProgressive: Bool
    let hasProfile: Bool
    let hasAlpha: Bool
}

public struct ErrorResponse: Decodable {
    let statusCode: Int
    let path: String
    let message: String
}

public struct UploadError: Error {
    let statusCode: Int
    let message: String

    var localizedDescription: String {
        return "Error \(statusCode): \(message)"
    }
}
