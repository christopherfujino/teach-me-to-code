/// Vim keybindings
(function () {
  let inMultiKeyMotion = false;
  let multiKeyMotion = null;
  // See :help timeoutlen
  const timeoutlen = 750;

  window.addEventListener("keydown", function (event) {
    console.log("you pressed", event);
    const dy = 50;
    switch (event.key) {
      case "j":
        window.scrollBy({top: dy, behavior: "instant"});
        break;
      case "k":
        window.scrollBy({top: -dy, behavior: "instant"});
        break;
      case "g":
        if (inMultiKeyMotion) {
          inMultiKeyMotion = false;
          window.scrollBy({top: -999999999, behavior: "instant"});
          console.log("scrolled to top");
        } else {
          inMultiKeyMotion = true;
          multiKeyMotion = [event.key];
          setTimeout(() => inMultiKeyMotion = false, timeoutlen);
          console.log("setting ing = true");
        }
        break;
      case "G":
        window.scrollBy({top: 999999999, behavior: "instant"});
        break;
    }
  });
})();
