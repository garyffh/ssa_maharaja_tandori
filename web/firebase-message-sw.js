importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyDphVQ81cabHNw4K4z6k80j3-34euDO8yo",
    authDomain: "ffh-store-hub-cafe.firebaseapp.com",
    projectId: "ffh-store-hub-cafe",
    storageBucket: "ffh-store-hub-cafe.appspot.com",
    messagingSenderId: "445101478495",
    appId: "1:445101478495:web:7a19488f9038759761c1ea",
    measurementId: "G-0ZDNZSJ98P"
});
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
            };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
