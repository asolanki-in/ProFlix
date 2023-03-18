//
//  UserAgreementView.swift
//  ProFlix
//
//  Created by Anil Solanki on 19/02/23.
//

import SwiftUI

struct UserAgreementView: View {

	@AppStorage(Const.defaultKeys.user_eula_agreed_key, store: .standard) var userAgreedEula : Bool = false


	let appName = "ProFlix - Simple IPTV App"

	var body: some View {
		switch UIDevice.current.userInterfaceIdiom {
		case .pad, .tv, .mac:
			iPadView
		default:
			iPhoneView
		}
	}

	var iPadView : some View {
		VStack(alignment: .center)  {
			Text("Disclaimer")
				.padding(.top, 30)
				.text(font: .largeTitle, weight: .bold, color: .primary)
			ScrollView {
				VStack(alignment: .leading, spacing:20) {
					Text("Thanks for using **\(appName)**. Happy to see you here. Before continue using this app, we recommend to read our following instructions.")
					Text("**\(appName)** is a player. It uses M3U, XML & JSON files/playlists to serve content. These files/playlists are created by users. We do not provide any content or playlists in this app.")
					VStack(alignment: .leading, spacing: 10) {
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("Users are responsible to create playlist/content in this app.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("User always has to make sure that content is legal and have rights to use it.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("We do not endorse the streaming of copyrighted content using our app.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("**\(appName)** has no afflication with any third party content provider or what so ever.")
						}
					}
					.fixedSize(horizontal: false, vertical: true)

					Text("By using our app indicates that user accepts above terms & conditions.").lineSpacing(5)
				}
				.lineSpacing(5)
				.padding(.horizontal, 100)
			}
			.text(font: .body, color: .primary)

			Button(action: actionAccept) {
				Text("Agree")
					.frame(maxWidth: .infinity)
					.text(font: .title3, weight: .medium,color: .primary)
			}
			.buttonStyle(.borderedProminent)
			.controlSize(.large)
			.padding(50)
			.padding(.horizontal, 50)
		}
		//.background(Color.primaryBackground)
	}

	var iPhoneView : some View {
		VStack(alignment: .center)  {
			Text("Disclaimer")
				.padding(.top, 30)
				.text(font: .largeTitle, weight: .bold, color: .primary)
			ScrollView(showsIndicators: false) {
				VStack(alignment: .leading, spacing:20) {
					Text("Thanks for using **\(appName)**. Happy to see you here. Before continue using this app, we recommend to read our following instructions.")
					Text("**\(appName)** is a player. It uses M3U, XML & JSON files/playlists to serve content. These files/playlists are created by users. We do not provide any content or playlists in this app.")
					VStack(alignment: .leading, spacing: 10) {
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("Users are responsible to create playlist/content in this app.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("User always has to make sure that content is legal and have rights to use it.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("We do not endorse the streaming of copyrighted content using our app.")
						}
						HStack(alignment: .top) {
							Text("·").fontWeight(.black)
							Text("**\(appName)** has no afflication with any third party content provider or what so ever.")
						}
					}
					.fixedSize(horizontal: false, vertical: true)

					Text("By using our app indicates that user accepts above terms & conditions.").lineSpacing(5)
				}
				.padding(.horizontal, 20)
			}
			.text(font: .callout, color: .primary)

			Button(action: actionAccept) {
				Text("Agree")
					.frame(maxWidth: .infinity)
					.text(font: .title3, weight: .medium, color: .primary)
			}
			.buttonStyle(.borderedProminent)
			.controlSize(.large)
			.padding(20)
		}
	}


	private func actionAccept() {
		self.userAgreedEula = true
	}
}

struct UserAgreementView_Previews: PreviewProvider {
	static var previews: some View {
		UserAgreementView()
	}
}
