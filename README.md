# movies_app_task
[Firebase project link](https://console.firebase.google.com/project/movie-app-task-971f5/overview)

# Deep Links:
```
movieapptask://open
movieapptask://details_screen/505642
movieapptask://details_screen/503742
movieapptask://details_screen/318942
movieapptask://details_screen/42
```
```
notes:
first deep link: opens the app in the main screen.
second deep link: opens the app in the movie details screen.
third deep link: opens the app in the movie details screen.
forth deep link: opens the app in the movie details screen with a movie with no image.
fifth deep link: opens the app in the movie details screen with a bad movie id.
```

note: to test these deepLinks you can use adb commands

adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "movieapptask://open"'

adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "movieapptask://details_screen/505642"'

adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "movieapptask://details_screen/503742"'

adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "movieapptask://details_screen/318942"'

adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "movieapptask://details_screen/42"'

##
This is app is build using clean architecture pattern
