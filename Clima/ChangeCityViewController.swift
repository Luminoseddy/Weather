import UIKit

/* PROTOCOL: Like a contract. The method must be implemented and handled if wanting to use the delegate */
protocol ChangeCityDelegate
{
    func userEnteredCityName (city: String)
}

class ChangeCityViewController: UIViewController
{
    //    var delegate : ChangeCityDelegate?
    //
    //    //This is the pre-linked IBOutlets to the text field:
    //    @IBOutlet weak var changeCityTextField: UITextField!
    //
    //    //This is the IBAction that gets called when the user taps on the "Get Weather" button:
    //    @IBAction func getWeatherPressed(_ sender: AnyObject)
    //    {
    //        /* Get the city name entered in the text field */
    //        let cityName = changeCityTextField.text!
    //
    //        /* If delegate? (i.e if delegate is not nil) call the new userEnteredCityName. If its nil, skips running the method.  */
    //        delegate?.userEnteredCityName(city : cityName)
    //
    //        /* dismiss the Change City View Controller to go back to the WeatherViewController */
    //         self.dismiss(animated: true, completion: nil)
    //    }
    //
    //    //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    //    @IBAction func backButtonPressed(_ sender: AnyObject)
    //    {
    //        self.dismiss(animated: true, completion: nil)
    //    }
}
