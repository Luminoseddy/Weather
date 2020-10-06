import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

/* Nicolas Notes: Cache system, Room persistence for swift */

/* Photo by: Yeshi Kangrang, MILKOVÍ, Lukas Spitaler
 * on Unsplash */
/* weatherViewController is a subclass of UIVewController, and conform to the rules of the CoreLocationManagerDelegate. */
class WeatherViewController: UIViewController, CLLocationManagerDelegate
{
    /* 'let' Constants - immutable -  */
    let APP_ID = "88bb614765d61f51ebc0fa68493023d7"
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let WEATHER_UV_INDEX = "http://api.openweathermap.org/data/2.5/uvi"
    let WEATHER_5DAY_3HOUR_FORECAST = "http://api.openweathermap.org/data/2.5/forecast"
    let locationManager = CLLocationManager()
    
    // Created from weather data model
    let weatherDataModel = WeatherDataModel()
    
    var recievedWeatherData = false

    @IBOutlet weak var weatherIcon: UIImageView!
    
 
    @IBOutlet weak var weatherIcon12am: UIImageView!
    @IBOutlet weak var weatherIcon3am: UIImageView!
    @IBOutlet weak var weatherIcon6am: UIImageView!
    @IBOutlet weak var weatherIcon9am: UIImageView!
    @IBOutlet weak var weatherIcon12pm: UIImageView!
    @IBOutlet weak var weatherIcon3pm: UIImageView!
    @IBOutlet weak var weatherIcon6pm: UIImageView!
    @IBOutlet weak var weatherIcon9pm: UIImageView!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
  
    @IBOutlet weak var _12amLabel: UILabel!
    @IBOutlet weak var _3amLabel: UILabel!
    @IBOutlet weak var _6amLabel: UILabel!
    @IBOutlet weak var _9amLabel: UILabel!
    @IBOutlet weak var _12pmLabel: UILabel!
    @IBOutlet weak var _3pmLabel: UILabel!
    @IBOutlet weak var _6pmLabel: UILabel!
    @IBOutlet weak var _9pmLabel: UILabel!
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    
    // @IBOutlet var checkTemp_Every3Hours: [UILabel]!
    
  
    
    
    
    @IBAction func getWeatherPressed(_ sender: AnyObject)
    {
   
        /* Get the city name entered in the text field */
        let cityName = changeCityTextField.text!
        /* If delegate? (i.e if delegate is not nil) call the new userEnteredCityName. If its nil, skips running the method.  */
        userEnteredCityName(city : cityName)
        /* Dismiss view after searchIcon is pressed. */
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        /* Setting up the location Managers. */
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters /* Accuracy of location data. */
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() /* Asynchronous method - works in the background and grabs the gps coordinate. Prevents app from freezing while loading the gps coordinate. */
    }
    
  
    /* MARK: - getWeatherData() Weather - Networking:
     * Handling response from weather map services. */
    func getWeatherData(url: String, parameters: [String: String]){
        /* Networking processing asynchronously: This is a structure provided by Alomofire to make a getRequest.
         * Making the http .get request
         * This case: 2 parameters needed to call from weatherMap - longitude, latitude. */
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
       
            if response.result.isSuccess
            {
                // print("Connection succeded. Weather data retrieved.")
                self.recievedWeatherData = true
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJSON)
                
                self.updaterWeatherData_Every3Hours(json: weatherJSON)
                print(weatherJSON)
            }
            else
            {
                print("Error\(String(describing: response.result.error))")
                self.cityLabel.text = "Database Unavailable Load."
            }
        }
    }
    
    func updaterWeatherData_Every3Hours(json: JSON)
    {
        if self.recievedWeatherData
        {
            /* CurrentDay 1*/
            if let _12amLabel = json["list"][0]["main"]["temp"].double
            {
                let _12amLabelTempFahrenheit = _12amLabel * (9/5) - 459.67
                weatherDataModel._12amLabel = Int(_12amLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][0]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__12amLabel_WeatherData()
            }
            if let _3amLabel = json["list"][1]["main"]["temp"].double
            {
                let _3amLabelTempFahrenheit = _3amLabel * (9/5) - 459.67
                weatherDataModel._3amLabel = Int(_3amLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][1]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__3amLabel_WeatherData()
            }
            if let _6amLabel = json["list"][2]["main"]["temp"].double
            {
                let _6amLabelTempFahrenheit = _6amLabel * (9/5) - 459.67
                weatherDataModel._6amLabel = Int(_6amLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][2]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__6amLabel_WeatherData()
            }
            if let _9amLabel = json["list"][3]["main"]["temp"].double
            {
                let _9amLabelTempFahrenheit = _9amLabel * (9/5) - 459.67
                weatherDataModel._9amLabel = Int(_9amLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][3]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__9amLabel_WeatherData()
            }
            if let _12pmLabel = json["list"][4]["main"]["temp"].double
            {
                let _12pmLabelTempFahrenheit = _12pmLabel * (9/5) - 459.67
                weatherDataModel._12pmLabel = Int(_12pmLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][4]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__12pmLabel_WeatherData()
            }
            if let _3pmLabel = json["list"][5]["main"]["temp"].double
            {
                let _3pmLabelTempFahrenheit = _3pmLabel * (9/5) - 459.67
                weatherDataModel._3pmLabel = Int(_3pmLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][5]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__3pmLabel_WeatherData()
            }
            if let _6pmLabel = json["list"][6]["main"]["temp"].double
            {
                let _6pmLabelTempFahrenheit = _6pmLabel * (9/5) - 459.67
                weatherDataModel._6pmLabel = Int(_6pmLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][6]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__6pmLabel_WeatherData()
            }
            if let _9pmLabel = json["list"][7]["main"]["temp"].double
            {
                let _9pmLabelTempFahrenheit = _9pmLabel * (9/5) - 459.67
                weatherDataModel._9pmLabel = Int(_9pmLabelTempFahrenheit)
                weatherDataModel.condition = json["list"][7]["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWith__9pmLabel_WeatherData()
            }
        }
        else
        {
            cityLabel.text = "Unable to load."
        }
    }
    /* MARK: - Networking: 5 day Weather every 3 hours Forecast */
    func updateUIWith__12amLabel_WeatherData()
    {
        _12amLabel.text = "\(weatherDataModel._12amLabel)º"
        weatherIcon12am.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__3amLabel_WeatherData()
    {
        _3amLabel.text = "\(weatherDataModel._3amLabel)º"
        weatherIcon3am.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__6amLabel_WeatherData()
    {
        _6amLabel.text = "\(weatherDataModel._6amLabel)º"
        weatherIcon6am.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__9amLabel_WeatherData()
    {
        _9amLabel.text = "\(weatherDataModel._9amLabel)º"
        weatherIcon9am.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__12pmLabel_WeatherData()
    {
        _12pmLabel.text = "\(weatherDataModel._12pmLabel)º"
        weatherIcon12pm.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__3pmLabel_WeatherData()
    {
        _3pmLabel.text = "\(weatherDataModel._3pmLabel)º"
        weatherIcon3pm.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__6pmLabel_WeatherData()
    {
        _6pmLabel.text = "\(weatherDataModel._6pmLabel)º"
        weatherIcon6pm.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    func updateUIWith__9pmLabel_WeatherData()
    {
        _9pmLabel.text = "\(weatherDataModel._9pmLabel)º"
        weatherIcon9pm.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    /* MARK: - Parsing JSON */
    func updateWeatherData(json: JSON)
    {
        if self.recievedWeatherData
        {
            /* Inside the json file we look for the key 'main' and inside main  -> key 'temp' */
            if let tempResult = json["main"]["temp"].double
            {
                let tempFahrenheit  = tempResult * (9/5) - 459.67
                weatherDataModel.temperature = Int(tempFahrenheit) // Default unit: Kelvin degrees
                weatherDataModel.city = json["name"].stringValue // convert json to string.
                weatherDataModel.condition = json["weather"][0]["id"].intValue
                weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition:weatherDataModel.condition)
                updateUIWithWeatherData()
            }
            if let minTemperature = json["main"]["temp_min"].double
            {
                let tempMinFahrenheit = minTemperature * (9/5) - 459.67
                weatherDataModel.minTemperature = Int(tempMinFahrenheit) // Default unit: Kelvin degrees
                updateUIWith_MinTemperature_WeatherData()
            }
            if let maxTemperature = json["main"]["temp_max"].double
            {
                let tempMaxFahrenheit = maxTemperature * (9/5) - 459.67
                weatherDataModel.maxTemperature = Int(tempMaxFahrenheit) // Default unit: Kelvin degrees
                updateUIWith_MaxTemperature_WeatherData()
            }
            if let humidity = json["main"]["humidity"].double
            {
                weatherDataModel.humidity = Int(humidity) // Default unit: Kelvin degrees
                updateUIWith_Humidity_WeatherData()
            }
            if let pressure = json["main"]["pressure"].double
            {
                weatherDataModel.pressure = Int(pressure) // Default unit: Kelvin degrees
                updateUIWith_Pressure_WeatherData()
            }
            /* Calls from the UI_Index API */
            if let uvIndex = json["value"].double
            {
                weatherDataModel.uvIndex = Int(uvIndex)
                updateUIWith_UVIndex_WeatherData()
            }
        }
        else
        {
            cityLabel.text = "Unable to load."
        }
    }
    /* MARK: - UI Updates */
    func updateUIWithWeatherData()
    {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)º"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    /* MARK: - Networking: Current Day weather */
    func updateUIWith_MinTemperature_WeatherData() { minTemperatureLabel.text = "\(weatherDataModel.minTemperature)º" }
    func updateUIWith_MaxTemperature_WeatherData() { maxTemperatureLabel.text = "\(weatherDataModel.maxTemperature)º"}
    func updateUIWith_Humidity_WeatherData() { humidityLabel.text = "\(weatherDataModel.humidity)%" }
    func updateUIWith_Pressure_WeatherData(){ pressureLabel.text = "\(weatherDataModel.pressure)" }
    func updateUIWith_UVIndex_WeatherData(){ uvIndexLabel.text = "\(weatherDataModel.uvIndex)" }
    

    /* MARK: - Location Manager Delegate Methods
     * Gets activated once the locationManager finds the location.
     * When gps finds the location it gets saved into the array: locations: [CLLocation] */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations[locations.count - 1]
        /* HorizontalAccuracy: Radius of a circle indicating where a user may be, higher value then higher the spread of possible location */
        locationManager.stopUpdatingLocation() /* Prevents battery drainage after finding the location. */
        locationManager.delegate = nil /* Prevents repetitive data displaying., updates one time and then stops. Its a time delay fix. */
        if location.horizontalAccuracy > 0
        {
            // print("Longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            /* Dictionary: String: key, String: value */
            let parameters: [String: String] = ["lat": latitude, "lon": longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: parameters)
            getWeatherData(url: WEATHER_UV_INDEX, parameters: parameters)
            getWeatherData(url: WEATHER_5DAY_3HOUR_FORECAST, parameters: parameters)
        }
    }
    /* Tells the delegate(WeatherViewController:)
     * that the locationManager was not able to retrieve the location value (ex. airplane mode).
     * Triggers when error. */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error)
        cityLabel.text = "Area Unavailable."
    }
    

    /* MARK: - Change City Delegate methods
     * Using the openWeathermap API, we must use 'q' as the key for city */
    func userEnteredCityName(city: String)
    {
        let parameters : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: parameters)
        getWeatherData(url: WEATHER_UV_INDEX, parameters: parameters)
        getWeatherData(url: WEATHER_5DAY_3HOUR_FORECAST, parameters: parameters)
    }
    
    /* Dismiss keyboard on touching screen */
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        self.view.endEditing(true)
//
//    }
}




//let tag = sender.tag
//for every3Hours in checkTemp_Every3Hours
//{
//    if every3Hours == view.viewWithTag(1){}
//}



