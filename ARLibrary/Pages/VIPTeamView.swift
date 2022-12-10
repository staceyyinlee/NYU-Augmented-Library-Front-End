//
//  VIPTeamView.swift
//  ARLibrary
//
//  Created by Brayton Lordianto on 12/9/22.
//

import SwiftUI

// the purpose of this view
// 1. Contact Page
// 2. Learn About VIP
// 3. Notable Members

struct VIPTeamView: View {
    var body: some View {
        Form {
            Section {
                Text("Contact Support")
                    .bold()
                    .font(.title)
                
                Text("Contact us and leave a review or let us know if there are any issues. We will try to resolve as soon as possible. Thanks for using our app!")
                    .listRowSeparator(.hidden)
                if let url = URL(string: "https://docs.google.com/forms/d/1AzXmAHnlnq-Lz6Fg4ihssULrMqjiN8FLhrNw4I-xsIU/viewform?edit_requested=true") {
                    Link("Link to Support Page", destination: url)
                }
            }
            Section {
                Text("Created By:")
                    .listRowSeparator(.hidden)
                 Text("Augmented Library Vertically Integrated Project Team, New York University")
                .font(.title)
                .multilineTextAlignment(.center)
                
                if let url = URL(string: "https://engineering.nyu.edu/research-innovation/student-research/vertically-integrated-projects/vip-teams/augmented-library") {
                    Link("Learn More About Us!", destination: url)
                }
            }
            
            Section {
                Text("Notable Team Members")
                    .bold()
                    .listRowSeparator(.hidden)
                
                Text(teamMembers)
                    .italic()
                
                Text("Professor Matthew Frankel - Supervisor")
                    .italic()
            }
            
            Section {
                Text("More Features Coming Soon")
                    .bold()
                    .italic()
            }
        }
    }
}

let teamMembers = """
Brayton Lordianto - Lead Developer
Stacey Lee - Lead Project Manager
Alisha Goel - Lead Designer
Emery Bosch - Developer
Thaison Le - Support
"""



struct VIPTeamView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VIPTeamView()
        }
    }
}
