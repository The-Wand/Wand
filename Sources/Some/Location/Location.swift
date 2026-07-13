///
/// Copyright 2020 Aleksander Kozin
///
/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at
///
///     http://www.apache.org/licenses/LICENSE-2.0
///
/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.
///
/// Created by Aleksander Kozin
/// .some

#if canImport(CoreLocation)
import CoreLocation.CLLocation

/// Random Accuracy
extension CLLocationAccuracy: Some {

    @inline(__always)
    public
    static
    var any: Self {
        kCLLocationAccuracyBestForNavigation
    }
    
    @inline(__always)
    public
    static
    var rand: Self {
        [
            kCLLocationAccuracyBestForNavigation,
            kCLLocationAccuracyBest,
            kCLLocationAccuracyNearestTenMeters,
            kCLLocationAccuracyHundredMeters,
            kCLLocationAccuracyKilometer,
            kCLLocationAccuracyThreeKilometers,
        ].randomElement()!
    }

}

/// Random Accuracy Coordinate2D
extension CLLocationCoordinate2D: Some {

    @inline(__always)
    public
    static
    var any: Self {
        Self(latitude: (-90...90).rand,
             longitude: .rand(in: -180...180))
    }
    
    @inline(__always)
    public
    static
    var rand: Self {
        Self(latitude: .rand(in: -90...90),
             longitude: .rand(in: -180...180))
    }

}

/// Random Accuracy Location
extension CLLocation: Some {

    @inline(__always)
    public
    static
    var some: Self {
        Self.init(coordinate: .some,
                  altitude: .some,
                  horizontalAccuracy: .some,
                  verticalAccuracy: .some,
                  timestamp: .some)
    }

}

#endif
