// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require rails-ujs
//= require active_admin/base
import "@hotwired/turbo-rails"
import "controllers"


document.addEventListener("turbo:load", () => {
    const dropdowns = document.querySelectorAll('.dropdown');

    dropdowns.forEach(dropdown => {
      const items = dropdown.querySelectorAll('.dropdown-item');

      items.forEach(item => {
        item.addEventListener('click', (e) => {
          e.preventDefault();
          console.log(item)

          fetch('/canadian_tax_rates.json')
          .then(response => response.json())
          .then(data => {
            const tax = data.find(p => p.dataId === Number(item.dataset.id));

            const subtotal = Number(document.querySelector('.product-subtotal').innerText)
            const totalTaxRate = tax["gst"] + tax["pst"] + tax["hst"]
            const total = subtotal * (1 + totalTaxRate)
            const roundedTotal = total.toFixed(2)

            let taxRateContainer = document.getElementById("tax-rates")
            taxRateContainer.innerHTML =
            `<p class="ml-5 is-size-6 has-text-weight-bold has-text-white">Taxes:</p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white" id="gst-rate">GST: <span class="is-size-6 has-text-weight-normal has-text-white">${tax["gst"]}%</span></p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white" id="pst-rate">PST: <span class="is-size-6 has-text-weight-normal has-text-white">${tax["pst"]}%</span></p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white" id="hst-rate">HST: <span class="is-size-6 has-text-weight-normal has-text-white">${tax["hst"]}%</span></p>
            <p class="ml-5 mt-5 is-size-4 has-text-weight-bold has-text-white" id="hst-rate">Total: <span class="is-size-4 has-text-weight-normal has-text-white">$${roundedTotal}</span></p>`
          }).catch(error => {
            console.error('Fetch error:', error);
          });

        });
      });
    });
});

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


