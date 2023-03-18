//
//  AddPlayListFailView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct AddPlayListFailView: View {

	let reason: String

	var body: some View {
		Text(reason).font(.title)
		.multilineTextAlignment(.center)
		.padding()
	}
}

struct AddPlayListFailView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayListFailView(reason: "")
    }
}
