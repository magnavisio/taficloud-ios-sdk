//
//  MediaResponse.swift
//  Taficloud
//
//  Created by Adedamola Adeyemo on 01.10.24.
//

import Foundation

public struct BaseResponse<T: Decodable>: Decodable {
    public let statusCode: Int
    public let message: String
    public let data: T
}

public struct MultipleMedia: Codable {
    public let media: [Media]
}

// Data model for the file
public struct Media: Codable {
    public let id: Int
    public let organizationId: Int
    public let name: String
    public let url: String
    public let key: String
    public let bucket: String
    let mimetype: String
    let size: Double
    let updatedAt: String
    let createdAt: String
}

public struct MediaMetadata: Decodable {
    public let format: String
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
