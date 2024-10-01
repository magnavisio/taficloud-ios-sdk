//
//  MultipartFormData.swift
//  Taficloud
//
//  Created by Adedamola Adeyemo on 01.10.24.
//

import Foundation

class MultipartFormData {
    var boundary: String
    var data: Data

    init() {
        boundary = UUID().uuidString
        data = Data()
    }

    func append(_ data: Data, withName name: String, fileName: String, mimeType: String) {
        self.data.append("--\(boundary)\r\n".data(using: .utf8)!)
        self.data.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        self.data.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        self.data.append(data)
        self.data.append("\r\n".data(using: .utf8)!)
    }

    func append(_ data: Data, withName name: String) {
        self.data.append("--\(boundary)\r\n".data(using: .utf8)!)
        self.data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
        self.data.append(data)
        self.data.append("\r\n".data(using: .utf8)!)
    }

    func finish() -> Data {
        self.data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return self.data
    }
}
