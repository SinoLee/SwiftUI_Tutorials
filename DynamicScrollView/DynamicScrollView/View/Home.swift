//
//  Home.swift
//  DynamicScrollView
//
//  Created by Taeyoun Lee on 2022/09/25.
//

import SwiftUI

struct Home: View {
    // MARK: View Properties
    @State var characters: [Character] = []
    // MARK: Gesture Properties
    @GestureState var isDragging: Bool = false
    @State var isDrag: Bool = false
    @State var offsetY: CGFloat = 0
    
    @State var currentActiveIndex: Int = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        // MARK: Sample Contacts View
                        ForEach(characters) {character in
                            contactsForCharacter(character)
                                .id(character.index)
                        }
                    }
                    .padding(.top, 15)
                    .padding(.trailing, 100)
                }
                .onChange(of: currentActiveIndex) { newValue in
                    // MARK: Scrolling to current index
                    // This is also happening at the same time, that's why it's not scrolling
                    if isDrag {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            proxy.scrollTo(currentActiveIndex, anchor: .top)
                        }
                    }
                }
            }
            .navigationTitle("Contact's")
            .offset { offsetRect in
                if offsetRect.minY != startOffset {
                    startOffset = offsetRect.minY
                }
            }
        }
        // MARK: Why overlay
        // Because we don't need to cut down the navigation stack header blur view
        .overlay(alignment: .trailing, content: {
            CUstomScroller()
                .padding(.top, 35)
        })
        .onAppear {
            characters = fetchCharacters()
            // MARK: Initial check
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                characterElevation()
            }
        }
    }
    
    // MARK: Custom Scroller
    @ViewBuilder
    func CUstomScroller() -> some View {
        // MARK: Geometry reader for calculations
        GeometryReader { proxy in
            let rect = proxy.frame(in: .named("SCROLLER"))
            
            VStack(spacing: 0) {
                ForEach($characters) { $character in
                    // MARK: To find each alphabet origin on the screen
                    HStack(spacing: 15) {
                        GeometryReader { innerProxy in
                            let origin = innerProxy.frame(in: .named("SCROLLER"))
                            
                            Text(character.value)
                                .font(.callout)
                                .fontWeight(character.isCurrent ? .bold : .semibold)
                                .foregroundColor(character.isCurrent ? .black : .gray)
                                .scaleEffect(character.isCurrent ? 1.4 : 0.8)
                                // iOS 16+
                                .contentTransition(.interpolate)
                                .frame(width: origin.size.width, height: origin.size.height, alignment: .trailing)
                                .overlay {
                                    Rectangle()
                                        .fill(.gray)
                                        .frame(width: 15, height: 0.8)
                                        .offset(x: 35)
                                }
                                .offset(x: character.pusOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.pusOffset)
                                .animation(.easeInOut(duration: 0.2), value: character.isCurrent)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        // MARK: Storing Origin
                                        character.rect = origin
                                    }
                                }
                        }
                        .frame(width: 20)
                        
                        // MARK: Displaying only for first item (aka scroller)
                        ZStack {
                            if characters.first?.id == character.id {
                                scrollerKnob(character: $character, rect: rect)
                            }
                        }
                        .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .frame(width: 55)
        .padding(.trailing, 10)
        .coordinateSpace(name: "SCROLLER")
        .padding(.vertical, 15)
    }
    
    @ViewBuilder
    func scrollerKnob(character: Binding<Character>, rect: CGRect) -> some View {
        Circle()
            .fill(.black)
            // MARK: Scaling animation
            .overlay(content: {
                Circle()
                    .fill(.white)
                    .scaleEffect(isDragging ? 0.8 : 0.0001)
            })
            .scaleEffect(isDragging ? 1.35 : 1)
            .animation(.easeInOut(duration: 0.2), value: isDragging)
            .offset(y: offsetY)
            .gesture(
                // MARK: Drag Gesture
                DragGesture(minimumDistance: 5)
                    .updating($isDragging, body: { _, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        // MARK: Setting Location
                        // Reducting Knob size
                        var translation = value.location.y - 20
                        // MARK: Limiting translation
                        // Reducting Knob size
                        translation = min(translation, rect.maxY - 20)
                        translation = max(translation, rect.minY)
                        offsetY = translation
                        characterElevation()
                    })
                    .onEnded({ value in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            isDrag = false
                        }
                        // MARK: Setting to last character location
                        if characters.indices.contains(currentActiveIndex) {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                offsetY = characters[currentActiveIndex].rect.minY
                            }
                        }
                    })
            )
    }
    
    // MARK: Checking for character elevation when gesture is started
    func characterElevation() {
        // MARK: We're going to verify offset lies in the character region with the help of CGRect's default contain's property
        if let index = characters.firstIndex(where: { character in
            character.rect.contains(CGPoint(x: 0, y: offsetY))
        }) {
            updateElevation(index: index)
        }
    }
    
    // MARK: Reusable
    func updateElevation(index: Int) {
        // MARK: Modifier indices array
        var modifiedIndicies: [Int] = []
        
        // MARK: Updating side offset
        characters[index].pusOffset = -35
        characters[index].isCurrent = true
        currentActiveIndex = index
        modifiedIndicies.append(index)
        
        // MARK: Updating top and bottom 3 offset's in order to create a curve animation
        // Your custom offsets
        let otherOffsets: [CGFloat] = [-25, -15, -5]
        for index2 in otherOffsets.indices {
            // EG index + 1, Index + 2, Index + 3
            let newIndex = index + (index2 + 1)
            // MARK: Top indexes (negative)
            // EG index - 1, Index - 2, Index - 3
            let newIndexNegative = index - (index2 + 1)
            
            if verifyAndUpdate(index: newIndex, offset: otherOffsets[index2]) {
                modifiedIndicies.append(newIndex)
            }
            
            if verifyAndUpdate(index: newIndexNegative, offset: otherOffsets[index2]) {
                modifiedIndicies.append(newIndexNegative)
            }
        }
        
        // MARK: Setting remaining all other characters offset to zero
        for index3 in characters.indices {
            if !modifiedIndicies.contains(index3) {
                characters[index3].pusOffset = 0
                characters[index3].isCurrent = false
            }
        }
    }
    
    // MARK: Safety check
    func verifyAndUpdate(index: Int, offset: CGFloat) -> Bool {
        if characters.indices.contains(index) {
            characters[index].pusOffset = offset
            // Since its not the main
            characters[index].isCurrent = false
            return true
        }
        return false
    }
    
    // MARK: Contact Row for each alphabet
    @ViewBuilder
    func contactsForCharacter(_ character: Character) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(character.value)
                .font(.largeTitle.bold())
            
            ForEach(1...4, id: \.self) { _ in
                HStack(spacing: 10) {
                    Circle()
                        .fill(character.color.gradient)
                        .frame(width: 45, height: 45)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.6).gradient)
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(character.color.opacity(0.4).gradient)
                            .frame(height: 20)
                            .padding(.trailing, 80)
                    }
                }
            }
        }
        .padding(15)
        .offset { offsetRect in
            let minY = offsetRect.minY
            let index = character.index
            
            // MARK: Logic is simple, if miny is reaches the top, ie: navigation stack header, then we will update appropriate character in the custom scroller
            // Since we have NavigationStack, so we need to know the StartTop offset
            if minY > 20 && minY < startOffset && !isDrag {
                // MARK: Update Scroller
                updateElevation(index: index)
                withAnimation(.easeInOut(duration: 0.15)) {
                    offsetY = characters[index].rect.minY
                }
            }
        }
    }
    
    // MARK: Fetching characters
    func fetchCharacters() -> [Character] {
        let alphabets: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var characters: [Character] = []
        
        characters = alphabets.compactMap({ character -> Character? in
            return Character(value: String(character))
        })
        
        // MARK: Sample Color's
        let colors: [Color] = [.red, .yellow, .pink, .orange, .cyan, .indigo, .purple, .blue]
        
        // MARK: Setting Index and Random color
        for index in characters.indices {
            characters[index].index = index
            characters[index].color = colors.randomElement()!
        }
        
        return characters
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// 20: 46
// How Come It's Bouncing?
// Because DragGesture's Update()
// Method is finishing before our animation, which is 0.2s, as a workaround we're creating a new
// @State which will delay its finish by 0.25s.
