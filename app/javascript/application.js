// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require rails-ujs
//= require active_admin/base
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {
  const navbarBurger = document.querySelector(".navbar-burger");
  const navbarMenu = document.querySelector(".navbar-menu");

  if (navbarBurger && navbarMenu) {
    navbarBurger.addEventListener("click", () => {
      navbarBurger.classList.toggle("is-active");
      navbarMenu.classList.toggle("is-active");
    });
  }
});

document.addEventListener("turbo:load", () => {
  const dropdowns = document.querySelectorAll('.dropdown');

  dropdowns.forEach(dropdown => {
    const trigger = dropdown.querySelector('.dropdown-trigger button');
    const items = dropdown.querySelectorAll('.dropdown-item');

    // Toggle dropdown visibility
    trigger?.addEventListener('click', (e) => {
      e.preventDefault();
      dropdown.classList.toggle('is-active');
    });

    // Handle item click
    items.forEach(item => {
      item.addEventListener('click', (e) => {
        e.preventDefault();
        const name = item.textContent.trim();

        const displaySpan = trigger.querySelector("span");
        if (displaySpan) displaySpan.textContent = name;

        dropdown.classList.remove("is-active");
      });
    });

    // Close if clicked outside
    document.addEventListener("click", (e) => {
      if (!dropdown.contains(e.target)) {
        dropdown.classList.remove("is-active");
      }
    });
  });
});

