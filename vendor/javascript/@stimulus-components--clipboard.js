// @stimulus-components/clipboard@5.0.0 downloaded from https://ga.jspm.io/npm:@stimulus-components/clipboard@5.0.0/dist/stimulus-clipboard.mjs

import { Controller as t } from "@hotwired/stimulus";
const e = class _Clipboard extends t {
  connect() {
    this.hasButtonTarget &&
      (this.originalContent = this.buttonTarget.innerHTML);
  }
  copy(t) {
    t.preventDefault();
    const e = this.sourceTarget.innerHTML || this.sourceTarget.value;
    navigator.clipboard.writeText(e).then(() => this.copied());
  }
  copied() {
    this.hasButtonTarget &&
      (this.timeout && clearTimeout(this.timeout),
      (this.buttonTarget.innerHTML = this.successContentValue),
      (this.timeout = setTimeout(() => {
        this.buttonTarget.innerHTML = this.originalContent;
      }, this.successDurationValue)));
  }
};
(e.targets = ["button", "source"]),
  (e.values = {
    successContent: String,
    successDuration: { type: Number, default: 2e3 },
  });
let s = e;
export { s as default };
