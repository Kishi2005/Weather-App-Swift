//
//  ContentView.swift
//  Weather app
//
//  Created by Lorenzo Fravolini on 18/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        VStack {
            
            if let location =
                locationManager.location {
                if let weather = weather{
                    WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do{
                                weather = try await
                                weatherManager
                                    .getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather: \(error)")
                            }
                        }
                }
                     } else {
                    if locationManager.isLoading{
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
        }
        .background(Color(hue: 0.696, saturation: 1.0, brightness: 0.702))
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
