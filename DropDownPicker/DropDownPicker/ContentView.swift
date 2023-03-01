//
//  ContentView.swift
//  DropDownPicker
//
//  Created by Taeyoun Lee on 2023/03/01.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: String = "Easy"
    @Environment(\.colorScheme) var scheme
    var body: some View {
        VStack {
            DropDown(
                content: ["Easy", "Normal", "Hard", "Expert"],
                selection: $selection,
                activeTint: .primary.opacity(0.1),
                inActiveTint: .primary.opacity(0.05),
                dynamic: true
            )
            .frame(width: 130)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background {   // iOS 15.0 or newer
            if scheme == .dark {
                Color("BG")
                    .ignoresSafeArea()
            }
        }
        .preferredColorScheme(.dark)
    }
}
// You'll note that if the view is at the top, the "dynamic drop-down" is not visible, therefore use "natural drop-down" effect. 

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: Custom View Builder
struct DropDown: View {
    // Drop Down Properties
    var content: [String]
    @Binding var selection: String
    var activeTint: Color
    var inActiveTint: Color
    var dynamic: Bool = true
    // View Properties
    @State private var expandView: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            
            VStack(alignment: .leading, spacing: 0) {
                if !dynamic {
                    RowView(selection, size)
                }
                let dropDownContent = content.filter {dynamic ? true : $0 != selection }
                ForEach(dropDownContent, id: \.self) { title in
                    RowView(title, size)
                }
            }
            .background {
                Rectangle()
                    .fill(inActiveTint)
                    .transition(.identity)
            }
            // Moving View based on the selection
            .offset(y: dynamic ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
        }
        .frame(height: 55)
        .overlay(alignment: .trailing) {
            Image(systemName: "chevron.up.chevron.down")
                .padding(.trailing, 10)
        }
        .mask(alignment: .top) {
            // The default mask alignment is center; updating it to start from the top
            Rectangle()
            // Since the view inside is moved based on selection, we need to update the masking too; otherwise, it always stays at the top and will not show the views that moved to the top
                .frame(height: expandView ? CGFloat(content.count) * 55 : 55)
            // Moving the mask based on the selection, so that every content will be visible
            // Visible only when content is expanded
                .offset(y: dynamic && expandView ? (CGFloat(content.firstIndex(of: selection) ?? 0) * -55) : 0)
            // We only need the views to appear when the view is expanded;
        }
        // *Add zIndex(1000) to ensure that it is at the top of all views
    }
    
    // Row View
    @ViewBuilder
    func RowView(_ title: String, _ size: CGSize) -> some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .frame(width: size.width, height: size.height, alignment: .leading)
            .background {
                if selection == title {
                    Rectangle()
                        .fill(activeTint)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    //expandView.toggle()
                    if expandView {
                        expandView = false
                        // Disabling animation for non-dynamic contents
                        if dynamic {
                            selection = title
                        }
                        else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                selection = title
                            }
                        }
                    }
                    else {
                        // You'll see that the views can still be accessed even if they aren't extended, avoiding that as well
                        // Disabling outside taps
                        if selection == title {
                            expandView = true
                        }
                    }
                }
            }
    }
}
