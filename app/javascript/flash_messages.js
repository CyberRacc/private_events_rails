// app/javascript/flash_messages.js
document.addEventListener('DOMContentLoaded', () => {
    const flashMessages = document.querySelectorAll('#flash-message');
    flashMessages.forEach(flashMessage => {
      flashMessage.classList.add('fade-in');
  
      setTimeout(() => {
        flashMessage.classList.remove('fade-in');
        flashMessage.classList.add('fade-out');
  
        flashMessage.addEventListener('transitionend', () => {
          flashMessage.remove();
        });
      }, 5000); // 5 seconds delay before fade out
    });
  });
  