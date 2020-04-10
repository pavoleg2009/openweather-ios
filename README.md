#  Weather App

## Assumption made and Trade-off
 
- The requirements do not mention the minimum version 
of the iOS, so 11.4 is selected;
- No iPad support, only portrait orientation;
- Most response fields considered mandatory;
- Weather icons set considered permanent, stored as resources in bundle;
- Swiftlint used  disabled in test classes;
- No localization support;
- Comments left to clarify intentions behind the code for faster review;
- Some formatting (for ex.: closing braces of func and return type on the next line) is just a personal experiment;
- Some prints and comments left as stubs;
- API credential stored in open form
- Some tests make real request to API, not ok got production

## Updates in v.1.1:
- New Grid layout added, both (old and new) arranged in UITabBarViewController
- There is some uncertainty in requirements: “we present information ... in a form of *a list*, where *each row* contains all forecasts for a certain day, *scrollable off the screen to the right*. - is it a List itself or each Row scrollable?. I've selected the first option. If the second option is the case and we need to make each roll scrollable - we can use UITableView as root container, each cell will contain a UIScrollView with a UIStackView in it. When we get response - we populate UIStackView with managed subviews.
- Because the comment was about layout, some logic just copy-pasted from old version.

##  Test Task Description

Description:

1.    Main:

GIVEN we have developer access to this particular OpenWeather API: https://openweathermap.org/forecast5
WHEN we call and get from this API weather information for upcoming 5 days in 3-hour intervals for the city of our choice
THEN we present information in the view about the temperature, time, date and weather icon in a form of a list, where each row contains all forecasts for a certain day, scrollable off the screen to the right

2.    Second part

GIVEN we have built the Weather App from above
AND we add a JSON file to the bundle with the same information as from the live API
AND we create a view with a top switch control (can be in the Navigation bar as well) 
THEN when we switch between data from the live API and fixed JSON file, we refresh the presented list below


Requirements:

-    It doesn’t have to be your best work ever, but we expect any intentional trade-offs, which might be done considering the time and other factors, to be explained in READ.ME or otherwise
-    No special UI designs are requested, you can use standard controls
-    There is no formal time limits, but we usually get projects back anywhere between week or two


Constraints for iOS:
o    No 3rd party frameworks
o    Swift only 
