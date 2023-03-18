//
//  AddQuickPlayFormView.swift
//  ProFlix
//
//  Created by Anil Solanki on 07/03/23.
//

import SwiftUI

struct AddQuickPlayFormView: View {

	@ObservedObject var observed : AddQuickPlayListView.Observed

	var body: some View {
		Form {
			Section(footer: Text(observed.validationMessage).foregroundColor(.red)) {
				VStack(spacing: 20) {
					SmallCardView(observed.name, color: observed.color)
					TextField("Enter name", text: $observed.name)
						.padding(8)
						.background(Color.systemGrayColor6)
						.cornerRadius(6)
						.textContentType(.none)
						.multilineTextAlignment(.center)

					TextField("URL", text: $observed.url)
						.padding(8)
						.background(Color.systemGrayColor6)
						.cornerRadius(6)
						.textContentType(.URL)
						.multilineTextAlignment(.center)
						.keyboardType(.URL)
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
				.padding(.top)
				.padding(.bottom, 8)
			}
		}
	}
}

//struct AddQuickPlayFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddQuickPlayFormView()
//    }
//}
