var spotlist // 位置情報データをSpotオブジェクトに変換したものを格納する配列。Spotの定義はここでは省略

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
        // 旧コードではここでspotlistへのappend処理を行なっていた
    }
    
    func appendtospotlist() {
        spotlist.append(Spot(latitude: self.region.center.latitude, longitude: self.region.center.longitude)) //Spotは緯度と経度の情報を持つ
    }
}

struct ContentView: View {
    //メンバ省略
    var body: some View {
        //UI省略
    }
    .onAppear() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if (self.tracking/* 制御変数 */) {
                self.manager.appendtospotlist()
            }
        }
    }
}
