//
//  CategoryRow.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import SwiftUI

struct CategoryRowView: View {
  
  @EnvironmentObject var appEnvironment: AppEnvironment
  
  let url: URL
  let categoryName: String
  
  @Binding var enable: String
  @Binding var persist: String
  
  var body: some View {
    HStack {
      Text(categoryName)
      
      Picker("Enable", selection: $enable) {
        Text("Off (Hides)")
          .tag("off")
        Text("Default (Hides)")
          .tag("default")
        Text("Info")
          .tag("info")
        Text("Debug")
          .tag("debug")
      }
      
      Picker("Persist", selection: $persist) {
        Text("Off (Hides)")
          .tag("off")
        Text("Default")
          .tag("default")
        Text("Info")
          .tag("info")
        Text("Debug")
          .tag("debug")
      }
      
      Button(action: {
        appEnvironment.apply(url: url, level: enable, category: categoryName)
      }, label: {
        Image("checkmark.circle")
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
    CategoryRowView(url: URL(string: "sdf")!,
                    categoryName: "Really long cateogry name",
                    enable: .constant("Inherit"),
                    persist: .constant("Inherit"))
      .environmentObject(AppEnvironment())
  }
}
