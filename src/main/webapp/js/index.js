/*// Add event listeners for the navigation links
   const navLinks = document.querySelectorAll('.nav-link');

   navLinks.forEach(link => {
       link.addEventListener('click', function() {
           // Remove active class from all links
           navLinks.forEach(nav => nav.classList.remove('active'));
           // Add active class to the clicked link
           this.classList.add('active');
       });
   });

   // Maintain "Home" active state by default
   const homeLink = document.getElementById('homeLink');
   homeLink.classList.add('active');

   // Add event listeners for logo hover
   const logo = document.getElementById('logo');

   logo.addEventListener('mouseenter', function() {
       logo.style.transform = 'scale(1.5)'; // Enlarges logo on hover
       setTimeout(() => {
           logo.style.transform = 'scale(1)'; // Returns to original size after 4 seconds
       }, 4000); // Adjust the time as needed
   });*/