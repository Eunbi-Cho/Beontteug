//
//  BeontteugApp.swift
//  Beontteug
//
//  Created by 조은비 on 2022/09/01.
//

import SwiftUI

@main
struct BeontteugApp: App {
    
    @StateObject private var vm = AppViewModel()
       
       var body: some Scene {
           WindowGroup {
               ContentView()
                   .environmentObject(vm)
                   .task {
                       await vm.requestDataScannerAccessStatus()
                   }
           }
       }
   }
