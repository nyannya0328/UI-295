//
//  offSetTabView.swift
//  offSetTabView
//
//  Created by nyannyan0328 on 2021/08/26.
//

import SwiftUI

struct offSetTabView<Content : View>: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return offSetTabView.Coordinator(parent: self)
    }
    
    var content : Content
    
    @Binding var offSet : CGFloat
    @Binding var selection : Int
    
    
    init(selection : Binding<Int>, offset : Binding<CGFloat>, @ViewBuilder content : @escaping()->Content) {
     
        self.content = content()
        self._offSet = offset
        self._selection = selection
    }
    
    let scroll = UIScrollView()
  
    func makeUIView(context: Context) -> UIScrollView{
        setUpScroll(scroll)
        scroll.delegate = context.coordinator
        return scroll
        
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
        let currentOffset = uiView.contentOffset.x
        
        if offSet != currentOffset{
        
        
        uiView.setContentOffset(CGPoint(x: offSet, y: 0), animated: true)
            
        }
        
    }
    
    func setUpScroll(_ scroll : UIScrollView){
        
        scroll.isPagingEnabled = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        
        let hostView = UIHostingController(rootView: content)
        hostView.view.backgroundColor = .clear
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let contanins = [
        
            hostView.view.topAnchor.constraint(equalTo: scroll.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            hostView.view.heightAnchor.constraint(equalTo: scroll.heightAnchor),
        
        
        ]
        
        scroll.addSubview(hostView.view)
        scroll.addConstraints(contanins)
        
        
        
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate{
        
        var parent : offSetTabView
        
        init(parent : offSetTabView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            let offset = scrollView.contentOffset.x
            
            let maxSize = scrollView.contentSize.width
            parent.selection = Int(maxSize)
            
            parent.offSet = offset
            
        }
        
    }
    
  
}

struct offSetTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
