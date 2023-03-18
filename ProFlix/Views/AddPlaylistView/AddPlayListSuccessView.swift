//
//  AddPlayListSuccessView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AddPlayListSuccessView: View {

	let url: String
	let name: String
	let color: Color

	var body: some View {
		VStack(alignment: .center, spacing: 20) {
			SmallCardView(name, color: color)
			Text("Successfuly Downloaded")
				.font(.title)
			Text(url).disabled(true)
			Image(systemName: "checkmark.circle.fill").font(.system(size: 50))
				.foregroundColor(.green)
		}
		.multilineTextAlignment(.center)
		.padding()
	}
}

struct AddPlayListSuccessView_Previews: PreviewProvider {
    static var previews: some View {
		AddPlayListSuccessView(url: "http://google.com", name: "Anil Solanki", color: .green)
    }
}
