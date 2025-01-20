const installHandler = async (event) => {
  console.info(event);
};

const pushHandler = async (event) => {
  const notificationData = event.data.json();
  const notificationPromise = self.registration.showNotification(
    notificationData.title,
    {
      body: notificationData.body,
      icon: notificationData.icon,
      data: notificationData.data,
    },
  );
  event.waitUntil(notificationPromise);
};

const notificationClickHandler = async (event) => {
  event.notification.close();
  const notificationData = event.notification.data;
  if (notificationData.url !== undefined) {
    event.waitUntil(self.clients.openWindow(notificationData.url));
  }
};

self.addEventListener("install", installHandler);
self.addEventListener("push", pushHandler);
self.addEventListener("notificationclick", notificationClickHandler);
