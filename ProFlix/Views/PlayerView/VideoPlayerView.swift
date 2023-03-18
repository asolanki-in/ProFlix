//
//  VideoPlayerView.swift
//  ProFlix
//
//  Created by Anil Solanki on 25/02/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {

	let url : URL
	let title: String

	@State var status : VideoStatus = .failed("")
	@State var showVideoLoader = true
	@State var errorString = ""

	var body: some View {
		ZStack {
			ProFlixPlayer(url: url, status: $status)
			if showVideoLoader {
				ProgressView().controlSize(.large)
			}
			if errorString.isEmpty == false {
				Text(errorString).padding(.bottom, 90).foregroundColor(.secondary)
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbarBackground(.hidden, for: .navigationBar)
		.navigationTitle(title)
		.onChange(of: status) { newValue in
			switch newValue {
			case .playing:
				showVideoLoader = false
				print("Playing Video")
				self.errorString = ""
			case .failed(let error):
				showVideoLoader = false
				self.errorString = error
			}
		}
	}
}

enum VideoStatus : Equatable, Hashable {
	case playing
	case failed(String)
}
