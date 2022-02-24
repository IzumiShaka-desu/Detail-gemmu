//
//  ParentPlatform.swift
//  gemmu
//
//  Created by Akashaka on 09/02/22.
//
public struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
public struct PlatformElement: Codable {
    let platform: PlatformSpesific
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

  public   enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }
}
