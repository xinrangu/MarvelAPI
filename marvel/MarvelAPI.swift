//
//  MarvelAPI.swift
//  marvel
//
//  Created by Gu Xinran on 4/28/19.
//  Copyright © 2019 Gu Xinran. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CryptoSwift // needed for md5

//create url md5
//request characters

struct MarvelAPIKeys {
    static let baseURL = "https://gateway.marvel.com/v1/public/characters?"
    static let privatekey = "0a5b0df7023eb98d4fda6b37e2f638f9ec43c669"
    static let apikey = "e935ebcc32a57b82e1660ae461e93c85"
}
