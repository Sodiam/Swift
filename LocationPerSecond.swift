struct LocationManager:  NSObject, ObservableObject, CLLocationManagerDelegate {
    //各メンバは省略

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            let center = CLLocationCoordinate2D(
                latitude: $0.coordinate.latitude,
                longitude: $0.coordinate.longitude
            )
            region = MKCoordinateRegion(
                center: center,
                latitudinalMeters: 1000.0,
                longitudinalMeters: 1000.0
            )
        }
    }
    
    func appendtospotlist() {
        spotlist.append(Spot(latitude: self.region.center.latitude, longitude: self.region.center.longitude))
    }
}

// in Viewfile
.onAppear() {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
        if (self.tracking) {
            self.manager.appendtospotlist()
        }
    }
}
