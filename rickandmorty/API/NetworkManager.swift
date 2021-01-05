//
//  EndpointsRepository.swift
//  rickandmorty
//
//  Created by Tiago Mattos dos Santos on 26/11/20.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

class NetworkManager {
    let session = URLSession.shared
    
    func getCharactersList(url: String, completion: @escaping (_ characters: Characters?,_ error: String?)->()) {
        session.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Characters.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }).resume()
    }
    
    func getEpisodesList(url: String, completion: @escaping (_ episodes: Episodes?,_ error: String?)->()) {
        session.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Episodes.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }).resume()
    }
    
    func getEpisode(url: String, completion: @escaping (_ episode: Episode?,_ error: String?)->()) {
        session.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(Episode.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }).resume()
    }
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image! 😢")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
            switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
            case 600: return .failure(NetworkResponse.outdated.rawValue)
            default: return .failure(NetworkResponse.failed.rawValue)
            }
        }
}
