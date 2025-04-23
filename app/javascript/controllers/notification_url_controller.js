import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    navigator.serviceWorker.addEventListener(
      "message",
      this.handleMessage.bind(this),
    );
  }

  handleMessage(event) {
    if (event.data && event.data.type === "store-notification-url") {
      localStorage.setItem("notification_redirect_url", event.data.url);
    }
  }
}
