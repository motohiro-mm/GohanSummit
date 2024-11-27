import { Modal } from "tailwindcss-stimulus-components";

export default class extends Modal {
  connect() {
    super.connect();
    if (this.dialogTarget.id === "welcome-modal") {
      this.open();
    }
  }
}
