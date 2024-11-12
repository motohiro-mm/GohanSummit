import { Application } from "@hotwired/stimulus";
import { Dropdown } from "tailwindcss-stimulus-components";

const application = Application.start();
application.register("dropdown", Dropdown);
export default class extends Dropdown {}
