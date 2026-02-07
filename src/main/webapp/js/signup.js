

$(document).ready(function(){
    console.log("SignUp form.....");

    // Attach the form submit event
	$('#reg-form').on('submit', function(event) {
	    event.preventDefault();  // Correctly preventing form's default behavior
        
        let form = new FormData(this);

        // Hide the submit button and show the loader
        $("#submit-btn").hide();
        $("#loader").show();

        // AJAX request to register servlet
		$.ajax({
		    url: "registerservlet",
		    type: 'post',
		    data: form,
		    success: function(data, textStatus, jqXHR) {
		        console.log(data);  // Log the server response for debugging

		        $("#submit-btn").show();  // Show the submit button
		        $("#loader").hide();      // Hide the loader

		        // Check if the response is 'done' for success
		        if (data.trim() === 'done') {
		            swal("Registered successfully! We are redirecting you to the login page...")
		                .then((value) => {
		                    window.location = "login.jsp";
		                });
		        } else {
		            // Show the error message returned from the server
		            swal(data);
		        }
		    },
		    error: function(jqXHR, textStatus, errorThrown) {
		        console.log(jqXHR);
		        
		        $("#submit-btn").show();
		        $("#loader").hide();
		        
		        swal("Error during registration.");
		    },
		    processData: false,
		    contentType: false
		});

    });
});

















/*document.addEventListener('DOMContentLoaded', function() {
    // Function to validate the signup form
    function validateForm() {
        const password = document.getElementById("new-password").value;
        const confirmPassword = document.getElementById("user_password").value;
        const email = document.getElementById("user_email").value;
        const mobile = document.getElementById("user_mobile").value;
        
        // Check if passwords match
        if (password !== confirmPassword) {
            document.getElementById("password-match").innerText = "Passwords do not match.";
            return false; // Prevent form submission
        } else {
            document.getElementById("password-match").innerText = "";
        }

        // Basic email format validation
        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailPattern.test(email)) {
            alert("Please enter a valid email address.");
            return false; // Prevent form submission
        }

        // Basic mobile number validation (10 digits)
        const mobilePattern = /^\d{10}$/;
        if (!mobilePattern.test(mobile)) {
            alert("Please enter a valid mobile number with 10 digits.");
            return false; // Prevent form submission
        }

        return true; // Allow form submission
    }

    // Function to toggle password visibility
    function togglePasswordVisibility(passwordId, icon) {
        const passwordField = document.getElementById(passwordId);
        if (passwordField.type === "password") {
            passwordField.type = "text";
            icon.classList.toggle("fa-eye-slash");
        } else {
            passwordField.type = "password";
            icon.classList.toggle("fa-eye");
        }
    }

    document.getElementById("toggle-password").onclick = function() {
        togglePasswordVisibility("new-password", this);
    };

    document.getElementById("toggle-confirm-password").onclick = function() {
        togglePasswordVisibility("user_password", this);
    };

    // Function to check password strength
    document.getElementById("new-password").addEventListener("input", function() {
        const password = this.value;
        const strengthIndicator = document.getElementById("password-strength");
        let strength = "Weak";

        if (password.length >= 8 && /[A-Z]/.test(password) && /[0-9]/.test(password)) {
            strength = "Strong";
        } else if (password.length >= 6) {
            strength = "Medium";
        }

        strengthIndicator.innerText = `Password strength: ${strength}`;
    });

    // Function to handle address detection
    document.getElementById("detect-address").onclick = function() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(showPosition, showError, { enableHighAccuracy: true });
        } else {
            alert("Geolocation is not supported by this browser.");
        }
    };

    function showPosition(position) {
        const lat = position.coords.latitude;
        const lon = position.coords.longitude;
        const geocoder = new google.maps.Geocoder();
        const latlng = new google.maps.LatLng(lat, lon);

        geocoder.geocode({ 'latLng': latlng }, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK && results[0]) {
                const address = results[0].formatted_address;
                const pincode = results[0].address_components.find(component => component.types.includes("postal_code")).long_name;
                document.getElementById("address").value = address;
                document.getElementById("latitude").value = lat;
                document.getElementById("longitude").value = lon;
                alert(`Location detected: ${address}, Pincode: ${pincode}, Latitude: ${lat}, Longitude: ${lon}`);
            } else {
                alert("No results found or Geocoder failed.");
            }
        });
    }

    function showError(error) {
        const errorMessages = {
            [error.PERMISSION_DENIED]: "User denied the request for Geolocation.",
            [error.POSITION_UNAVAILABLE]: "Location information is unavailable.",
            [error.TIMEOUT]: "The request to get user location timed out.",
            [error.UNKNOWN_ERROR]: "An unknown error occurred."
        };
        alert(errorMessages[error.code] || "An error occurred.");
    }

    // Attach form validation to the signup form submission
    const signupForm = document.getElementById('signup-form'); // Ensure this ID matches your form ID
    if (signupForm) {
        signupForm.addEventListener('submit', function(event) {
            if (!validateForm()) {
                event.preventDefault(); // Prevent form submission if validation fails
            }
        });
    }
});
*/


