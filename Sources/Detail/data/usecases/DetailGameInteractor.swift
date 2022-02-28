//
//  DetailGameInteractor.swift
//  Gemmu
//
//  Created by Akashaka on 19/02/22.
//

import Foundation
import Combine
import Favorite

public protocol DetailGameUseCase {

  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error>
  func addOrDeleteFavorite(for game: GameDetailEntity, isFavorited: Bool)
  func isGameFavorited(by id: Int) -> AnyPublisher<Bool, Error>
}

public class DetailGameInteractor: DetailGameUseCase {
 public func isGameFavorited(by id: Int) -> AnyPublisher<Bool, Error> {
    return repository.isGameFavorited(for: id)
  }

 public func addOrDeleteFavorite(for game: GameDetailEntity, isFavorited: Bool) {
    let favoriteGame = FavoriteGame()
    favoriteGame.id = game.id
    favoriteGame.imageUrl = game.imageUrl
    favoriteGame.releaseDate = game.releaseDate
    favoriteGame.genres.append(objectsIn: game.genres)
    favoriteGame.name = game.name
    favoriteGame.rank = String(format: "%.1f", game.rating)
    return  repository
      .addOrDeleteFavoriteGame(
        favoritedGame: favoriteGame,
        isFavorited: isFavorited
      )
  }

  private let repository: DetailGamesRepositoryProtocol

  public init(repository: DetailGamesRepositoryProtocol) {
    self.repository = repository
  }

 public func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error> {
    return repository.getDetailGame(for: id)
  }

}
