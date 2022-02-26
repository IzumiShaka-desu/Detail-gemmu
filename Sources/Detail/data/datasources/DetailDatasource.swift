//
//  HomeDatasources.swift
//  
//
//  Created by Akashaka on 25/02/22.
//


import Foundation
import Alamofire
import Combine
import Common

public protocol DetailDataSourceProtocol: AnyObject {
  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailResponse, Error>
}
public final class DetailRemoteDataSource: NSObject {

  private override init() { }

 public static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}
extension DetailRemoteDataSource: DetailDataSourceProtocol {
  public func getDetailGame(for id: Int) -> AnyPublisher<GameDetailResponse, Error> {
    return Future<GameDetailResponse, Error> { completion in
      if let url = API.buildUrl(endpoint: .games, param: "/\(id)") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameDetailResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
  
  
}
