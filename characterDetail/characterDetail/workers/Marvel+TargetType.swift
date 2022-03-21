//
//  Marvel+TargetType.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation

extension Marvel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .comics: return "/comics"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .comics: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain // TODO
    }

    public var headers: [String: String]? {
      return ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
      return .successCodes
    }
}
