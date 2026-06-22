//: Playground

let rlm: Character = "\u{200F}"

//import MapKit
//import PlaygroundSupport
//
//// Create an MKMapViewDelegate to provide a renderer for our overlay
//class MapViewDelegate: NSObject, MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if let overlay = overlay as? MKPolygon {
//            let polygonRenderer = MKPolygonRenderer(overlay: overlay)
//            polygonRenderer.fillColor = .purple
//            return polygonRenderer
//        }
//        return MKOverlayRenderer(overlay: overlay)
//    }
//}
//
//// Create a strong reference to a delegate
//let delegate = MapViewDelegate()
//
//// Create an MKMapView
//let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
//mapView.delegate = delegate
//
//// Configure The Map elevation and emphasis style
//let configuration = MKStandardMapConfiguration(elevationStyle: .realistic, emphasisStyle: .default)
//mapView.preferredConfiguration = configuration
//
//// Create an annotation
//let visitorCenterAnnotation = MKPointAnnotation()
//visitorCenterAnnotation.coordinate = CLLocationCoordinate2DMake(27.332835, -122.005354)
//visitorCenterAnnotation.title = "Visitor Center"
//visitorCenterAnnotation.subtitle = "10600 N Tantau Ave"
//mapView.addAnnotation(visitorCenterAnnotation)
//
//// Create an overlay
//let parkingLotPoints = [MKMapPoint(CLLocationCoordinate2DMake(37.333994, -122.005044)),
//                        MKMapPoint(CLLocationCoordinate2DMake(37.333994, -122.004816)),
//                        MKMapPoint(CLLocationCoordinate2DMake(37.332484, -122.004816)),
//                        MKMapPoint(CLLocationCoordinate2DMake(37.332484, -122.005044))]
//let parkingLotOverlay = MKPolygon(points: parkingLotPoints, count: parkingLotPoints.count)
//mapView.addOverlay(parkingLotOverlay)
//
//// Frame our annotation and overlay
//mapView.camera = MKMapCamera(lookingAtCenter: CLLocationCoordinate2DMake(37.333273, -122.006581), fromDistance: 500, pitch: 65, heading: 270)
//
//// Add the created mapView to our Playground Live View
//PlaygroundPage.current.liveView = mapView


//class Core : CustomStringConvertible, Identifiable {
//
//    /// References for cores of objects
//    /// object <-> Core
//    static var all: <<error type>>
//
//    subscript<T>(object: T?) -> Core? { get set }
//
//    subscript<T>(object: T) -> Core? { get set }
//
//    subscript(object: AnyObject) -> Core? { get set }
//
//    var scope: [String : Any]
//    var handlers: [String : (last: Any, cleaner: (() -> ())?)]
//
//    var id: UInt32 { get set }
//
//    var name: (quotient: UInt32, remainder: UInt32) { get set }
//
//    var description: <<error type>> { get set }
//
//    var version: String { get }
//
//    init()
//
//    init<T>(_ object: T)
//
//    deinit
//
//    func sendLogs()
//}
//
///// Attach to <#Any?#>
//extension Core {
//    func to<C>(_ scope: C? = nil) -> Core
//}
//
///// Save objects
///// Without triggering Asks
//extension Core {
//func put<T>(_ object: T, for key: String? = nil) -> T
//func putDefault<T>(_ object: @autoclosure () -> (T), for raw: String? = nil)
//func save<T>(_ object: T, for raw: String? = nil) -> String
//}
//
///// Save sequence
///// Without triggering Asks
//extension Core {
//func put<T>(sequence: T) where T == any Sequence
//func dynamicallyCall<T>(withKeywordArguments args: T) where T == KeyValuePairs<String, Any>
//func dynamicallyCall(withArguments objects: [Any])
//}
//
///// Scope
//extension Core {
//func contains(for key: String) -> Bool
//func extract<T>(for key: String? = nil) -> T?
//}
//
///// Get
//extension Core {
//func get<T>(for key: String? = nil) -> T?
//func get<T>(for key: String? = nil, or create: @autoclosure () -> (T)) -> T
//}
//
///// Store Asks
//extension Core {
//func append<T>(ask: Ask<T>) -> Bool
//func setCleaner<T>(for ask: Ask<T>, cleaner: @escaping () -> ())
//}
//
///// Add object
///// Call handlers
//extension Core {
//func addIf<T>(exist object: T?, for key: String? = nil) -> T?
//func add<T>(_ object: T, for raw: String? = nil) -> T
//func add<T>(sequence: any Sequence<T>)
//}
//
///// Close
//extension Core {
//func close()
//}
