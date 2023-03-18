//
//  ProFlixRootView.swift
//  ProFlix
//
//  Created by Anil Solanki on 19/02/23.
//

import SwiftUI

struct ProFlixRootView: View {

	@AppStorage(Const.defaultKeys.user_eula_agreed_key, store: .standard) var userAgreedEula : Bool = false

    var body: some View {
		Group {
			switch UIDevice.current.userInterfaceIdiom {
			case .tv:
				RootView()
			case .pad:
				LoadingDataView()
			case .phone:
				LoadingDataView()
			case .mac:
				LoadingDataView()
			default:
				Text("Unknown Device")
			}
		}
		.sheet(isPresented: $userAgreedEula.not) {
			UserAgreementView()
				.interactiveDismissDisabled(true)
		}
	}
}

struct ProFlixRootView_Previews: PreviewProvider {
    static var previews: some View {
        ProFlixRootView()
    }
}

extension Binding where Value == Bool {
	var not: Binding<Value> {
		Binding<Value>(
			get: { !self.wrappedValue },
			set: { self.wrappedValue = !$0 }
		)
	}
}
