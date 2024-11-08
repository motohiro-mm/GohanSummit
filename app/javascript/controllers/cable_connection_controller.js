import { Controller } from "@hotwired/stimulus";
import { createConsumer } from "@rails/actioncable";

export default class extends Controller {
  static targets = ["status"];

  connect() {
    this.consumer = createConsumer();

    this.consumer.subscriptions.create("ConnectMeetingRoomChannel", {
      connected: () => {
        this.statusTarget.classList.remove("hidden");
      },
    });
  }

  disconnect() {
    if (this.consumer) {
      this.consumer.disconnect();
    }
  }
}
