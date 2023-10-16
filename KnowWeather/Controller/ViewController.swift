import UIKit
class ViewController: UIViewController ,UISearchBarDelegate,WeatherManageDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    //To transfer data from the weather manager model
    var futuretemp : [Double] = []
    var futuretime : [String] = []
    var futureicon : [String] = []
    var ImageCell :String = ""
    //view connections
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var backgroundImageCollection: UIImageView!
    @IBOutlet weak var currentTemperatureView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var maxMinLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var futureTempCollection: UICollectionView!
    //for delegate weather manager
    var weatherManagerModel = weatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()        // Do any additional setup after loading the view.
        currentTemperatureView.layer.cornerRadius = 45
        weatherManagerModel.delegate = self
        futureTempCollection.delegate = self
        futureTempCollection.dataSource = self
        futureTempCollection.reloadData()

    }
    //search city name
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let city = searchBar.text{
            weatherManagerModel.requestWeather(cityName: city)
        }
        searchBar.endEditing(true)
        cityLabel.text = "Loading..."
        currentTemperatureLabel.text = "0°"
    }
    //error handeling- cheking for city exist
    func checkExistCity(existCity: Bool) {
        DispatchQueue.main.async{
            if existCity == false{
                self.searchBar.text = "city Note Found"
                self.cityLabel.text = "Error!"
                self.currentTemperatureLabel.text = "0°"
            }
        }
    }
    //give data from weather manage and put inside to view
    func didUpdateWeather(weather: weatherRefrens) {
        DispatchQueue.main.async {
            if self.futuretemp.count>0 && self.futuretime.count>0{
                self.futuretemp.removeAll()
                self.futuretime.removeAll()
                self.futureicon.removeAll()
            }
            self.currentTemperatureLabel.text = String("\(weather.currentTemp)°")
            self.cityLabel.text = weather.cityName
            self.skyLabel.text = weather.sky
            self.maxMinLabel.text = "H:\(String(weather.maxTemp))° L:\(String(weather.minTemp))°"
            self.backgroundImage.image = UIImage(named: weather.backgroundImage)
            self.backgroundImageCollection.image = UIImage(named: weather.backgroundImageCollection)
            self.futuretemp.append(contentsOf: weather.daysWeather)
            self.futuretime.append(contentsOf: weather.daystime)
            self.futureicon.append(contentsOf: weather.daysSky)
            self.ImageCell = weather.imageCell
            self.futureTempCollection.reloadData()
        }
    }
    //collection 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return futuretemp.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell2 : CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as! CollectionViewCell
            cell2.timeCollectionLabel?.text = futuretime[indexPath.row]
            cell2.tempCollectionLabel?.text = String(futuretemp[indexPath.row])
            cell2.iconCollectionLabel?.image = UIImage(named:futureicon[indexPath.row])
        cell2.backgroundImageCollectionCell?.image = UIImage(named: ImageCell )
        return cell2
    }
 
    
}
