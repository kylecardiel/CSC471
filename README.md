# CSC471
Trip Planning App

API Features

Navigation/Table View Controller API
The app opens up to a Navigation/Table View Controller API.  Here the Navigation Controller is used to navigate back to the previous screen.  Where it organizes the hierarchy level of screens displayed (on a stack) to navigate through.  The data (trips) are stored in an array and displayed using a Table View Controller.  This allows individual trips to be stored in a table format where users have access to create, delete or view a trip based on this API.  The Table View Controller is a useful tool in organizing data in a user friendly way.

MapKit/CoreLocation API
In the detail screen for each trip the Map Kit and Core Location APIs were used.  Here the Map Kit allows a Map View to displays a map on the bottom section of the screen.  Using the MKUserLocation, the map at the bottom of the screen displays a blue dot representing the users current location.  

Combining with the Core Location API, I was able to build a route (based on driving) from the users current location to the trip destination.  To implement this I had to use the GeoCoder to translate a string address (“Tampa, FL”) into longitude and latitude coordinates in the form of a Core Location coordinate (CLCoordinateLocation2D).  Once converted the coordinates where used to make map items (Map Kit MKMapItem) which make up the locations of a map request (MKDirectionRequest).  From the request a response is made, which is then used to overlay the route in the map.

Core Graphics/Animation/Quartz Drawing API
In the Budget detail screen these were all used.  Core Graphics and Animation was used to move a UILabel that was filled with a pattern of dollar images to a new location on the screen with a decreased size.  The UILabel was moved by changing the coordinate location of the label (based on the percentage of expenses to budget) and the label size.  To do this I used a combination of UIView.animateWithDuration to execute the move and using CGRect to set the new coordinates and size.  

Quartz drawing is only use briefly in the app.  On the Budget Detail screen when the “Budget Test” and the UILable is relocated on the screen.  There is a large single image dollar at the top of the screen.  This is created using drawRect when the screen is loaded and is made up of a single dollar image. 

Other Features Used
I used several text fields in the new trip screen for users to enter trip information.  Additionally, there were two types of keyboards used, each having a method for dismissing them.  I used a date picker to allow users to pick a trip start date.  Since I had limited screen real estate, instead of using another date picker for the end date, I used a stepper to the length of the trip in day (units).  Behind the scenes then I had to build code to determine the end trip date for display on the trip detail screen.  Additionally, on the new trip screen a little error checking was done before creating a new trip.  If a text field was empty then and an alert message popped up allowing the user to edit information before continuing.  A confirmation alert message was also displayed after the trip was completed.  Lastly, on the trip detail screen a slider was used to record expenses amounts. 
