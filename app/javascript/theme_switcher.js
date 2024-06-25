document.addEventListener("turbo:load", function () {
  const themeToggleBtn = document.getElementById("theme-toggle");
  const sunIcon = document.getElementById("sun-icon");
  const moonIcon = document.getElementById("moon-icon");

  // Load theme from local storage
  const currentTheme = localStorage.getItem("theme") || "light";
  document.documentElement.setAttribute("data-theme", currentTheme);

  // Update the toggle and icons
  if (currentTheme === "dark") {
    themeToggleBtn.checked = true;
    sunIcon.classList.remove("hidden");
    moonIcon.classList.add("hidden");
  } else {
    themeToggleBtn.checked = false;
    sunIcon.classList.add("hidden");
    moonIcon.classList.remove("hidden");
  }

  // Toggle theme on switch change
  themeToggleBtn.addEventListener("change", () => {
    let theme = document.documentElement.getAttribute("data-theme");
    if (theme === "dark") {
      theme = "light";
      sunIcon.classList.add("hidden");
      moonIcon.classList.remove("hidden");
    } else {
      theme = "dark";
      sunIcon.classList.remove("hidden");
      moonIcon.classList.add("hidden");
    }
    document.documentElement.setAttribute("data-theme", theme);
    localStorage.setItem("theme", theme);
  });
});
