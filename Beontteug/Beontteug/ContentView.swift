//
//  ContentView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    @State private var showSettingSheet = false
    @EnvironmentObject var vm: AppViewModel
    @State private var fontSizeValue: Double = 24
    @State private var lineSpacingValue: Double = 10
    @State private var charcaterSpacingValue: Double = 0
    @State private var bgColor = Color.yellow
    @State private var fontColor = Color.black
    @State private var fontStyle: String = "BM HANNA Pro"
    @State var isToggled: [Bool] = [false]
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = []
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("기기에 카메라가 없는 것 같아요 🥲")
        case .scannerNotAvailable:
            Text("기기 버전을 iOS 16으로 업데이트해주세요 🙂")
        case .cameraAccessNotGranted:
            Text("카메라 접근 권한을 허용해주세요 📸")
        case .notDetermined:
            Text("카메라 접근 권한을 허용하는 중입니다...")
        }
    }
    
    private var mainView: some View {
        NavigationView {
            ZStack {
                DataScannerView(
                    recognizedItems: $vm.recognizedItems,
                    recognizedDataType: vm.recognizedDataType,
                    recognizesMultipleItems: vm.recognizesMultipleItems)
                .background { Color.gray.opacity(0.3) }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
                .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
                .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = []}
                .navigationBarItems(
                    leading: Text("번뜩")
                        .font(Font.customTitle())
                        .foregroundColor(.white)
                        .bold(),
                    trailing: NavigationLink(destination: SettingView(fontSizeValue: $fontSizeValue, lineSpacingValue: $lineSpacingValue, charcaterSpacingValue: $charcaterSpacingValue, bgColor: $bgColor, fontColor: $fontColor, fontStyle: $fontStyle, isToggled: $isToggled), label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.white)
                    })
                )
                VStack {
                    Spacer()
                    bottomContainerView
                        .background(bgColor)
                        .frame(height: 300)
                        .onAppear {
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                                return
                            }
                            controller.view.backgroundColor = .clear
                        }
                }
            }
        }
        .onAppear() {
            for family: String in UIFont.familyNames {
                            print(family)
                            for names : String in UIFont.fontNames(forFamilyName: family){
                                print("=== \(names)")
                            }
                        }
        }
    }
    
    private var bottomContainerView: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                            
                        case .text(let text):
                            Text(text.transcript)
                                .foregroundColor(fontColor)
                                .font(.custom("\(fontStyle)", size: fontSizeValue))
                                .kerning(charcaterSpacingValue)
                                .lineSpacing(lineSpacingValue)
                            
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}
