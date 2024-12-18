import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    
    let carouselImages: [UIImage] = {
        return (0...7).compactMap { UIImage(named: "image-\($0)")}
    }()
    
    @State private var listItems: [ListItem] = (1...20).map { item in
        ListItem(title: "image-\(item)", subtitle: "subtitle test")
    }
    
    
    // For search filter
    @State private var searchText: String = ""
    
    @State private var isPinned: Bool = false
    
    var filteredItems: [ListItem] {
        if searchText.isEmpty {
            return listItems
        } else {
            return listItems.filter {
                $0.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView {
            LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                VStack(spacing: 0) {
                    // MARK: - Image Carousel
                    TabView {
                        ForEach(carouselImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding()
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(height: 220)
                }
                .padding(.bottom, 8)
                
                
                // MARK: - Scrollable List
                Section(header:searchBar) {
                    ForEach(filteredItems) { item in
                        HStack {
                            Image("image-0")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                Text(item.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    
                }
                .padding(.horizontal, 8)
                .padding(.top, 8)

            }
        }
    }
    
    var searchBar: some View {
        ZStack {
            Color.white // Ensures no transparency
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search...", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
            }
            .padding()
            .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 0, y: 2)
        }
        .background(Color.white)
        .zIndex(1)
    }
}

// MARK: - List Item Model

struct ListItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
