import { Application } from "@hotwired/stimulus";
import { Alert } from "tailwindcss-stimulus-components";

const application = Application.start();
application.register("flash", Alert);
