//
//  Network.swift
//  NikeAssessment
//
//  Created by Pendyala Revanth on 9/22/20.
//

import UIKit


struct Network {

    typealias DataTaskCompletion = (Result<Decodable, NetworkErrors>) -> Void
    typealias DownloadTaskCompletion = (Result<UIImage, NetworkErrors>) -> Void

    private let session = URLSession.shared
    
    struct Constants {
        static let baseURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/100/explicit.json"
        static let imageConstant = "image"
    }

    func dataTask<Request: RequestProtocol>(_ request: Request, _ completion: @escaping DataTaskCompletion) {
        guard let url = URL(string: request.url) else {
            completion(.failure(.invalidURL))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard let _ = response as? HTTPURLResponse,
                  let unwrappedData = data  else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let response = try JSONDecoder().decode(Request.ResponseType.self, from: unwrappedData)
                completion(.success(response))
            }
            catch {
                completion(.failure(.parsingFailed))
            }
        }
        task.resume()
    }

    func downloadTask(urlString: String, _ completion: @escaping DownloadTaskCompletion) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethods.get.rawValue
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  let mimeType = httpResponse.mimeType, mimeType.hasPrefix(Constants.imageConstant),
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data)
            else {
                completion(.failure(.requestFailed))
                return
            }
            completion(.success(image))
        }
        task.resume()
        return task
    }
}

enum NetworkErrors: Error {
    case invalidURL
    case requestFailed
    case parsingFailed
}

protocol RequestProtocol {
    associatedtype ResponseType: Decodable
    var url: String { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethods { get }
}
