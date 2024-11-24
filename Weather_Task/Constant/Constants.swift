//
//  Constants.swift
//  Weather_Task
//
//  Created by Vaishnavi on 22/11/24.
//

import UIKit

let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
var storyBd = UIStoryboard(name: "Main", bundle: nil)
let API_Key = "4b0e03bd99d0230c014f890573dfb899"
let imageUrlString = "https://img.freepik.com/premium-vector/cute-smiling-sun-vector-icon_197792-591.jpg"
let weatherDescription = """
    A weather app serves as a valuable tool for users who want to stay informed about the current weather conditions and forecast for any given location. The primary function of such an app is to provide real-time data on various weather parameters like temperature, humidity, wind speed, and air pressure, while also offering future weather predictions based on available meteorological data. Most modern weather apps pull this information from global weather services, using data from satellites, radar systems, and weather stations, which are then processed and presented to the user in an easy-to-understand format.

    For example, a typical weather app will display the current temperature and weather status for your location, showing whether it's sunny, cloudy, rainy, or snowy. Additionally, it might provide a five-day forecast, giving users an idea of what weather to expect in the coming days. Many apps also offer specialized features like radar maps, which allow users to track weather patterns like storms or precipitation, and notifications that alert them to any significant weather changes, such as severe weather warnings.

    The interface of a weather app is usually designed to be clean and user-friendly. Many apps use intuitive icons and color schemes to convey the current weather conditions quickly—for instance, a bright sun icon to indicate sunny weather or a raindrop icon for precipitation. Additionally, advanced weather apps may include interactive maps, charts, and graphs that show hourly forecasts, historical weather data, or even air quality indexes.

    Some weather apps also offer additional functionalities like integration with the user's calendar or smart devices. For instance, if you're planning an outdoor event, the app might suggest the best time for it based on the expected weather. Furthermore, apps like these often use geolocation to give users weather information for their exact location, but they also allow you to check the weather for any city or area around the world.

    In terms of development, a weather app can be relatively simple or highly sophisticated, depending on the features it offers. While basic weather apps focus primarily on providing accurate forecasts, more advanced ones might incorporate machine learning models to predict microclimates or suggest personalized weather advice based on the user's behavior, location, and preferences. For example, if the app notices that you tend to go jogging in the mornings, it might notify you of an impending rainstorm or advise you on the best time to go outside based on your typical activity patterns.

    Ultimately, a good weather app offers convenience, timely information, and personalized features that make staying on top of the weather easier and more reliable for its users. Whether it's helping someone plan their day, stay safe during a storm, or simply satisfy their curiosity about what the weather is like in another part of the world, these apps are an indispensable tool in modern life.
    """
