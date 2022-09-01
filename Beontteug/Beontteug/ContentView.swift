//
//  ContentView.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI
import VisionKit

struct ContentView: View {
    
    @State private var showScannerSheet = false
    @EnvironmentObject var vm: AppViewModel
    
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
                .background { Color.black }
                .ignoresSafeArea()
                .id(vm.dataScannerViewId)
                .sheet(isPresented: .constant(true)) {
                    bottomContainerView
                        .background(.ultraThinMaterial)
                        .presentationDetents([.medium, .fraction(0.25)])
                        .presentationDragIndicator(.visible)
                        .interactiveDismissDisabled()
                        .onAppear {
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                                return
                            }
                            controller.view.backgroundColor = .clear
                        }
                }
                .onChange(of: vm.scanType) { _ in vm.recognizedItems = [] }
                .onChange(of: vm.textContentType) { _ in vm.recognizedItems = [] }
                .onChange(of: vm.recognizesMultipleItems) { _ in vm.recognizedItems = []}
                .navigationBarItems(
                    leading: Text("번뜩")
                        .font(Font.customTitle())
                        .foregroundColor(.white)
                        .font(.title)
                        .bold(),
                    trailing: Button(action: {
                        self.showScannerSheet = true
                    }, label: {
                        Image(systemName: "gearshape.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    })
                    .sheet(isPresented: $showScannerSheet, content: {
                        bottomContainerView
                    })
                )
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
                                .foregroundColor(.black)
                                .font(Font.customTitle())
                            
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
