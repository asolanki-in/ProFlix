//
//  CardAddView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct CardAddView: View {

	var body: some View {
		Image(systemName: "plus")
			.symbolRenderingMode(.hierarchical)
			.font(.system(size: 40))
			.fontWeight(.thin)
			.foregroundColor(.accentColor)
			.frame(minWidth: 200,maxWidth: 200, minHeight: 125, maxHeight: 125)
			.background(Color.systemGrayColor6)
			.cornerRadius(20)
			.shadow(color: Color.systemGrayColor5,radius: 2, x: 1, y: 1)
	}
}

struct CardAddView_Previews: PreviewProvider {
	static var previews: some View {
		CardAddView()
	}
}
