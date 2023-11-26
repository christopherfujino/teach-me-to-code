async function walkTree(root, visit) {
  await visit(root);
  for (const node of root.childNodes) {
    await walkTree(node, visit);
  }
}

addEventListener("DOMContentLoaded", function () {
  const globalContainer = document.querySelector("#global-container");

  walkTree(globalContainer, function (el) {
    const style = el.style;
    if (!!style) {
      style.visibility = "hidden";
    }
  });

  walkTree(globalContainer, function (el) {
    const style = el.style;
    if (!!style) {
      style.visibility = "visible";
    }
    return new Promise((resolve) => setTimeout(resolve, 1));
  });

  /// Vim keybindings
  (function () {
    const termInputSpan = document.querySelector("#terminal-input");
    let buffer = [];
    window.addEventListener("keydown", function (event) {
      if (event.key.length === 1 && ((event.key >= "a" && event.key <= "z") || (event.key >= "A" && event.key <= "Z"))) {
        buffer.push(event.key);
        termInputSpan.innerText = buffer.join("");
      } else if (event.key === "Backspace") {
        if (buffer.length > 0) {
          buffer.pop();
          termInputSpan.innerText = buffer.join("");
        }
      } else {
        console.error("don't know what a ", event.key, " is");
      }
    });
  })();
});
