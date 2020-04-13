import Foundation
import CoreLocation
import HPNetwork

public class CoordinateRequest: DecodableRequest<OpenWeatherResponse>, WeatherRequest {

    public typealias Output = OpenWeatherResponse

    public override var url: URL? {
        URLQueryItemsBuilder("api.openweathermap.org")
            .addingPathComponent("data")
            .addingPathComponent("2.5")
            .addingPathComponent("onecall")
            .addingQueryItem(coordinate.latitude, name: "lat", digits: 5)
            .addingQueryItem(coordinate.longitude, name: "lon", digits: 5)
            .addingQueryItem(configuration.apiKey, name: "appid")
            .addingQueryItem(configuration.units.rawValue, name: "units")
            .addingQueryItem(configuration.language.rawValue, name: "lang")
            .build()
    }

    public override var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return decoder
    }

    private let coordinate: CLLocationCoordinate2D

    public let configuration: RequestConfiguration

    public init(coordinate: CLLocationCoordinate2D, configuration: RequestConfiguration) {
        self.coordinate = coordinate
        self.configuration = configuration
        super.init(urlString: "www.google.com")
    }

}