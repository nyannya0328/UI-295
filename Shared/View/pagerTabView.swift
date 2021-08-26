//
//  pagerTabView.swift
//  pagerTabView
//
//  Created by nyannyan0328 on 2021/08/26.
//

import SwiftUI

struct pagerTabView<Content : View,Label : View>: View {
    var content : Content
    var label : Label
    var tintColor : Color
    @Binding var selection : Int
    
    
    init(tintColor :Color,selection:Binding<Int>, @ViewBuilder label :  @escaping()->Label,@ViewBuilder content :  @escaping()->Content) {
        self.content  = content()
        self.label = label()
        self.tintColor  = tintColor
        self._selection = selection
    }
    
    @State var offset : CGFloat = 0
    
  
    
    @State var maxTabs : CGFloat = 0
    
    @State var tabOffset : CGFloat = 0
    
    var body: some View {
        VStack(spacing:0){
            HStack(spacing:0){
                label
                
            }
            .overlay(
            
            
                HStack(spacing:0){
                    
                    
                    ForEach(0..<Int(maxTabs),id:\.self){index in
                        
                        Rectangle()
                            .fill(.black.opacity(0.01))
                            .onTapGesture {
                                
                                let newOffset = CGFloat(index) * getScreenBounds().width
                                
                                self.offset = newOffset
                            }
                        
                        
                    }
                }
            
            )
            .foregroundColor(tintColor)
            Capsule()
                .fill(tintColor)
                .frame(width: maxTabs == 0 ? 0 : (getScreenBounds().width / maxTabs), height: 5)
                .padding(.top,5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .offset(x: tabOffset)
            
            offSetTabView(selection:$selection,offset: $offset) {
                
                HStack(spacing:0){
                    
                    content
                }
                .overlay(
                
                    GeometryReader{proxy in
                        
                        Color.clear
                            .preference(key: tabPreferenceKey.self, value: proxy.frame(in: .global))
                        
                    
                        
                    }
                
                )
                .onPreferenceChange(tabPreferenceKey.self) { proxy in
                    
                    
                    let minX = -proxy.minX
                    let maxWidth = proxy.width
                    let screenWidth = getScreenBounds().width
                    let maxTabs = (maxWidth / screenWidth).rounded()
                    let progress = minX / screenWidth
                    let tabOffset = progress * (screenWidth / maxTabs)
                    
                    self.tabOffset = tabOffset
                    self.maxTabs = maxTabs
                    
                    
                }
                
            }
            

                
        }
    }
}

struct tabPreferenceKey : PreferenceKey{
    
    static var defaultValue: CGRect = .init()
    
    static func reduce(value: inout Value, nextValue: () -> Value) {
        
        value = nextValue()
        
    }
    
    
    
}

struct pagerTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



extension View{
    
    
    func pageLabel()->some View{
        
        self
            .frame(maxWidth:.infinity)
        
        
    }
    
    
    func pageView(ignoresSafeArea : Bool = false,edges : Edge.Set = [])->some View{
        
        self
            .frame(width: getScreenBounds().width)
            .ignoresSafeArea(ignoresSafeArea ? .container : .init(), edges: edges)
          
        
        
    }
    
    
    func getScreenBounds()->CGRect{
        
        
        return UIScreen.main.bounds
    }
    
}
