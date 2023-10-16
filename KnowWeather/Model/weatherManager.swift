

import Foundation
protocol WeatherManageDelegate{
    func didUpdateWeather(weather:weatherRefrens)
    func checkExistCity(existCity:Bool)
}
struct weatherManager{
    let apiUrl = "https://api.weatherapi.com/v1/forecast.json?key=94821fa279914ff4a97144245231810&days=4&aqi=no&alerts=no"
    var delegate : WeatherManageDelegate?
    //create session for get data from api
    func requestWeather(cityName: String){
        let weatherUrl = "\(apiUrl)&q=\(cityName)#"
        if let url = URL(string: weatherUrl){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {(data,response,error) in
                if error != nil{
                    return
                }
                if let safeData = data {
                    if let weather =  self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather:weather )
                    }else{
                    }
                    
                }
                
            })
            task.resume()
            
        }
    }
    //decoding data from api
    func parseJSON (weatherData:Data) -> weatherRefrens?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //return decoded value from func
            var weatherInfo = weatherRefrens(Id: decodedData.current.condition.code, cityName: decodedData.location.name, currentTemp: decodedData.current.temp_c, maxTemp: decodedData.forecast.forecastday[0].day.maxtemp_c, minTemp: decodedData.forecast.forecastday[0].day.mintemp_c,daysWeather: [decodedData.forecast.forecastday[1].day.maxtemp_c,decodedData.forecast.forecastday[2].day.maxtemp_c,decodedData.forecast.forecastday[3].day.maxtemp_c] ,daystime: [decodedData.forecast.forecastday[1].date,decodedData.forecast.forecastday[2].date,decodedData.forecast.forecastday[3].date],daysId: [decodedData.forecast.forecastday[1].day.condition.code,decodedData.forecast.forecastday[2].day.condition.code,decodedData.forecast.forecastday[3].day.condition.code])
            weatherInfo.oop()
            delegate?.checkExistCity(existCity: true)
            return weatherInfo
        }catch{
            delegate?.checkExistCity(existCity:false)
            return nil
        }

    }
    
}



