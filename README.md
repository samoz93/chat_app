# Temporary Chat
### A Chat application based on timed messages, similar to snapchat, every thing get deleted after 24 hours

The application uses NestJs as a platform utilizing SocketIo and GraphQl to handle all the communication 
The message main DB is Redis , so it's blazingly fast 

For the frontend it is implemented with Flutter 

All that wrapped in Kubernete cluster that utilize nginx controller to handle the routing 

To run the application you have to install [tilt](https://tilt.dev/) and run 
```
tilt up
```

and for flutter app, cd into `app` and run 

```
flutter run
```


