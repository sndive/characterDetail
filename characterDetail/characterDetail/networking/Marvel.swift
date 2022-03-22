//
//  Marvel.swift
//  characterDetail
//
//  Created by Anton Tropashko on 21.03.2022.
//

import Foundation
import Moya

public enum Marvel {
    static private let publicKey = "bbb3e6765cd8478af66ba381b97eb87e"
    static private let privateKey = "9578a0afe3b666a348617ecfe5b50e81c901af1c"

    case characters(Int, Int)
    case characterDetails(Int64)
}

extension Marvel: TargetType {
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    
    public var path: String {
        switch self {
        case .characters(_,_):
            return "/characters"
        case .characterDetails(let id): return "/characters/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        default: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        // God bless Ray Wenderlinch and it's humble peons
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        
        let authParams: [String : Any] = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
        
        switch self {
        case .characters(let offset, let limit):
            let keepingCurrent = [
                "offset": offset,
                "limit": limit
            ] + authParams //.merging(authParams) { (current, _) in current }
            return .requestParameters(
                parameters: keepingCurrent,
                encoding: URLEncoding.default)
        case .characterDetails(let cid):
            let keepingCurrent = [ "characterId" : cid ] + authParams
            return .requestParameters(
                parameters: keepingCurrent,
                encoding: URLEncoding.default)
        }
    }

    public var headers: [String: String]? {
      return ["Content-Type": "application/json"]
    }

    public var validationType: ValidationType {
      return .successCodes
    }
    
//    public var encoding: Moya.ParameterEncoding {
//        if self.method == .get || self.method == .head {
//            return URLEncoding()
//        }
//        else {
//            return JSONEncoding()
//        }
//    }
}
