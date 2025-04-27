// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//= require jquery
//= require rails-ujs
//= require active_admin/base
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:load", () => {

  document.getElementById("checkout-btn").addEventListener('click', () => {

    // Grabbing the financial order details
    const gst = parseFloat(document.getElementById("gst-rate").innerText)
    const pst = parseFloat(document.getElementById("pst-rate").innerText)
    const hst = parseFloat(document.getElementById("hst-rate").innerText)
    const subtotal = parseFloat(document.querySelector('.product-subtotal').innerText.replace('$', ''))
    const total = parseFloat(document.getElementById("products-total").innerText.replace('$', ''))

    // Grabbing the address info
    const street = document.getElementById("street").value
    const city = document.getElementById("city").value
    const postalCode = document.getElementById("postal_code").value
    const country = document.getElementById("country").value
    const provinceId = document.getElementById("selected-province-id").value

    // Grabbing the product_id(s)
    const productInputs = document.querySelectorAll('.product-id')
    const productIds = Array.from(productInputs).map(input => Number(input.value))

    fetch("/invoices", {
      method: "POST",
      headers:{
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        invoice:{
          product_ids: productIds,
          gst: gst,
          pst: pst,
          hst: hst,
          subtotal: subtotal,
          total: total,
          street: street,
          city: city,
          postal_code: postalCode,
          country: country,
          province_id: provinceId
        }
      })
    }).then(response => response.json())
    .then(data => {
      Turbo.visit(`/invoices/${data.id}`)
    })
    .catch(errorData => {
      console.error("Invoice creation failed:", errorData.errors);
      alert("Error: " + errorData.errors.join(", "));
    });
  });
});

// Displaying the tax rates and total after a province is selected
document.addEventListener("turbo:load", () => {
    const dropdowns = document.querySelectorAll('.dropdown');

    dropdowns.forEach(dropdown => {
      const items = dropdown.querySelectorAll('.dropdown-item');

      items.forEach(item => {
        item.addEventListener('click', (e) => {
          e.preventDefault();
          document.getElementById("checkout-btn").style.display = "block"

          // Injecting hidden province_id input everytime the province is clicked
          let selectedProvinceId = item.dataset.id;

          let hiddenInput = document.getElementById('selected-province-id');

          if(!hiddenInput){
            hiddenInput = document.createElement('input');
            hiddenInput.type = "hidden"
            hiddenInput.id = 'selected-province-id'
            hiddenInput.value = selectedProvinceId
            document.getElementById("checkoutColumn").appendChild(hiddenInput)
          }

          fetch('/canadian_tax_rates.json')
          .then(response => response.json())
          .then(data => {
            const tax = data.find(p => p.dataId === Number(item.dataset.id));

            const subtotal = Number(document.querySelector('.product-subtotal').innerText.replace('$', ''))
            const totalTaxRate = tax["gst"] + tax["pst"] + tax["hst"]
            const total = subtotal * (1 + totalTaxRate)
            const roundedTotal = total.toFixed(2)

            let taxRateContainer = document.getElementById("tax-rates")
            taxRateContainer.innerHTML =
            `<p class="ml-5 is-size-6 has-text-weight-bold has-text-white">Taxes:</p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white">GST: <span id="gst-rate" class="is-size-6 has-text-weight-normal has-text-white">${tax["gst"]}%</span></p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white">PST: <span id="pst-rate" class="is-size-6 has-text-weight-normal has-text-white">${tax["pst"]}%</span></p>
            <p class="ml-5 is-size-6 has-text-weight-bold has-text-white">HST: <span id="hst-rate" class="is-size-6 has-text-weight-normal has-text-white">${tax["hst"]}%</span></p>
            <p class="ml-5 mt-5 is-size-4 has-text-weight-bold has-text-white" >Total: <span id="products-total" class="is-size-4 has-text-weight-normal has-text-white">$${roundedTotal}</span></p>`
          }).catch(error => {
            console.error('Fetch error:', error);
          });

        });
      });
    });
});

// Bulma navbar burger functionality
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

// Bulma dropdown functionality
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


