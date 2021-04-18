//
//  SubSystemView.swift
//  Loggle
//
//  Copyright © 2021 Chris Davis, www.chrisdavis.com.
//  Released under the GNU General Public License v3.0.
//
//  See https://github.com/nthState/Loggle/blob/master/LICENSE for license information.
//

import SwiftUI
import OSLog

struct SubSystemView: View {
  
  @EnvironmentObject var appEnvironment: AppEnvironment
  
  @State var addCategory: Bool = false
  
  let subSystemURL: URL
  @State var expanded: Bool = false
  
  func expand() {
    
    
    withAnimation {
        
      expanded = !expanded
    }
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
            .frame(width: 18, height: 18)
            .animation(.easeInOut)
        })
        .buttonStyle(PlainButtonStyle())
        
        Text(subSystemURL.deletingPathExtension().lastPathComponent)
          .font(.system(size: 20))
        
        Spacer()
        
        Button(action: {
          appEnvironment.save(url: subSystemURL)
        }, label: {
          Text("Save Plist")
        })
        
        Button(action: {
          addCategory.toggle()
        }, label: {
          Text("Add Category")
        })
        .sheet(isPresented: $addCategory) {
          AddCategoryView(bundleId: subSystemURL.deletingPathExtension().lastPathComponent)
        }

      }
    }
    
    if expanded {
      VStack {
        ForEach(appEnvironment.map[subSystemURL]!.keys.sorted(), id: \.self) { key in
          
          let enable = Binding {
            appEnvironment.map[subSystemURL]![key]?.level?["Enable"] ?? ""
          } set: { (newValue) in
            appEnvironment.map[subSystemURL]![key]?.level?["Enable"] = newValue
          }
          
          let persist = Binding {
            appEnvironment.map[subSystemURL]![key]?.level?["Persist"] ?? ""
          } set: { (newValue) in
            appEnvironment.map[subSystemURL]![key]?.level?["Persist"] = newValue
          }

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

struct AddCategoryView: View {
  
  let bundleId: String
  @State var category: String = ""
  @EnvironmentObject var appEnvironment: AppEnvironment
  @Environment(\.presentationMode) var presentationMode
  
  var body: some View {
    
    VStack {
      
      HStack {
        
        Text("Add New Category")
        
        Button("Close") {
          presentationMode.wrappedValue.dismiss()
        }
        
      }
      
      VStack {
        
        TextField("Category Name", text: $category)
        
        Button("Add") {
          appEnvironment.add(category: category, to: bundleId)
          appEnvironment.reload()
          presentationMode.wrappedValue.dismiss()
        }
      }
      
    }
    .padding()
    
  }
}
