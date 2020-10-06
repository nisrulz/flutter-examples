# Covid-19 Mobile App

Mobile app to get information about covid-19 cases.
Link to the API used: https://documenter.getpostman.com/view/8854915/SzS7R6uu?version=latest

Before runnning the application, run the following command:
```
flutter pub get
```

You can then run the project with the following command:
```
flutter run
```

Just to ensure that the app works perfectly, add the following permission in ```AndroidManifest.xml``` file:

```
<uses-permission android:name="android.permission.INTERNET" />
```

By default the app shows Corona Virus cases in India on the home page. You can change the country name in variable ```url2``` to show the cases in other coountries or maybe get the location of the user and show accordingly.

The packages used in this project are as follows:

1. number_display - to display data in a width-limited component. For eg: it converts 2500000 to 2.5M

2. http - to send http requets to the API

3. bezier_chart - to visualize the received data from the API

4. folding_cell - to display a foldable cell to view details(total deaths, today cases, etc.). This foldable cell is present in 'Affected Countries' page

Images are present in the ```assets``` folder

## Demo(Mobile)

Following is a video of the demonstration of the app. Click on the image below to watch the video:<br><br>
[![IMAGE ALT TEXT](http://img.youtube.com/vi/xyaZVdXMBeA/0.jpg)](http://www.youtube.com/watch?v=xyaZVdXMBeA "Covid-19 App")
