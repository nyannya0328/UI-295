//
//  Home.swift
//  Home
//
//  Created by nyannyan0328 on 2021/08/26.
//

import SwiftUI

struct Home: View {
    @State var slection : Int = 0
    var body: some View {
      
        pagerTabView(tintColor:.black,selection: $slection) {
            
            Image(systemName: "house.fill")
                .pageLabel()
            
            Image(systemName: "magnifyingglass")
                .pageLabel()
                
            
            Image(systemName: "gear")
                .pageLabel()
                
                
            
            
            
        } content: {
            
            Color.red
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            Color.green
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            Color.orange
                .pageView(ignoresSafeArea: true, edges: .bottom)
            
            
        }
        .padding(.top)
        .ignoresSafeArea(.all, edges: .bottom)

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
