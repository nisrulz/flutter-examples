# Google Analytics


### Steps for Analytics Integration :-

#### 1) Setup your Flutter app in Firebase console.


#### 2) Import Plugins in pubspec.yaml

   a) [firebase_analytics](https://pub.dev/packages/firebase_analytics)
   
   b) [firebase_core](https://pub.dev/packages/firebase_core)
   
   
#### 3) Initialize FirebaseApp in main function
         
         void main() async {
         await Firebase.initializeApp();
         runApp(FlutterAnalyticsApp());
         }
               
#### 4) Initialize FirebaseAnalytics and FirebaseAnalyticsObserver
        
        FirebaseAnalytics analytics = FirebaseAnalytics();
        FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

#### 5) Setup observer to record navigation changes in app
      
       MaterialApp(
   	   -------------
         navigatorObservers: <NavigatorObserver>[observer],
         -------------
       );

#### 6) Log Events (e.g.)
         
         await analytics.logEvent(
         name: 'item',
             parameters: <String, dynamic>{
               'price': price,
               'itemName': itemName,
               'quantity': quantity,
               'bool': addedToCart,
             },
         );

#### 7) [Important] Enable debug mode to see events immediately
         
        As Events in Google/Firebase analytics takes around 24 hrs to reflect, so in order to test while developing make sure that you 
        run a debug build. Below is the link how you can do so.
        
   [Enable debug mode](https://support.google.com/firebase/answer/7201382?hl=en&utm_id=ad)     
   
   

### Screenshots

<img src="/images/1.png" height="600em" />.    <img src="/images/2.png" height="600em" /> 
<img src="/images/3.png" height="600em" /> 







