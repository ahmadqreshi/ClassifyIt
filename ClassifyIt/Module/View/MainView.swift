//
//  ContentView.swift
//  ClassifyIt
//
//  Created by Ahmad Qureshi on 20/07/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var mainVM: MainViewModel = MainViewModel()
    var body: some View {
        BaseView {
            VStack(spacing: 20) {
                
                imagesCorousel
                
                prevNextButton
                
                classifyBtn
                    .padding(.vertical, 30)
                
                resultLabels
            }
        }
    }
    
    
    private var imagesCorousel: some View {
        TabView(selection: $mainVM.selectedImageIndex) {
            ForEach(Array(mainVM.images.enumerated()), id: \.offset) { index, image in
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .clipped()
                    .tag(index)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                    )
            }
        }
        .tabViewStyle(.page)
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
    
    private var prevNextButton: some View {
        HStack(spacing: 12) {
            
            
            Button {
                withAnimation {
                    if mainVM.selectedImageIndex > 0 {
                        mainVM.selectedImageIndex -= 1
                    }
                }
                
            } label: {
                Image(systemName: "arrow.left")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 15)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.gray))
                    )
            }
            
            Button {
                withAnimation {
                    if mainVM.selectedImageIndex < mainVM.images.count - 1  {
                        mainVM.selectedImageIndex += 1
                    }
                }
                
            } label: {
                Image(systemName: "arrow.right")
                    .resizable()
                    .foregroundColor(.black)
                    .frame(width: 20, height: 15)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.white))
                    )
            }

        }
    }
    
    private var classifyBtn: some View {
        Button {
            mainVM.analyzeImage()
        } label: {
            Text("Classify")
                .foregroundColor(.white)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.vertical, 10)
                .padding(.horizontal, 50)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(ColorAssets.dodgerBlue.set)
                )
        }
    }
    
    private var resultLabels: some View {
        VStack(spacing: 20) {
            Text(mainVM.resultLabel)
                .foregroundColor(.white)
                .font(.title)
                .padding(.horizontal, 16)
            Text(mainVM.accuracyLabel)
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
