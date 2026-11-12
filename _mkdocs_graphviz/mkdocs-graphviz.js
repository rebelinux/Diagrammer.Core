(function() {
  "use strict";
  const ROOT_SELECTOR = ".mkdocs-graphviz";
  const VARIANT_SELECTOR = ".mkdocs-graphviz-variant";
  const DARK_QUERY = "(prefers-color-scheme: dark)";
  function closestScheme(root) {
    if (root?.closest) {
      const local = root.closest("[data-md-color-scheme]");
      if (local) return local.getAttribute("data-md-color-scheme");
    }
    const body = document.body?.getAttribute("data-md-color-scheme");
    if (body) return body;
    return document.documentElement?.getAttribute("data-md-color-scheme");
  }
  function isDark(root) {
    const forced = root?.getAttribute?.("data-mkdocs-graphviz-force-theme");
    if (forced === "dark") return true;
    if (forced === "light") return false;
    const scheme = closestScheme(root);
    if (scheme === "slate" || scheme === "dark") return true;
    if (scheme === "default" || scheme === "light") return false;
    const element = root instanceof Element ? root : document.documentElement;
    try {
      const colorScheme = getComputedStyle(element).colorScheme || "";
      if (/\bdark\b/i.test(colorScheme) && !/\blight\b/i.test(colorScheme)) return true;
      if (/\blight\b/i.test(colorScheme) && !/\bdark\b/i.test(colorScheme)) return false;
    } catch {
    }
    return Boolean(window.matchMedia?.(DARK_QUERY).matches);
  }
  function rootsWithin(root = document) {
    const result = [];
    if (root?.matches?.(ROOT_SELECTOR)) result.push(root);
    if (root?.querySelectorAll) result.push(...root.querySelectorAll(ROOT_SELECTOR));
    return result;
  }
  function refreshOne(root) {
    const dark = isDark(root);
    const variants = [...root.querySelectorAll(`:scope > ${VARIANT_SELECTOR}`)];
    if (!variants.length) return;
    for (const variant of variants) {
      const theme = variant.getAttribute("data-mkdocs-graphviz-theme") || "all";
      const visible = theme === "all" || theme === (dark ? "dark" : "light");
      variant.hidden = !visible;
      variant.setAttribute("aria-hidden", visible ? "false" : "true");
    }
    root.setAttribute("data-mkdocs-graphviz-active-theme", dark ? "dark" : "light");
  }
  function refresh(root = document) {
    for (const graph of rootsWithin(root)) refreshOne(graph);
  }
  function setTheme(root, theme = "auto") {
    for (const graph of rootsWithin(root || document)) {
      if (theme === "auto" || theme == null) graph.removeAttribute("data-mkdocs-graphviz-force-theme");
      else if (theme === "light" || theme === "dark") graph.setAttribute("data-mkdocs-graphviz-force-theme", theme);
      else throw new Error(`Unsupported mkdocs-graphviz theme: ${theme}`);
      refreshOne(graph);
    }
  }
  const api = window.MkDocsGraphviz || {};
  api.refresh = refresh;
  api.setTheme = setTheme;
  api.version = "2.0.2";
  window.MkDocsGraphviz = api;
  function registerRevealAdapter() {
    const reveal = window.MkDocsRevealJS;
    if (!reveal?.registerContentAdapter || api._revealAdapterRegistered) return;
    api._revealAdapterRegistered = reveal.registerContentAdapter("graphviz", {
      priority: 45,
      refresh(root) {
        refresh(root || document);
      }
    });
  }
  function install() {
    refresh(document);
    registerRevealAdapter();
    const schemeTarget = document.body || document.documentElement;
    if (schemeTarget) {
      new MutationObserver((mutations) => {
        if (mutations.some((mutation) => mutation.type === "attributes" && mutation.attributeName === "data-md-color-scheme")) {
          refresh(document);
        }
      }).observe(schemeTarget, { attributes: true, attributeFilter: ["data-md-color-scheme"] });
    }
    new MutationObserver((mutations) => {
      const roots = /* @__PURE__ */ new Set();
      for (const mutation of mutations) {
        for (const node of mutation.addedNodes) {
          if (node.nodeType === Node.ELEMENT_NODE) roots.add(node);
        }
      }
      for (const root of roots) refresh(root);
    }).observe(document.documentElement, { childList: true, subtree: true });
    const media = window.matchMedia?.(DARK_QUERY);
    media?.addEventListener?.("change", () => refresh(document));
    for (const name of [
      "mkdocs-revealjs-ready",
      "mkdocs-revealjs-content-ready",
      "mkdocs-revealjs-content-shown"
    ]) {
      document.addEventListener(name, (event) => {
        registerRevealAdapter();
        refresh(event.detail?.root || document);
      });
    }
    if (window.document$?.subscribe) {
      window.document$.subscribe(() => {
        refresh(document);
        registerRevealAdapter();
      });
    }
  }
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", install, { once: true });
  else install();
})();
