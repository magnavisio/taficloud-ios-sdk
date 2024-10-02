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
    public let mimetype: String
    public let size: Double
    public let updatedAt: String
    public let createdAt: String
}

public struct MediaMetadata: Decodable {
    public let format: String
    public let size: Int
    public let width: Int
    public let height: Int
    public let space: String
    public let channels: Int
    public let depth: String
    public let density: Int
    public let isProgressive: Bool
    public let hasProfile: Bool
    public let hasAlpha: Bool
}

public struct ErrorResponse: Decodable {
    public let statusCode: Int
    public let path: String
    public let message: String
}

public struct UploadError: Error {
    public let statusCode: Int
    public let message: String

    public var localizedDescription: String {
        return "Error \(statusCode): \(message)"
    }
}
