//
//  ContentView.swift
//  Sentiment1
//
//  Created by Manvendu Pathak on 12/07/23.
//

import SwiftUI
import UIKit
import SwiftUI
import NaturalLanguage



struct ContentView: View {
    @State private var text: String = ""
    private var sentiment: String {
        return performSentimentAnalysis(for: text)
        
    }
    private let tagger  = NLTagger(tagSchemes: [.sentimentScore])
    
    var body: some View {
       
        VStack {
            image(for: sentiment)
                .animation(.default)
            
            TextField("Write something about your day", text: $text)
                .padding(.all)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
            
        }
        .frame(width: 250, height: 300)
        
    }
    
    private func performSentimentAnalysis(for string: String) -> String{
        
        tagger.string = string
        let (sentiment, _) = tagger.tag(at: string.startIndex, unit: .paragraph, scheme: .sentimentScore)
        return sentiment?.rawValue ?? ""
     
    }
    
    private func image(for sentiment: String) -> Image? {
        guard let value = Double(sentiment) else{
            return nil
        }
        if value > 0.5{
            return Image("happy").resizable()
            
        }else if value >= 0 {
            return Image("positive").resizable()
               
           
        } else if value > -0.5 {
            return Image("worried").resizable()
               
        } else {
            return Image("crying").resizable()
                
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
