import XCTest
@testable import Taficloud

final class TaficloudTests: XCTestCase {
    let apiKey = "YOUR_API_KEY" // Replace with your actual API key
    let mediakey = "magnavisio/Cloud upload-d69c355e85cf6cc17810a3bc11cedcba6.png"
    let base64Sample = "data:image/png;base64,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"
    
    
    func testUpload() async {
        let basicFile = Data([1, 2, 3])
        let taficloud = TafiCloud(apiKey: apiKey)

        do {
            let response = try await taficloud.upload(file: basicFile, fileName: "random_test.txt", folder: "test")
            
            XCTAssertEqual(response.statusCode, 200, "Upload failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("Upload failed: \(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func testFetchMediaMetadata() async {
        let taficloud = TafiCloud(apiKey: apiKey)
        
        do {
            let response = try await taficloud.fetchMediaMetadata(mediaKey: mediakey)
            
            XCTAssertEqual(response.statusCode, 200, "fetch failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("\(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func testConvertMedia() async {
        let taficloud = TafiCloud(apiKey: apiKey)
        
        do {
            let response = try await taficloud.convertMedia(mediaKey: mediakey, format: "jpeg")
            
            XCTAssertEqual(response.statusCode, 200, "Convert failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("\(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func testUploadMultiple() async {
        let basicFile = Data([1, 2, 3])
        let secondFIle = Data([21, 32, 33])
        let taficloud = TafiCloud(apiKey: apiKey)

        do {
            // Act
            let response = try await taficloud.uploadMultipleFiles(files: [basicFile, secondFIle])
            
            print("Media uploaded count : \(response.data.media.count)")
            XCTAssertEqual(response.statusCode, 200, "Upload failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("Upload failed: \(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
    
    func testUploadBase64() async {
        let taficloud = TafiCloud(apiKey: apiKey)
        
        do {
            let response = try await taficloud.uploadBase64File(base64String: base64Sample, mimetype: "image/png", folder: nil)
            
            XCTAssertEqual(response.statusCode, 200, "Upload failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("Upload failed: \(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
}
