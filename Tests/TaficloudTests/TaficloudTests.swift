import XCTest
@testable import Taficloud

final class TaficloudTests: XCTestCase {
    // let apiKey = "YOUR_API_KEY" // Replace with your actual API key
    let apiKey = "Kyo9MAJszbSUWzw4N9CfuCNfi9f5Ap5Q"
    let mediakey = "magnavisio/Cloud upload-d69c355e85cf6cc17810a3bc11cedcba6.png"
    
    func testUpload() async {
        let basicFile = Data([1, 2, 3])
        let taficloud = TafiCloud(apiKey: apiKey)

        do {
            // Act
            let response = try await taficloud.upload(file: basicFile, fileName: "random_test.txt", folder: "test")
            
            XCTAssertEqual(response.statusCode, 201, "Upload failed with status code \(response.statusCode)")
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
            let response = try await taficloud.mergeFiles(files: [basicFile, secondFIle])
            
            print("Media uploaded count : \(response.data.media.count)")
            XCTAssertEqual(response.statusCode, 200, "Upload failed with status code \(response.statusCode)")
        } catch let error as UploadError {
            XCTFail("Upload failed: \(error.localizedDescription)")
        } catch {
            print("An unexpected error occurred: \(error)")
        }
    }
}
