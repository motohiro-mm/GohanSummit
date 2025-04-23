import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const checkNotificationUrl = document.querySelector(
      'meta[name="check-notification-url"]',
    );
    if (checkNotificationUrl && checkNotificationUrl.content === "true") {
      this.checkForNotificationUrl();
    }
  }

  checkForNotificationUrl() {
    const notificationUrl = localStorage.getItem("notification_redirect_url");
    if (notificationUrl) {
      localStorage.removeItem("notification_redirect_url");

      window.location.href = notificationUrl;
    }
  }
}
