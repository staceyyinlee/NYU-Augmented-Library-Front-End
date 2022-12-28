//
//  HomeNavigationModel.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/7/22.
//

import Foundation

struct ViewableSpaceItem: Hashable {
    let displayText: String
    let associatedImageName: String
    let associatedModelName: String
    let description: String
    let reserveURL: String
    
    init(displayText: String, associatedImageName: String, _ associatedModelName: String? = nil, description: String = "", reserveURL: String = "") {
        self.displayText = displayText
        self.associatedImageName = associatedImageName
//        self.associatedModelName = (associatedModelName ?? associatedImageName) + ".usdz"
        self.associatedModelName = (associatedModelName ?? associatedImageName)
        self.description = description
        self.reserveURL = reserveURL
    }
}

let presetViewableItems: [ViewableSpaceItem] = [
    ViewableSpaceItem(displayText: "Computer Lab", associatedImageName: "computer_lab",
                      description: "The Dibner computer lab features 16 PC computers (Precision 3460s with VPro i-7 processors) with specialized software for use by NYU students, faculty, and staff.\n\nThe lab is open when the Dibner Library building is open.",
                      reserveURL: "https://library.nyu.edu/spaces/dibner-computer-lab/"),
    ViewableSpaceItem(displayText: "Individual Room", associatedImageName: "individual_room",
                      description: "Dibner Library has 20 individual rooms available for use by NYU students. Rooms are available during library open hours.",
                      reserveURL: "https://library.nyu.edu/spaces/dibner-individual-study-rooms/"),
    ViewableSpaceItem(displayText: "Study Room (Small)", associatedImageName: "four_people_room",
                      description: "Dibner Library has 17 small, and 4 large group study rooms available for use by NYU students. Rooms are available for reservations during library open hours.\n\nSmall group rooms hold a minimum of 2 people, and a maximum of 5.",
                      reserveURL: "https://library.nyu.edu/spaces/dibner-group-study-rooms/"),
    ViewableSpaceItem(displayText: "Study Room (Large)", associatedImageName: "eight_people_room",
                      description: "Dibner Library has 17 small, and 4 large group study rooms available for use by NYU students. Rooms are available for reservations during library open hours.\n\nLarge group rooms hold a minimum of 4 people, and a maximum of 8.",
                      reserveURL: "https://library.nyu.edu/spaces/dibner-group-study-rooms/"),
]
