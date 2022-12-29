

### Overview

The general functionality of the application is that users can view one of four rooms in the NYU Dibner Library (more to be supported). These rooms are the computer lab, the individual study room, the small group study room, and the large group study room. Users can quickly see room descriptions, be redirected to reservation links for each room, and view the respective rooms in 3D. The 3D view includes both viewing a miniature 3D model of the room that they can play around with as well as an immersion of a large 3D model of the room situated on the floor of users. 


### Table of Contents

This readme file will contain screenshots, brief descriptions, and links to the code files of the following pages in the application.



* [Home page](#home-page) 
* [Description Page](#description-page) 
* [Miniature Augmented Reality Page](#miniature-augmented-reality-page)
* [Immersion Augmented Reality Page](#immersion-augmented-reality-page) 


#### Home Page

![Gif 1](https://media3.giphy.com/media/nSr7EhWaMV3suRgXKc/giphy.gif)

Clicking on any of the rooms will redirect the user to the corresponding _Description page_ of the room.

Files: [Here](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/main/ARLibrary/HomeViewComponents/HomeView.swift), [Model Here](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/main/ARLibrary/Model/HomeNavigationModel.swift)


#### Description Page

![Gif 2](https://media2.giphy.com/media/IR6nqe1WzdUDgiiYQe/giphy.gif)

![Gif 3](https://media1.giphy.com/media/ij5vv6Emfc7pY1JmZ6/giphy.gif)

There is a description of the selected room. There is a link that allows the user to reserve the given room quickly and to view more information about the room. 

Files: [Here](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/main/ARLibrary/Pages/DescriptionView.swift)


#### Miniature Augmented Reality Page

![Gif 4](https://media3.giphy.com/media/VnoF8horHTDQs5x2eV/giphy.gif)
<img src="https://media3.giphy.com/media/VnoF8horHTDQs5x2eV/giphy.gif">
[Screenshot](https://media3.giphy.com/media/VnoF8horHTDQs5x2eV/giphy.gif)

Given a certain room, the user can see a draggable, movable, and miniaturized 3D model of the room. 

Files: [Here](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/main/ARLibrary/ARViewComponents/MovableObjectARViewContainer.swift)


#### Immersion Augmented Reality Page

![Gif 4](https://media3.giphy.com/media/V9QxQS3rIJlC1PmevA/giphy.gif)
[Screenshot](https://media3.giphy.com/media/V9QxQS3rIJlC1PmevA/giphy.gif)

Upon opening the page, the user will see a green box that generates focus on the screen. The user will tap on the screen when they have indicated the floor of their room based on the green box. Then the green box will disappear, and a 3D model of the selected room will appear in the location of the green box, enlarged. The user can immerse themselves in the room. 

Files: [Here](https://github.com/staceyyinlee/NYU-Augmented-Library-Front-End/blob/main/ARLibrary/ARViewComponents/ImmersionARFocusEntityView.swift)
