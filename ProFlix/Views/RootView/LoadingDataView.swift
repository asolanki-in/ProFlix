//
//  LoadingDataView.swift
//  ProFlix
//
//  Created by Anil Solanki on 05/03/23.
//

import SwiftUI

struct LoadingDataView: View {

	@EnvironmentObject var coreData : CoreDataEnvironmentObject

    var body: some View {
		Group {
			if coreData.fetching {
				ProgressView()
					.controlSize(.large)
					.task {
						coreData.fetchAll()
					}
			} else {
				RootView()
			}
		}
    }
}

struct LoadingDataView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingDataView()
    }
}
