//
//  AddingItemsView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AddingItemsView: View {

	let url: String
	let name: String
	let color: Color

    var body: some View {
		VStack(alignment: .center, spacing: 20) {
			SmallCardView(name, color: color)
			Text("Please donot close app while we are downloading playlist.")
				.font(.title)
			Text(url).disabled(true)
			ProgressView().controlSize(.large)
		}
		.multilineTextAlignment(.center)
		.padding()
    }
}

struct AddingItemsView_Previews: PreviewProvider {
	static var previews: some View {
		Text("")
			.sheet(isPresented: .constant(true)) {
				AddingItemsView(url: "", name: "", color: .gray)
			}
	}
}
