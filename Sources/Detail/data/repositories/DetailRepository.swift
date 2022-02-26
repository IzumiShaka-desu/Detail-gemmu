//
//  File.swift
//  
//
//  Created by Akashaka on 26/02/22.
//
import Favorite
protocol DetailGamesRepositoryProtocol {
  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error>
  func addOrDeleteFavoriteGame(favoritedGame: FavoriteGame, isFavorited: Bool)
  func isGameFavorited(for id: Int) -> AnyPublisher<Bool, Error>

}
public final class DetailGamesRepository: NSObject {
  typealias GamesInstance = (DetailDataSourceProtocol, LocaleDataSourceProtocol) -> DetailGamesRepository

  fileprivate let remote: DetailDataSourceProtocol
  fileprivate let local: LocaleDataSourceProtocol
  private init( remote: DetailDataSourceProtocol, local: LocaleDataSourceProtocol) {
    self.remote = remote
    self.local = local
  }

  static let sharedInstance: GamesInstance = {remoteRepo, localRepo in
    return DetailGamesRepository(remote: remoteRepo, local: localRepo)
  }

}
extension DetailGamesRepository: DetailGamesRepositoryProtocol {
  func getDetailGame(for id: Int) -> AnyPublisher<GameDetailEntity, Error> {
    return self.remote
      .getDetailGame(for: id)
      .map({$0.toEntity()})
      .eraseToAnyPublisher()
  }
  func isGameFavorited(for id: Int) -> AnyPublisher<Bool, Error> {
    return self.locale
      .isGameFavorited(for: id)
      .eraseToAnyPublisher()
  }
  func addOrDeleteFavoriteGame(favoritedGame: FavoriteGame, isFavorited: Bool) {
    self.locale
      .addOrDeleteFavoriteGame(
        favoritedGame: favoritedGame,
        isFavorited: isFavorited
      )
  }
}
