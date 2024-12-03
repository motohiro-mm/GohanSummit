// stimulus-textarea-autogrow@4.1.0 downloaded from https://ga.jspm.io/npm:stimulus-textarea-autogrow@4.1.0/dist/stimulus-textarea-autogrow.mjs

import { Controller as e } from "@hotwired/stimulus";
function r(e, t) {
  let i;
  return (...s) => {
    const o = this;
    clearTimeout(i), (i = setTimeout(() => e.apply(o, s), t));
  };
}
class l extends e {
  initialize() {
    this.autogrow = this.autogrow.bind(this);
  }
  connect() {
    this.element.style.overflow = "hidden";
    const e = this.resizeDebounceDelayValue;
    (this.onResize = e > 0 ? r(this.autogrow, e) : this.autogrow),
      this.autogrow(),
      this.element.addEventListener("input", this.autogrow),
      window.addEventListener("resize", this.onResize);
  }
  disconnect() {
    window.removeEventListener("resize", this.onResize);
  }
  autogrow() {
    (this.element.style.height = "auto"),
      (this.element.style.height = `${this.element.scrollHeight}px`);
  }
}
l.values = { resizeDebounceDelay: { type: Number, default: 100 } };
export { l as default };
