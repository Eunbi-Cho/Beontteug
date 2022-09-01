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
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = []
    
    var body: some View {
        switch vm.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning barcode with this app")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in settings")
        case .notDetermined:
            Text("Requesting camera access")
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
                    trailing: NavigationLink(destination: SettingView(fontSizeValue: $fontSizeValue, lineSpacingValue: $lineSpacingValue, charcaterSpacingValue: $charcaterSpacingValue, bgColor: $bgColor, fontColor: $fontColor), label: {
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
                                .font(.custom("BM HANNA Pro", size: fontSizeValue))
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
