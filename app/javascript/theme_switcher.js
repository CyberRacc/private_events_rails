document.addEventListener('turbo:load', () => {
  const themeToggle = document.getElementById('theme-toggle');
  const sunIcon = themeToggle.nextElementSibling;
  const moonIcon = sunIcon.nextElementSibling;
  const currentTheme = localStorage.getItem('theme') || 'light';

  document.documentElement.setAttribute('data-theme', currentTheme);
  themeToggle.checked = currentTheme === 'dark';

  const updateIcons = () => {
    if (themeToggle.checked) {
      sunIcon.classList.add('opacity-0');
      sunIcon.classList.remove('opacity-100');
      moonIcon.classList.add('opacity-100');
      moonIcon.classList.remove('opacity-0');
    } else {
      sunIcon.classList.add('opacity-100');
      sunIcon.classList.remove('opacity-0');
      moonIcon.classList.add('opacity-0');
      moonIcon.classList.remove('opacity-100');
    }
  };

  updateIcons();

  themeToggle.addEventListener('change', () => {
    const newTheme = themeToggle.checked ? 'dark' : 'light';
    document.documentElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateIcons();
  });
});
