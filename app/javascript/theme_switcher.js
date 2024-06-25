document.addEventListener("DOMContentLoaded", function () {
    const themeToggleBtn = document.getElementById("theme-toggle");
  
    // Load theme from local storage
    const currentTheme = localStorage.getItem("theme") || "light";
    document.documentElement.setAttribute("data-theme", currentTheme);
  
    // Update the button text
    if (currentTheme === "dark") {
      themeToggleBtn.innerHTML = "🌞";
    } else {
      themeToggleBtn.innerHTML = "🌜";
    }
  
    // Toggle theme on button click
    themeToggleBtn.addEventListener("click", () => {
      let theme = document.documentElement.getAttribute("data-theme");
      if (theme === "dark") {
        theme = "light";
        themeToggleBtn.innerHTML = "🌜";
      } else {
        theme = "dark";
        themeToggleBtn.innerHTML = "🌞";
      }
      document.documentElement.setAttribute("data-theme", theme);
      localStorage.setItem("theme", theme);
    });
  });
  