import UIKit



// CREATE a model to work with large data easier
class WeatherDataModel {
    
    var temperature : Int = 0
    var minTemperature : Int = 0
    var maxTemperature : Int = 0
    var humidity : Int = 0
    var pressure : Int = 0
    var uvIndex : Int = 0
    
    /* Array of hours : 24 hour system 0: 12am, 3:3am ... 21: 9pm */
    // var every3Hours = [0, 3, 6, 9, 12, 15, 18, 21]
    
    var _12amLabel: Int = 0
    var _3amLabel: Int = 0
    var _6amLabel: Int = 0
    var _9amLabel: Int = 0
    var _12pmLabel: Int = 0
    var _3pmLabel: Int = 0
    var _6pmLabel: Int = 0
    var _9pmLabel: Int = 0
    
    
    
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //This method turns a condition code into the name of the weather condition image
    // Takes an input condition, and when the Int value falls under one statement, it'll load an image.
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
}
