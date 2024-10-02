# Taficloud IOS SDK

This is a Swift-based library for interacting with Taficloud services, allowing you to upload files, download files, merge files, and manage media metadata through an intuitive API. This package supports both CocoaPods and Swift Package Manager (SPM) for iOS.

## Features

- **File Upload**: Upload files directly to Taficloud.
- **Base64 Upload**: Upload files as base64 encoded strings.
- **File Download**: Download media files from Taficloud.
- **Merge Files**: Upload multiple files and merge them into a single file on the server.
- **Fetch Media Metadata**: Fetch metadata such as format, size, dimensions, etc., of media files.
- **Convert Media Format**: Convert media files from one format to another (e.g., PNG to JPEG).

## Installation

### Swift Package Manager (SPM)

To install via SPM, add this line to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/magnavisio/taficloud-ios-sdk, from: "0.0.3")
]
```

### CocoaPods

To install via CocoaPods, add this line to your `Podfile`:

```ruby
pod 'Taficloud', '~> 1.0.0'
```

Then, run:

```bash
pod install
```

## Usage

### Initialization

To use the library, initialize it with your API key:

```swift
import Taficloud

let taficloud = Taficloud(apiKey: "your-api-key")
```

### Upload File

Upload a file to Taficloud:

```swift
let fileData = Data([1, 2, 3]) // Example file data
let uploadedFile = try await taficloud.upload(file: fileData, fileName: "example.txt", folder: "test-folder")
print("Uploaded file URL: \(uploadedFile.data.url)")
```

### Upload Base64 File

Upload a base64 encoded file:

```swift
let base64String = fileData.base64EncodedString()
let uploadedBase64File = try await taficloud.uploadBase64(file: base64String, fileName: "example.txt", folder: "test-folder")
print("Uploaded Base64 file URL: \(uploadedBase64File.data.url)")
```

### Fetch Media Metadata

Fetch metadata for a specific media file using its media key:

```swift
let mediaMetadata = try await taficloud.fetchMediaMetadata(mediaKey: "media-key")
print("Media format: \(mediaMetadata.data.format)")
```

### Convert Media Format

Convert a media file to a different format (e.g., PNG to JPEG):

```swift
let convertedMedia = try await taficloud.convertMedia(mediaKey: "media-key", format: "jpeg")
print("Converted media URL: \(convertedMedia.data.url)")
```

### Merge Files

Upload and merge multiple files into a single file:

```swift
let files = [Data([1, 2, 3]), Data([4, 5, 6])]
let mergedFile = try await taficloud.mergeFiles(files: files, fileName: "merged-file.txt", folder: "merged-folder")
print("Merged file URL: \(mergedFile.data.url)")
```

## Functions

### `upload(file:fileName:folder:)`

Uploads a file to Taficloud.

- **file**: The file data to upload as `Data`.
- **fileName**: The name of the file.
- **folder**: (Optional) The folder where the file will be uploaded.

### `uploadBase64(file:fileName:folder:)`

Uploads a base64-encoded file.

- **file**: The base64-encoded file as a `String`.
- **fileName**: The name of the file.
- **folder**: (Optional) The folder where the file will be uploaded.

### `fetchMediaMetadata(mediaKey:)`

Fetches metadata for a specific media file.

- **mediaKey**: The unique key of the media file.

### `convertMedia(mediaKey:format:)`

Converts a media file to a different format.

- **mediaKey**: The unique key of the media file.
- **format**: The desired output format (e.g., `jpeg`, `png`).

### `mergeFiles(files:fileName:folder:)`

Uploads and merges multiple files into a single file.

- **files**: The array of files as `Data` to be merged.
- **fileName**: The name of the merged file.
- **folder**: (Optional) The folder where the merged file will be saved.

## Error Handling

All functions throw errors in case of failure, and they can be caught using Swift’s `do-catch` syntax.

Example:

```swift
do {
    let uploadedFile = try await taficloud.upload(file: fileData, fileName: "example.txt", folder: "test-folder")
    print("Uploaded file URL: \(uploadedFile.data.url)")
} catch {
    print("Error uploading file: \(error.localizedDescription)")
}
```

## License

Taficloud is available under the MIT License. See the LICENSE file for more info.
