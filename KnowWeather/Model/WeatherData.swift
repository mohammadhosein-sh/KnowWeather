
import Foundation
//get decoder data from api-conection with api
struct WeatherData:Codable {
    let current : Current
    let forecast : ForeCast
    let location : Location
}

struct Current : Codable{
    let temp_c : Int
    let condition : Condition
}

struct ForeCast: Codable{
    let forecastday : [ForeCastDay]
}
struct Location : Codable{
    let name:String
}
struct Condition : Codable{
    let code : Int
}
struct ForeCastDay:Codable{
    let date : String
    let day : Day
}
struct Day : Codable{
    let maxtemp_c : Double
    let mintemp_c :Double
    let condition : Condition
}

