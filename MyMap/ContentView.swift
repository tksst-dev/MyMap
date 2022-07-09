//
//  ContentView.swift
//  MyMap
//
//  Created by 習田武志 on 2022/01/02.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @State var inputText: String = ""
    @State var dispSearchKey: String = ""
    @State var dispMapType: MKMapType = .standard
    
    var body: some View {
        VStack {
            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                .onSubmit {
                    dispSearchKey = inputText
                }
                // 余白設定
                .padding()
            
            ZStack(alignment: .bottomTrailing) {
                MapView(searchKey: dispSearchKey, mapType: dispMapType)
                
                Button(action: {
                    if dispMapType == .standard {
                        dispMapType = .satellite
                    } else if dispMapType == .satellite {
                        dispMapType = .hybrid
                    } else if dispMapType == .hybrid {
                        dispMapType = .satelliteFlyover
                    } else if dispMapType == .satelliteFlyover {
                        dispMapType = .hybridFlyover
                    } else if dispMapType == .hybridFlyover {
                        dispMapType = .mutedStandard
                    } else {
                        dispMapType = .standard
                    }
                }) {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0, height: 35.0, alignment: .leading)
                }
                .padding(.trailing, 20.0)
                .padding(.bottom, 30.0)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
