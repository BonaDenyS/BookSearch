//
//  HomeView.swift
//  BookSearch
//
//  Created by Bona Deny S on 11/7/20.
//  Copyright © 2020 Bona Deny S. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var vm: HomeViewModel
    
    var body: some View {
        VStack {
            SearchbarView(vm: vm)
            List {
                ForEach(self.vm.books, id: \.self) { (item:Item) in
                    BookView(book: item.volumeInfo)
                }
            }.padding(0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(vm: HomeViewModel())
    }
}

struct SearchbarView: View {
    @ObservedObject var vm: HomeViewModel
    
    @State private var showCancelButton: Bool = false
    @State private var keyword = ""
    
    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    self.vm.fetching(self.keyword)
                }) {
                     Image(systemName: "magnifyingglass")
                }

                TextField("search", text: $keyword, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                }, onCommit: {
                    self.vm.fetching(self.keyword)
                }).foregroundColor(.primary)

                Button(action: {
                    self.keyword = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(keyword == "" ? 0 : 1)
                }
            }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)

                if showCancelButton  {
                    Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.keyword = ""
                            self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }.padding(.horizontal)
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct BookImageView: View {
    
    @ObservedObject var view: ImageLoader
                
    init(url: String?, placeholder: String) {
        view = ImageLoader(from: url, placeholder: placeholder)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Image(uiImage: view.loaded).resizable()
        }.blur(radius: view.loading ? 3 : 0)
    }
    
}

struct BookView: View {
    let book: Book
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 10) {
                BookImageView(url: book.imageLinks?.thumbnail, placeholder: "book")
                    .aspectRatio(contentMode: .fit).frame(width: 80, alignment: .center)
                
                VStack(alignment: .leading) {
                    HStack() {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Title").font(.system(size: 14))
                            Text("Author").font(.system(size: 14))
                            Text("Publisher").font(.system(size: 14))
                        }
                        VStack {
                            Text(" : ")
                            Text(" : ")
                            Text(" : ")
                        }
                        VStack(alignment: .leading,  spacing: 5) {
                            Text(book.title).font(.system(size: 14)).lineLimit(1)
                            Text(book.authors?[0] ?? "-").font(.system(size: 14)).lineLimit(1)
                            Text(book.publisher ?? "-").font(.system(size: 14)).lineLimit(1)
                        }
                    }
                    ZStack(alignment: .leading) {
                        HStack {
                            ForEach(0..<5, id: \.self) { index in
                                StarRatingView(rating: self.book.averageRating ?? 0.0, index: Float(index))
                            }
                        }
                    }
                }
            }
        }.frame(height: 150)
    }
}

struct StarRatingView: View {
    let rating, index: Float
    
    var body: some View {
        VStack {
            if rating - index < 0 {
                Image(systemName: "star")
                .foregroundColor(Color.orange)
            }else if rating - index < 1 {
                Image(systemName: "star.lefthalf.fill")
                .foregroundColor(Color.orange)
            }else {
                Image(systemName: "star.fill")
                .foregroundColor(Color.orange)
            }
        }
    }
}
