import Foundation
import WMATA
import ArgumentParser

struct BusStops: ParsableCommand {
    @Argument var station: String = "A01" // default to Metro Center
    @Argument var distance: UInt = 500 // default to 1/2 KM
    @Argument var key: String = "e13626d03d8e4c03ac07f95541b3091b" // default to WMATA Demo Key

    func run() throws {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        if let mrs = Station(rawValue: station) {
            mrs.information(withApiKey: key) { infoResult in
            switch infoResult {
            case .success(let info):
                print("Got station information for \(mrs.name), using lat: \(info.latitude) long: \(info.longitude)")
                let bus = MetroBus.init(key: key)
                bus.searchStops(at: RadiusAtCoordinates(radius: distance, latitude: info.latitude, longitude: info.longitude)) { stopsResult in
                    switch stopsResult {
                    case .success(let stops):
                        print("\(mrs.name) has \(stops.stops.count) bus stops within \(distance) meters")
                    case .failure(let error):
                        print("Error \"\(error)\" getting bus stops at \(mrs.name)")
                    }
                    semaphore.signal()
                }
            case .failure(let error):
                print("Error \"\(error)\" getting station information for \(station)")
                semaphore.signal()
            }
        }
            
        }
        // get stationinfo
        semaphore.wait()
    }
}

BusStops.main()
