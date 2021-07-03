//
//  GridView.swift
//  Tacademia
//
//  Created by Nivas Muthu M G on 03/07/21.
//

import SwiftUI

struct GridView<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<columns) { column in
                        content(row, column)
                            .padding(.bottom, 10)
                            .padding(.trailing, column == columns - 1 ? 10 : 0)
                            .padding(.leading, 10)
                    }
                }
            }
        }
    }
}

//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        GridView()
//    }
//}
