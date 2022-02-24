//
//  API.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/24/22.
//

import Foundation

public enum API {
    case latAndLong(lat: String , long : String )
    public var URLPathHome: String {
        switch self {
               case .latAndLong(let lat , let long):
            return "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=24,7&appid=628409d2c72ec95050248eb8dd5a6f22"
               }
    }
}
