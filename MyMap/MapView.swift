//
//  MapView.swift
//  MyMap
//
//  Created by 習田武志 on 2022/01/02.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let searchKey: String
    let mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        // デバッグエリアへ出力
        print(searchKey)
        
        uiView.mapType = mapType
        
        // CLGeocoderインスタンスを取得
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(
            searchKey,
            completionHandler: { (placemarks, error) in
                if let unwrapPlacemarks = placemarks,
                   let firstPlacemark = unwrapPlacemarks.first,
                   let location = firstPlacemark.location {
                    // 緯度、経度情報を取り出し
                    let targetCoordinate = location.coordinate
                    // デバッグエリアへ出力
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    
                    pin.coordinate = targetCoordinate
                    
                    pin.title = searchKey
                    // ピンを配置
                    uiView.addAnnotation(pin)
                    // 半径５００mを表示
                    uiView.region = MKCoordinateRegion(
                        center: targetCoordinate,
                        latitudinalMeters: 500.0,
                        longitudinalMeters: 500.0)
            }
        })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "大阪駅", mapType: .standard)
    }
}
