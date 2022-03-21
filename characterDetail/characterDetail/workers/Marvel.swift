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

    case characters
    case characterDetails(Int64)
}
