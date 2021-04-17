//
//  CategoryRow.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import SwiftUI

struct CategoryRowView: View {
  
  let categoryName: String
  
  @Binding var enable: String
  @Binding var persist: String
  
  var body: some View {
    HStack {
      Text(categoryName)
      
      Picker("Enable", selection: $enable) {
        Text("Inherit")
          .tag("Inherit")
        Text("Default (Hides)")
          .tag("default")
        Text("Info")
          .tag("info")
        Text("Debug (Shows)")
          .tag("Debug")
      }
      
      Picker("Persist", selection: $persist) {
        Text("Inherit")
          .tag("Inherit")
        Text("Default")
          .tag("default")
        Text("Info")
          .tag("info")
        Text("Debug")
          .tag("Debug")
      }
      
      Button(action: {
        
      }, label: {
        Image("minus.circle")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 24, height: 24)
      })
      .buttonStyle(PlainButtonStyle())
    }
  }
}

struct CategoryRow_Previews: PreviewProvider {
  static var previews: some View {
    CategoryRowView(categoryName: "Really long cateogry name",
                    enable: .constant("Inherit"),
                    persist: .constant("Inherit"))
      .environmentObject(AppEnvironment())
  }
}
