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

2. http - to send http requests to the API

3. bezier_chart - to visualize the received data from the API

4. folding_cell - to display a foldable cell to view details(total deaths, today cases, etc.). This foldable cell is present in 'Affected Countries' page


Images are present in the ```assets``` folder


Files present in this project along with their purposes are given below:

```resources/fetch_data_functions.dart``` - contains functions to fetch data from the api(NovelCOVID API).

```screens/home.dart``` - shows Covid-19 cases of the whole world(all coutries together) and includes visualization of the cases in India(you can change the country by changing the url).

```screens/countrylist.dart``` - shows Covid-19 cases, country wise, in the form of a list. Each cell in the list is foldable. Upon expanding the cell, more info is shown.


```screens/searchCountry.dart``` - similar to ```screens/countrylist.dart``` but here user can also search.

```widgets/drawer.dart``` - contains the side drawer code

```widgets/foldable_cell_widgets.dart``` - contains reusable front, inner top and inner bottom widgets of the foldable cell that are used in ```screens/countrylist.dart``` and ```screens/searchCountry.dart```.

```widgets/graph.dart``` - contains the code for building the graph.

```widgets/info_card.dart``` - contains the code for displaying rounded retangular cards on the home page.

## Screenshots

<p align="center">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628928-a25b4b00-0a9c-11eb-8471-6209841e96dd.png">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628941-a6876880-0a9c-11eb-8a09-ccfd5663b644.png">
</p>

<p align="center">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628944-a71fff00-0a9c-11eb-9ab8-94277a2a93a4.png">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628948-a8512c00-0a9c-11eb-83f9-7bbc92334949.png">
</p>

<p align="center">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628951-a8e9c280-0a9c-11eb-930f-e51aec142cdd.png">
  <img width="200" height="400" src="https://user-images.githubusercontent.com/26627849/95628954-a8e9c280-0a9c-11eb-8b57-e50b83c68e24.png">
</p>
