import { Controller as e } from "@hotwired/stimulus";
var t = Object.defineProperty;
var V = (e, s, i) =>
  s in e
    ? t(e, s, { enumerable: !0, configurable: !0, writable: !0, value: i })
    : (e[s] = i);
var a = (e, t, s) => (V(e, typeof t != "symbol" ? t + "" : t, s), s);
async function r(e, t, s = {}) {
  t ? T(e, s) : b(e, s);
}
async function T(e, t = {}) {
  let s = e.dataset.transitionEnter || t.enter || "enter",
    i = e.dataset.transitionEnterFrom || t.enterFrom || "enter-from",
    o = e.dataset.transitionEnterTo || t.enterTo || "enter-to",
    n = e.dataset.toggleClass || t.toggleClass || "hidden";
  e.classList.add(...s.split(" ")),
    e.classList.add(...i.split(" ")),
    e.classList.remove(...o.split(" ")),
    e.classList.remove(...n.split(" ")),
    await v(),
    e.classList.remove(...i.split(" ")),
    e.classList.add(...o.split(" "));
  try {
    await x(e);
  } finally {
    e.classList.remove(...s.split(" "));
  }
}
async function b(e, t = {}) {
  let s = e.dataset.transitionLeave || t.leave || "leave",
    i = e.dataset.transitionLeaveFrom || t.leaveFrom || "leave-from",
    o = e.dataset.transitionLeaveTo || t.leaveTo || "leave-to",
    n = e.dataset.toggleClass || t.toggle || "hidden";
  e.classList.add(...s.split(" ")),
    e.classList.add(...i.split(" ")),
    e.classList.remove(...o.split(" ")),
    await v(),
    e.classList.remove(...i.split(" ")),
    e.classList.add(...o.split(" "));
  try {
    await x(e);
  } finally {
    e.classList.remove(...s.split(" ")), e.classList.add(...n.split(" "));
  }
}
function v() {
  return new Promise((e) => {
    requestAnimationFrame(() => {
      requestAnimationFrame(e);
    });
  });
}
function x(e) {
  return Promise.all(e.getAnimations().map((e) => e.finished));
}
var s = class extends e {
  connect() {
    setTimeout(() => {
      T(this.element);
    }, this.showDelayValue),
      this.hasDismissAfterValue &&
        setTimeout(() => {
          this.close();
        }, this.dismissAfterValue);
  }
  close() {
    b(this.element).then(() => {
      this.element.remove();
    });
  }
};
a(s, "values", {
  dismissAfter: Number,
  showDelay: { type: Number, default: 0 },
});
var i = class extends e {
  connect() {
    this.timeout = null;
  }
  save() {
    clearTimeout(this.timeout),
      (this.timeout = setTimeout(() => {
        (this.statusTarget.textContent = this.submittingTextValue),
          this.formTarget.requestSubmit();
      }, this.submitDurationValue));
  }
  success() {
    this.setStatus(this.successTextValue);
  }
  error() {
    this.setStatus(this.errorTextValue);
  }
  setStatus(e) {
    (this.statusTarget.textContent = e),
      (this.timeout = setTimeout(() => {
        this.statusTarget.textContent = "";
      }, this.statusDurationValue));
  }
};
a(i, "targets", ["form", "status"]),
  a(i, "values", {
    submitDuration: { type: Number, default: 1e3 },
    statusDuration: { type: Number, default: 2e3 },
    submittingText: { type: String, default: "Saving..." },
    successText: { type: String, default: "Saved!" },
    errorText: { type: String, default: "Unable to save." },
  });
var o = class extends e {
  update() {
    this.preview = this.colorTarget.value;
  }
  set preview(e) {
    this.previewTarget.style[this.styleValue] = e;
    let t = this._getContrastYIQ(e);
    this.styleValue === "color"
      ? (this.previewTarget.style.backgroundColor = t)
      : (this.previewTarget.style.color = t);
  }
  _getContrastYIQ(e) {
    e = e.replace("#", "");
    let t = 128,
      s = parseInt(e.substr(0, 2), 16),
      i = parseInt(e.substr(2, 2), 16),
      o = parseInt(e.substr(4, 2), 16);
    return (s * 299 + i * 587 + o * 114) / 1e3 >= t ? "#000" : "#fff";
  }
};
a(o, "targets", ["preview", "color"]),
  a(o, "values", { style: { type: String, default: "backgroundColor" } });
var n = class extends e {
  connect() {
    (this.boundBeforeCache = this.beforeCache.bind(this)),
      document.addEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  disconnect() {
    document.removeEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  openValueChanged() {
    r(this.menuTarget, this.openValue, this.transitionOptions),
      this.openValue === !0 &&
        this.hasMenuItemTarget &&
        this.menuItemTargets[0].focus();
  }
  show() {
    this.openValue = !0;
  }
  close() {
    this.openValue = !1;
  }
  hide(e) {
    this.closeOnClickOutsideValue &&
      e.target.nodeType &&
      this.element.contains(e.target) === !1 &&
      this.openValue &&
      (this.openValue = !1),
      this.closeOnEscapeValue &&
        e.key === "Escape" &&
        this.openValue &&
        (this.openValue = !1);
  }
  toggle() {
    this.openValue = !this.openValue;
  }
  nextItem(e) {
    e.preventDefault(), this.menuItemTargets[this.nextIndex].focus();
  }
  previousItem(e) {
    e.preventDefault(), this.menuItemTargets[this.previousIndex].focus();
  }
  get currentItemIndex() {
    return this.menuItemTargets.indexOf(document.activeElement);
  }
  get nextIndex() {
    return Math.min(this.currentItemIndex + 1, this.menuItemTargets.length - 1);
  }
  get previousIndex() {
    return Math.max(this.currentItemIndex - 1, 0);
  }
  get transitionOptions() {
    return {
      enter: this.hasEnterClass
        ? this.enterClass
        : "transition ease-out duration-100",
      enterFrom: this.hasEnterFromClass
        ? this.enterFromClass
        : "transform opacity-0 scale-95",
      enterTo: this.hasEnterToClass
        ? this.enterToClass
        : "transform opacity-100 scale-100",
      leave: this.hasLeaveClass
        ? this.leaveClass
        : "transition ease-in duration-75",
      leaveFrom: this.hasLeaveFromClass
        ? this.leaveFromClass
        : "transform opacity-100 scale-100",
      leaveTo: this.hasLeaveToClass
        ? this.leaveToClass
        : "transform opacity-0 scale-95",
      toggleClass: this.hasToggleClass ? this.toggleClass : "hidden",
    };
  }
  beforeCache() {
    (this.openValue = !1), this.menuTarget.classList.add("hidden");
  }
};
a(n, "targets", ["menu", "button", "menuItem"]),
  a(n, "values", {
    open: { type: Boolean, default: !1 },
    closeOnEscape: { type: Boolean, default: !0 },
    closeOnClickOutside: { type: Boolean, default: !0 },
  }),
  a(n, "classes", [
    "enter",
    "enterFrom",
    "enterTo",
    "leave",
    "leaveFrom",
    "leaveTo",
    "toggle",
  ]);
var l = class extends e {
  connect() {
    this.openValue && this.open(),
      (this.boundBeforeCache = this.beforeCache.bind(this)),
      document.addEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  disconnect() {
    document.removeEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  open() {
    this.dialogTarget.showModal();
  }
  close() {
    this.dialogTarget.setAttribute("closing", ""),
      Promise.all(
        this.dialogTarget.getAnimations().map((e) => e.finished),
      ).then(() => {
        this.dialogTarget.removeAttribute("closing"), this.dialogTarget.close();
      });
  }
  backdropClose(e) {
    e.target.nodeName == "DIALOG" && this.close();
  }
  show() {
    this.dialogTarget.show();
  }
  hide() {
    this.close();
  }
  beforeCache() {
    this.close();
  }
};
a(l, "targets", ["dialog"]), a(l, "values", { open: Boolean });
var h = class extends e {
  openValueChanged() {
    r(this.contentTarget, this.openValue),
      this.shouldAutoDismiss && this.scheduleDismissal();
  }
  show(e) {
    this.shouldAutoDismiss && this.scheduleDismissal(), (this.openValue = !0);
  }
  hide() {
    this.openValue = !1;
  }
  toggle() {
    this.openValue = !this.openValue;
  }
  get shouldAutoDismiss() {
    return this.openValue && this.hasDismissAfterValue;
  }
  scheduleDismissal() {
    this.hasDismissAfterValue &&
      (this.cancelDismissal(),
      (this.timeoutId = setTimeout(() => {
        this.hide(), (this.timeoutId = void 0);
      }, this.dismissAfterValue)));
  }
  cancelDismissal() {
    typeof this.timeoutId == "number" &&
      (clearTimeout(this.timeoutId), (this.timeoutId = void 0));
  }
};
a(h, "targets", ["content"]),
  a(h, "values", {
    dismissAfter: Number,
    open: { type: Boolean, default: !1 },
  });
var u = class extends e {
  connect() {
    this.openValue && this.open(),
      (this.boundBeforeCache = this.beforeCache),
      document.addEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  disconnect() {
    document.removeEventListener("turbo:before-cache", this.boundBeforeCache);
  }
  open() {
    this.dialogTarget.showModal();
  }
  close() {
    this.dialogTarget.setAttribute("closing", ""),
      Promise.all(
        this.dialogTarget.getAnimations().map((e) => e.finished),
      ).then(() => {
        this.dialogTarget.removeAttribute("closing"), this.dialogTarget.close();
      });
  }
  backdropClose(e) {
    e.target.nodeName == "DIALOG" && this.close();
  }
  show() {
    this.open();
  }
  hide() {
    this.close();
  }
  beforeCache() {
    this.close();
  }
};
a(u, "targets", ["dialog"]), a(u, "values", { open: Boolean });
var c = class extends e {
  initialize() {
    this.updateAnchorValue &&
      this.anchor &&
      (this.indexValue = this.tabTargets.findIndex(
        (e) => e.id === this.anchor,
      ));
  }
  connect() {
    this.showTab();
  }
  change(e) {
    e.currentTarget.tagName === "SELECT"
      ? (this.indexValue = e.currentTarget.selectedIndex)
      : e.currentTarget.dataset.index
        ? (this.indexValue = e.currentTarget.dataset.index)
        : e.currentTarget.dataset.id
          ? (this.indexValue = this.tabTargets.findIndex(
              (t) => t.id == e.currentTarget.dataset.id,
            ))
          : (this.indexValue = this.tabTargets.indexOf(e.currentTarget));
  }
  nextTab() {
    this.indexValue = Math.min(this.indexValue + 1, this.tabsCount - 1);
  }
  previousTab() {
    this.indexValue = Math.max(this.indexValue - 1, 0);
  }
  firstTab() {
    this.indexValue = 0;
  }
  lastTab() {
    this.indexValue = this.tabsCount - 1;
  }
  indexValueChanged() {
    if (
      (this.showTab(),
      this.dispatch("tab-change", {
        target: this.tabTargets[this.indexValue],
        detail: { activeIndex: this.indexValue },
      }),
      this.updateAnchorValue)
    ) {
      let e = this.tabTargets[this.indexValue].id;
      if (this.scrollToAnchorValue) location.hash = e;
      else {
        let t = window.location.href.split("#")[0] + "#" + e;
        typeof Turbo < "u"
          ? Turbo.navigator.history.replace(new URL(t))
          : history.replaceState({}, document.title, t);
      }
    }
  }
  showTab() {
    this.panelTargets.forEach((e, t) => {
      let s = this.tabTargets[t];
      t === this.indexValue
        ? (e.classList.remove("hidden"),
          (s.ariaSelected = "true"),
          (s.dataset.active = !0),
          this.hasInactiveTabClass &&
            s?.classList?.remove(...this.inactiveTabClasses),
          this.hasActiveTabClass && s?.classList?.add(...this.activeTabClasses))
        : (e.classList.add("hidden"),
          (s.ariaSelected = null),
          delete s.dataset.active,
          this.hasActiveTabClass &&
            s?.classList?.remove(...this.activeTabClasses),
          this.hasInactiveTabClass &&
            s?.classList?.add(...this.inactiveTabClasses));
    }),
      this.hasSelectTarget &&
        (this.selectTarget.selectedIndex = this.indexValue),
      this.scrollActiveTabIntoViewValue && this.scrollToActiveTab();
  }
  scrollToActiveTab() {
    let e = this.element.querySelector("[aria-selected]");
    e && e.scrollIntoView({ inline: "center" });
  }
  get tabsCount() {
    return this.tabTargets.length;
  }
  get anchor() {
    return document.URL.split("#").length > 1
      ? document.URL.split("#")[1]
      : null;
  }
};
a(c, "classes", ["activeTab", "inactiveTab"]),
  a(c, "targets", ["tab", "panel", "select"]),
  a(c, "values", {
    index: 0,
    updateAnchor: Boolean,
    scrollToAnchor: Boolean,
    scrollActiveTabIntoView: Boolean,
  });
var d = class extends e {
  toggle(e) {
    (this.openValue = !this.openValue), this.animate();
  }
  toggleInput(e) {
    (this.openValue = e.target.checked), this.animate();
  }
  hide() {
    (this.openValue = !1), this.animate();
  }
  show() {
    (this.openValue = !0), this.animate();
  }
  animate() {
    this.toggleableTargets.forEach((e) => {
      r(e, this.openValue);
    });
  }
};
a(d, "targets", ["toggleable"]),
  a(d, "values", { open: { type: Boolean, default: !1 } });
export {
  s as Alert,
  i as Autosave,
  o as ColorPreview,
  n as Dropdown,
  l as Modal,
  h as Popover,
  u as Slideover,
  c as Tabs,
  d as Toggle,
  r as transition,
};
