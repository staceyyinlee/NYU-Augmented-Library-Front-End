* Echo3D Integration

This file handles fetching from the Echo3D API and stores the data of available 3D models into EchoModel objects. This contains inexpensive metadata of the files that may or may not be needed in the future of the app. 



* Echo3D File Manager

This file handles all the file-related operations, including downloading the actual files from the Echo3D API, fetching cached files, and deleting previously downloaded files when not needed. 



* Echo3D Model

This file is the skeleton model of all the metadata fetched from the API. 



* ARViewModel

The view model allows for a flexible connection between the ARView that is displayed and the model that is downloaded by the EchoViewModel and file manager. It also receives the required instructions on the ARView, which allows for the seamless integration of different functionality in rendering the model in both [ImmersionARFocusEntityView.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/ImmersionARFocusEntityView.swift) and [MovableObjectARViewContainer.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/MovableObjectARViewContainer.swift).
