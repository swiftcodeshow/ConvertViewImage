//
//  ContentView.swift
//  ConvertViewImage
//
//  Created by 米国梁 on 2021/4/27.
//

import SwiftUI

extension View {
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

struct ContentView: View {
    
    @State var showRectangle = true
    
    @State var showCircle = true
    
    @State var image: UIImage?
    
    var body: some View {
        
        VStack {
            
            // Declare view but not be embed right now,
            // because we hold it with a variable
            let canvas = HStack {
            
                if showRectangle {
                    
                    Rectangle()
                        .fill()
                        .foregroundColor(.green)
                }
            
                if showCircle {
                 
                    Circle()
                        .fill()
                        .foregroundColor(.red)
                }
            }
            // set size of the destination view here not later,
            // otherwise you will get wrong size of your image
            .frame(width: 300, height: 300)
            
            HStack {
                
                Button("\(showRectangle ? "Hide" : "Show") a Rectangle") {
                    showRectangle.toggle()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                
                Button("\(showCircle ? "Hide" : "Show") a Circle") {
                    showCircle.toggle()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                
                Button("Generate final image") {
                    image = canvas.snapshot()
                }
                .background(Color.red)
                .foregroundColor(.white)
            }
            
            canvas
            
            Text("Your generated image below: ")
            
            if let img = image {
                
                Image(uiImage: img)
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
