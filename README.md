# NYU-Augmented-Library-Front-End
iOS NYU Augmented Library 


**PLEASE READ THE MAIN BRANCH README FIRST.**

Important Terms: Augmented Reality (AR), ARView (Swift view that renders AR).

[Link to Main Branch](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End)

This is an unreleased branch of the `3Dibner` app with beta features. This branch is geared towards displaying the 3D models more memory-efficiently. The selected approach is to store 3D models in the cloud and fetch them through APIs when needed. The API currently in use is [Echo3D](https://www.echo3d.com/). 

Run the app [the same way as with the main branch](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End). However, do note that the API key has a limited number of API calls and, therefore, may not yield correct results. To ensure correct results, change the API key to a personal Echo3D API in the Echo3D files and upload the 3D models, which can be found in the main branch. 


### Additional Files to Main Branch

[Find them in this Folder.](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/tree/cloud-alt-main/ARLibrary/Echo3D_Files)



* Echo3D Integration

This file handles fetching from the Echo3D API and stores the data of available 3D models into EchoModel objects. This contains inexpensive metadata of the files that may or may not be needed in the future of the app. 



* Echo3D File Manager

This file handles all the file-related operations, including downloading the actual files from the Echo3D API, fetching cached files, and deleting previously downloaded files when not needed. 



* Echo3D Model

This file is the skeleton model of all the metadata fetched from the API. 



* ARViewModel

The view model allows for a flexible connection between the ARView that is displayed and the model that is downloaded by the EchoViewModel and file manager. It also receives the required instructions on the ARView, which allows for the seamless integration of different functionality in rendering the model in both [ImmersionARFocusEntityView.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/ImmersionARFocusEntityView.swift) and [MovableObjectARViewContainer.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/MovableObjectARViewContainer.swift).


### Changes to main



1. In [MovableObjectARViewContainer.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/MovableObjectARViewContainer.swift), the EchoViewModel will first fetch information relating to the API in a background thread. The data it fetches and stores can be found in the EchoModel. **This data does not include the 3D models, only metadata of it.**
2. The AR files in use have been changed to accept models from the cloud rather than from the app directory. This change can be found in [HomeView.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/HomeViewComponents/HomeView.swift). Instead of simply calling the model (since the model does not exist in the directory), the necessary functions to the ARView is sent to the ARViewModel, along with the model name to be loaded. The ARViewModel will then download the necessary file after deleting previously downloaded files and render the model according to the instructions of the ARView. 
3. Support for [ImmersionARFocusEntityView.swift](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/cloud-alt-main/ARLibrary/ARViewComponents/ImmersionARFocusEntityView.swift) will be added soon. 


### Discussion

Currently, fetching from the cloud causes latency issues and deteriorates performance. However, if the app supports more 3D models in the future, it may be necessary to sacrifice performance for memory-efficiency. In addition, due to limited Echo3D API credits, fetching data from the API is limited and has to be replenished, or otherwise have a paid Echo3D subscription. This branch will hold as a starting point for when memory-efficiency is needed. As of now, it is infeasible to use this feature in the main release of the app. 
