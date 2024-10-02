// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

@available(iOS 13.0, *)
public class TafiCloud {
    private let apiKey: String
    private let baseURL: URL
    
    public init(apiKey: String) {
        self.apiKey = apiKey
        self.baseURL = URL(string: "https://stash.taficloud.com/media")!
    }
    
    
    public func upload(file: Data, fileName: String, folder: String?) async throws -> BaseResponse<Media> {
        let endpoint = "upload"
        let formData = MultipartFormData()
        
        if let folder = folder {
            formData.append(folder.data(using: .utf8)!, withName: "folder")
        }
        
        formData.append(file, withName: "file", fileName: fileName, mimeType: "application/octet-stream")
        
        return try await createRequest(endpoint: endpoint, method: .post, formData: formData)
    }

    
    
    public func fetchMediaMetadata(mediaKey: String) async throws -> BaseResponse<MediaMetadata> {
        let endpoint = "metadata?mediaKey=\(mediaKey)"
        
        return try await createRequest(endpoint: endpoint, method: .get, formData: MultipartFormData())
    }

    
    public func convertMedia(mediaKey: String, format: String) async throws -> BaseResponse<Media> {
        let formData = MultipartFormData()
        formData.append(mediaKey.data(using: .utf8)!, withName: "mediaKey")
        formData.append(format.data(using: .utf8)!, withName: "format")

        return try await createRequest(endpoint: "convert", method: .post, formData: formData)
    }


    
    public func uploadMultipleFiles(files: [Data]) async throws -> BaseResponse<MultipleMedia> {
        let formData = MultipartFormData()

        // Add files to the form data
        for (index, file) in files.enumerated() {
            formData.append(file, withName: "files[]", fileName: "file\(index + 1).txt", mimeType: "application/octet-stream")
        }
        return try await createRequest(endpoint: "upload/multiple", method: .post, formData: formData)
    }
    
    // Upload base64-encoded files
    public func uploadBase64File(base64String: String, mimetype: String, folder: String?) async throws -> BaseResponse<Media> {
        let formData = MultipartFormData()

        formData.append(base64String.data(using: .utf8)!, withName: "file")
        formData.append(mimetype.data(using: .utf8)!, withName: "mimetype")

        if let folder = folder {
            formData.append(folder.data(using: .utf8)!, withName: "folder")
        }
        
        return try await createRequest(endpoint: "upload/base64", method: .post, formData: formData)
    }

    private func createRequest<T: Decodable>(endpoint: String, method: HTTPMethod, formData: MultipartFormData) async throws -> BaseResponse<T> {
        let url = baseURL.appendingPathComponent(endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(formData.boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = formData.finish()

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UploadError(statusCode: -1, message: "Invalid response")
        }
        if (200...299).contains(httpResponse.statusCode) {
            let uploadResponse = try JSONDecoder().decode(BaseResponse<T>.self, from: data)
            return uploadResponse
        } else {
            let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data)
            let errorMessage = errorResponse?.message ?? "Unknown error"
            throw UploadError(statusCode: httpResponse.statusCode, message: errorMessage)
        }
    }

}
