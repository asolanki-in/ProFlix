//
//  VideoPlayer+UIViewRepresentable.swift
//  ProFlix
//
//  Created by Anil Solanki on 25/02/23.
//

import SwiftUI
import AVKit

struct ProFlixPlayer : UIViewControllerRepresentable {

	var url: URL
	@Binding var status : VideoStatus

	let avplayer : AVPlayer
	let playerItem : AVPlayerItem

	

	init(url: URL, status: Binding<VideoStatus>) {
		self.url = url
		self._status = status
		let item = AVPlayerItem(asset: AVAsset(url: url), automaticallyLoadedAssetKeys: ["playable", "hasProtectedContent"])
		self.avplayer = AVPlayer(playerItem: item)
		self.playerItem = item
	}

	func makeUIViewController(context: Context) -> AVPlayerViewController {
		let vc = AVPlayerViewController()
		vc.player = avplayer
		vc.player?.preventsDisplaySleepDuringVideoPlayback = true
		return vc
	}

	func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) { }

	func makeCoordinator() -> Coordinator {
		let coordinator = Coordinator(playerItem)
		coordinator.prepareToPlay { avplayer, change in
			switch playerItem.status {
			case .readyToPlay:
				self.avplayer.play()
				self.status = .playing
			case .failed, .unknown:
				self.status = .failed(playerItem.error?.localizedDescription ?? "Unknown Error While Playing")
			@unknown default:
				self.status = .failed(playerItem.error?.localizedDescription ?? "Unknown Error While Playing")
			}
		}
		return coordinator
	}

	class Coordinator: NSObject {

		let item : AVPlayerItem
		var observer: NSKeyValueObservation?

		init(_ item: AVPlayerItem) {
			self.item = item
		}

		func prepareToPlay(changeHandler: @escaping (AVPlayerItem, NSKeyValueObservedChange<AVPlayerItem.Status>) -> Void) {
			self.observer = item.observe(\.status, options:  [.new, .old], changeHandler: changeHandler)
		}

		deinit {
			self.observer?.invalidate()
		}
	}
}
