import Foundation
//Creating a reference to decode the data inside it
struct weatherRefrens{
    let Id : Int
    let cityName : String
    let currentTemp: Int
    let maxTemp : Double
    let minTemp: Double
    let daysWeather : [Double]
    let daystime : [String]
    let daysId : [Int]
    var daysSky : [String] = []
    //future image icon sky
    mutating func oop() {
        for ch in daysId{
            switch ch {
            case 1003...1030:
                 daysSky.append("cloudyIcon")
            case 1000:
                 daysSky.append("sunnyIcon")
            case 1135...1201:
                 daysSky.append("rainyIcon")
            case 1063...1171:
                 daysSky.append("rainyIcon")
            case 1180...1207:
                daysSky.append("rainyIcon")
            case 1204...1282:
                 daysSky.append("snowyIcon")
            case 1114:
                 daysSky.append("snowyIcon")
            case 1066:
                 daysSky.append("snowyIcon")
            default:
                 daysSky.append("cloudyIcon")
            
            }
        }
    }
    //for know about current sky
    var sky :String{
        switch Id {
        case 1003...1030:
            return "cloudy"
        case 1000:
            return "sunny"
        case 1135...1201:
            return "rainy"
        case 1063...1171:
            return "rainy"
        case 1180...1207:
            return "rainy"
        case 1204...1282:
            return "snowy"
        case 1114:
            return "snowy"
        case 1066:
            return "snowy"
        default:
            return "cloudy"
        
        }
    }
    //for background image
        var backgroundImage :String{
            switch sky{
            case "cloudy" :
                return "cloudyPhoto"
            case "sunny" :
                return "sunnyPhoto"
            case "rainy" :
                return "rainyPhoto"
            case "snowy" :
                return"snowyPhoto"
            default:
                return "cloudyPhoto"
            }
        }
    //for collcection view  background image
    var backgroundImageCollection :String{
        switch sky{
        case "cloudy" :
            return "cloudyBar"
        case "sunny" :
            return "sunnyBar"
        case "rainy" :
            return "rainyBar"
        case "snowy" :
            return"snowyBar"
        default:
            return "cloudyBar"
        }
    }
    //for collcection view cell background image
    var imageCell :String{
        switch sky{
        case "cloudy" :
            return "cloudyCell"
        case "sunny" :
            return "sunnyCell"
        case "rainy" :
            return "rainyCell"
        case "snowy" :
            return"snowyCell"
        default:
            return "cloudyCell"
        }
    }
  
}


