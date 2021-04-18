//
//  CategoryRowView.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
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
        .font(.subheadline)
      
      Spacer()
      
      Picker("Enable", selection: $enable) {
        Text("Off (Hides)")
          .font(.subheadline)
          .tag("off")
        Text("Default (Hides)")
          .font(.subheadline)
          .tag("default")
        Text("Info")
          .font(.subheadline)
          .tag("info")
        Text("Debug")
          .font(.subheadline)
          .tag("debug")
      }
      .font(.subheadline)
      .frame(width: 132)
      
      Picker("Persist", selection: $persist) {
        Text("Off (Hides)")
          .font(.subheadline)
          .tag("off")
        Text("Default (Hides)")
          .font(.subheadline)
          .tag("default")
        Text("Info")
          .font(.subheadline)
          .tag("info")
        Text("Debug")
          .font(.subheadline)
          .tag("debug")
      }
      .font(.subheadline)
      .frame(width: 132)
      
      Button(action: {
        appEnvironment.apply(url: url, level: enable, category: categoryName)
      }, label: {
        Text("Apply")
          .font(.subheadline)
      })
      
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
