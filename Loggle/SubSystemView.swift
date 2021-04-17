//
//  SubsystemView.swift
//  Loggle
//
//  Created by Chris Davis on 17/04/2021.
//

import SwiftUI
import OSLog

struct SubSystemView: View {
  
  @EnvironmentObject var appEnvironment: AppEnvironment
  
  let subSystemURL: URL
  @State var expanded: Bool = false
  
  func expand() {
    
    
    
    expanded = !expanded
  }
  

  
  var body: some View {
    VStack {
      HStack {
        
        Button(action: {
          expand()
        }, label: {
          Image("arrow.forward")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle.degrees(expanded ? 90 : 0))
            .frame(width: 24, height: 24)
            .animation(.easeInOut)
        })
        .buttonStyle(PlainButtonStyle())
        
        Text(subSystemURL.deletingPathExtension().lastPathComponent)
        
        Button(action: {
          appEnvironment.save(url: subSystemURL)
        }, label: {
          Text("Save")
        })
        
        Button(action: {
          
        }, label: {
          Image("plus.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
        })
        .buttonStyle(PlainButtonStyle())
        
      }
    }
    
    if expanded {
      VStack {
        ForEach(appEnvironment.map[subSystemURL]!.keys.sorted(), id: \.self) { key in
          
          var enable = Binding {
            appEnvironment.map[subSystemURL]![key]?.level?["Enable"] ?? ""
          } set: { (newValue) in
            appEnvironment.map[subSystemURL]![key]?.level?["Enable"] = newValue
          }
          
          var persist = Binding {
            appEnvironment.map[subSystemURL]![key]?.level?["Persist"] ?? ""
          } set: { (newValue) in
            appEnvironment.map[subSystemURL]![key]?.level?["Persist"] = newValue
          }

          
//          let enable = appEnvironment.map[subSystemURL]![key]?.level?["Enable"] ?? ""
//          let persist = appEnvironment.map[subSystemURL]![key]?.level?["Persist"] ?? ""
          CategoryRowView(url: subSystemURL,
                          categoryName: key,
                          enable: enable,
                          persist: persist)
        }
        
      }
    }
    
  }
}

struct SubsystemView_Previews: PreviewProvider {
  static var previews: some View {
    SubSystemView(subSystemURL: URL(string: "/com.blah.foo")!)
      .environmentObject(AppEnvironment())
  }
}
