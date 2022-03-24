//
//  Home.swift
//  VideoSeeker
//
//  Created by Taeyoun Lee on 2022/03/25.
//

import SwiftUI
import AVFoundation
import AVKit

struct Home: View {
    // Cover Image Properties
    @State var currentCoverImage: UIImage?
    @State var progress: CGFloat = 0
    @State var url = URL(fileURLWithPath: Bundle.main.path(forResource: "Test1", ofType: "mp4") ?? "")
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    NavigationLink("Done") {
                        if let currentCoverImage = currentCoverImage {
                            Image(uiImage: currentCoverImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 300)
                                .cornerRadius(15)
                        }
                    }
                }
                .overlay {
                    Text("Cover")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 10)
                
                Divider()
                    .background(Color.black.opacity(0.6))
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            // MARK: Current Cover Image
            GeometryReader { proxy in
                let size = proxy.size
                
                ZStack {
                    // Custom video player will show the preview
                    PreviewPlayer(url: $url, progress: $progress)
                        .cornerRadius(15)
                }
                .frame(width: size.width, height: size.height)
            }
            .frame(width: 200, height: 300)
            
            Text("To select a cover image, choose a from\nyour video or an image from your camera roll.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.vertical, 30)
            
            // MARK: Cover image scroller
            // Cover Image size
            let size = CGSize(width: 400, height: 400)
            VideoCoverScroller(videoURL: $url, progress: $progress, imageSize: size, coverImage: $currentCoverImage)
                .padding(.top, 50)
                .padding(.horizontal, 15)
            
            Button {
                
            } label: {
                
                Label {
                    Text("Add From Camera Roll")
                } icon: {
                    
                    Image(systemName: "plus.square")
                        .font(.title2)
                }
                .foregroundColor(.primary)
            }
            .padding(.vertical)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Custom Video Player
struct PreviewPlayer: UIViewControllerRepresentable {
    
    @Binding var url: URL
    @Binding var progress: CGFloat
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let player = AVPlayer(url: url)
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        let playerURL = (uiViewController.player?.currentItem?.asset as? AVURLAsset)?.url
        if let playerURL = playerURL, playerURL != url {
            print("Updated")
            uiViewController.player = AVPlayer(url: url)
        }
        // Updating Player Preview
        let duration = uiViewController.player?.currentItem?.duration.seconds ?? 0
        let time = CMTime(seconds: progress * duration, preferredTimescale: 600)
        uiViewController.player?.seek(to: time)
    }
}

// MARK: Custom Cover Scroller
struct VideoCoverScroller: View {
    // Making it Dynamic
    @Binding var videoURL: URL
    @Binding var progress: CGFloat
    
    @State var imageSequence: [UIImage]?
    
    // MARK: Gesture properties
    @State var offset: CGFloat = 0
    @GestureState var isDragging: Bool = false
    
    // MARK: Cover Image
    var imageSize: CGSize
    @Binding var coverImage: UIImage?
    
    var body: some View {
        
        GeometryReader { proxy in
            let size = proxy.size
            
            HStack(spacing: 0) {
                
                // Image Sequence
                if let imageSequence = imageSequence {
                    
                    ForEach(imageSequence, id: \.self) { index in
                        GeometryReader { proxy in
                            let subSize = proxy.size
                            
                            Image(uiImage: index)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: subSize.width, height: subSize.height)
                        }
                        .frame(height: size.height)
                    }
                }
            }
            .cornerRadius(6)
            .overlay(alignment: .leading, content: {
                ZStack(alignment: .leading) {
                    Color.black
                        .opacity(0.25)
                        .frame(height: size.height)
                    
                    
                    PreviewPlayer(url: $videoURL, progress: $progress)
                        .frame(width: 35, height: 60)
                        .cornerRadius(6)
                        .background(
                            
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(.white, lineWidth: 3)
                                .padding(-3)
                        )
                        .background(
                            
                            RoundedRectangle(cornerRadius: 6)
                                .strokeBorder(.black.opacity(0.2))
                                .padding(-4)
                        )
                        .offset(x: offset)
                        .gesture(
                            
                            DragGesture()
                                .updating($isDragging, body: { _, out, _ in
                                    out = true
                                })
                                .onChanged({ value in
                                    // Removing dragger radius
                                    // 35/2 = 17.5
                                    var translation = (isDragging ? value.location.x - 17.5 : 0)
                                    translation = translation < 0 ? 0 : translation
                                    translation = translation > size.width - 35 ? size.width - 35 : translation
                                    offset = translation
                                    
                                    // Updating progress
                                    progress = translation / (size.width - 35)
                                })
                                .onEnded({ _ in
                                    retrieveCoverImageAt(progress: progress, size: imageSize) { image in
                                        coverImage = image
                                    }
                                })
                        )
                }
            })
            .onAppear {
                if imageSequence == nil {
                    generateImageSequence()
                }
            }
            .onChange(of: videoURL) { _ in
                // Clearing Data and Regenerating for new url
                progress = 0
                offset = .zero
                coverImage = nil
                imageSequence = nil
                
                generateImageSequence()
                retrieveCoverImageAt(progress: progress, size: imageSize) { image in
                    coverImage = image
                }
            }
        }
        .frame(height: 50)
    }
    
    func generateImageSequence() {
        // Spiliting Duration into ? Secs of each
        let parts = (videoDuration() / 10)
        
        (0..<10).forEach { index in
            
            // Retrieving Cover Image
            // Converting Index to progress with respect to duration
            let progress = (CGFloat(index) * parts) / videoDuration()
            
            retrieveCoverImageAt(progress: progress, size: CGSize(width: 100, height: 100)) { image in
                // Checking if sequence is nil
                if imageSequence == nil {
                    imageSequence = []
                }
                imageSequence?.append(image)
            }
        }
    }
    
    func retrieveCoverImageAt(progress: CGFloat, size: CGSize, completion: @escaping (UIImage) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            let asset = AVAsset(url: videoURL)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            generator.maximumSize = size
            
            // Again converting progress into seconds
            let time = CMTime(seconds: progress * videoDuration(), preferredTimescale: 600)
            
            do {
                let image = try generator.copyCGImage(at: time, actualTime: nil)
                let cover = UIImage(cgImage: image)
                
                DispatchQueue.main.async {
                    completion(cover)
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    // Retrieving Duration
    func videoDuration() -> Double {
        let asset = AVAsset(url: videoURL)
        
        return asset.duration.seconds
    }
}
