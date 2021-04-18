//
//  ContentView.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
//

import SwiftUI
import os.log

struct ContentView: View {
  
  @EnvironmentObject var appEnvironment: AppEnvironment
  
  @State var addSubSystem: Bool = false
  
  var body: some View {
    
    ScrollView(.vertical) {
      ForEach(appEnvironment.subSystemURLs, id: \.self) { url in
        SubSystemView(subSystemURL: url)
      }
      .padding()
      
      Button(action: {
        addSubSystem.toggle()
      }, label: {
        Text("Add New SubSystem")
          .font(.subheadline)
      })
      .sheet(isPresented: $addSubSystem) {
        AddSubSystemView()
      }
    }
    
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environmentObject(AppEnvironment())
  }
}

struct AddSubSystemView: View {
  
  @State var newSubSystemBundleId: String = ""
  @EnvironmentObject var appEnvironment: AppEnvironment
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    
    VStack {
      
      HStack {
        
        Text("Add New SubSystem")
        
        Button("Close") {
          presentationMode.wrappedValue.dismiss()
        }
        
      }
      
      VStack {
        
        TextField("Bundle Id", text: $newSubSystemBundleId)
        
        Button("Add") {
          appEnvironment.add(bundleId: newSubSystemBundleId)
          appEnvironment.reload()
          presentationMode.wrappedValue.dismiss()
        }
      }
      
    }
    .padding()
    
  }
}
