// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

@available(iOS 13.0, *)
public class TafiCloud {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    //private let baseUrl = "https://stash.taficloud.com/media"
    private let baseUrl = "https://dev-stash.taficloud.com/media"
    
    
    public func upload(file: Data, fileName: String, folder: String?) async throws -> BaseResponse<Media> {
        let url = URL(string: "\(baseUrl)/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        // Prepare the request body
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        if let folder {
        // Append the folder to the form data
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"folder\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(folder)\r\n".data(using: .utf8)!)
        }
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8)!)
        body.append(file)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        // Send the request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError(statusCode: -1, message: "Invalid response")
        }
        if (200...299).contains(httpResponse.statusCode) {
            let uploadResponse = try JSONDecoder().decode(BaseResponse<Media>.self, from: data)
            return uploadResponse
        } else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let errorMessage = errorResponse?.message ?? "Unknown error"
            throw UploadError(statusCode: httpResponse.statusCode, message: errorMessage)
        }
    }
    
    
    func fetchMediaMetadata(mediaKey: String) async throws -> BaseResponse<MediaMetadata> {
        let url = URL(string: "\(baseUrl)/metadata?mediaKey=\(mediaKey)")! // Replace with your actual URL
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)

        // Handle the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError(statusCode: -1, message: "Invalid response")
        }

        if (200...299).contains(httpResponse.statusCode) {
            // Successful response
            let mediaMetadataResponse = try JSONDecoder().decode(BaseResponse<MediaMetadata>.self, from: data)
            return mediaMetadataResponse
        } else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let errorMessage = errorResponse?.message ?? "Unknown error"
            throw UploadError(statusCode: httpResponse.statusCode, message: errorMessage)
        }
    }
    
    @available(iOS 13.0, *)
    func convertMedia(mediaKey: String, format: String) async throws -> BaseResponse<Media> {
        let url = URL(string: "\(baseUrl)/convert")! // Replace with your actual URL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the JSON payload
        let payload: [String: Any] = [
            "mediaKey": mediaKey,
            "format": format
        ]
        
        // Convert payload to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])

        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        // Handle the response
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])
        }

        if (200...299).contains(httpResponse.statusCode) {
            // Successful response
            let mediaResponse = try JSONDecoder().decode(BaseResponse<Media>.self, from: data)
            return mediaResponse
        } else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let errorMessage = errorResponse?.message ?? "Unknown error"
            throw UploadError(statusCode: httpResponse.statusCode, message: errorMessage)
        }
    }

    
    func mergeFiles(files: [Data]) async throws -> BaseResponse<MultipleMedia> {
        let formData = MultipartFormData()

        // Add files to the form data
        for (index, file) in files.enumerated() {
            formData.append(file, withName: "files[]", fileName: "file\(index + 1).txt", mimeType: "application/octet-stream")
        }
        
        let url = URL(string: "\(baseUrl)/upload/multiple")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(formData.boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = formData.finish()
        
        // Send the request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError(statusCode: -1, message: "Invalid response")
        }
        if (200...299).contains(httpResponse.statusCode) {
            let uploadResponse = try JSONDecoder().decode(BaseResponse<MultipleMedia>.self, from: data)
            return uploadResponse
        } else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let errorMessage = errorResponse?.message ?? "Unknown error"
            throw UploadError(statusCode: httpResponse.statusCode, message: errorMessage)
        }
    }

}
