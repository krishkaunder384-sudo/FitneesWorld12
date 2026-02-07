<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us - FitnessWorld</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <style>
        /* Background with subtle gradient */
        body {
            background: linear-gradient(135deg, #f0f4f8, #d9e2ec);
            font-family: Arial, sans-serif;
            color: #333;
        }

        .contact-container {
            margin-top: 50px;
            text-align: center;
            background-color: #ffffff;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        h1 {
            color: #2b5876;
        }

        .form-label {
            color: #666;
            font-weight: 500;
        }

        .form-control {
            border-radius: 8px;
            box-shadow: none;
            border: 1px solid #ccc;
        }

        .form-control:focus {
            border-color: #4b6584;
            box-shadow: 0 0 5px rgba(75, 101, 132, 0.5);
        }

        .submit-button {
            margin-top: 20px;
        }

        /* Button styling */
        .btn-secondary {
            background-color: #4b6584;
            border-color: #4b6584;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #3b4d63;
            border-color: #3b4d63;
        }
    </style>
</head>
<body>
    <div class="container contact-container animate__animated animate__fadeIn">
        <h1 class="display-4 text-primary mb-4">Contact Us</h1>
        <p class="lead text-muted">We'd love to hear from you! Please fill out the form below and we'll get back to you soon.</p>

        <!-- Contact Form -->
        <form id="contactForm" action="submitContactForm.jsp" method="post" class="text-left">
            <div class="form-group">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name" required>
            </div>
            <div class="form-group">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
            </div>
            <div class="form-group">
                <label for="message" class="form-label">Message</label>
                <textarea class="form-control" id="message" name="message" rows="5" placeholder="Enter your message" required></textarea>
            </div>
            <div class="submit-button text-center">
                <button type="submit" class="btn btn-secondary btn-lg">Submit</button>
            </div>
        </form>

        <!-- Back Button -->
        <div class="back-button mt-4">
            <a href="index.jsp" class="btn btn-secondary btn-lg">Back to Home</a>
        </div>
    </div>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
    <script>
        // Capture form submission and trigger SweetAlert
        document.getElementById("contactForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent actual form submission

            // Show SweetAlert confirmation
            Swal.fire({
                title: 'Thank you for contacting us!',
                text: 'A backend team member will reach out within 24 hours. Stay fit and keep gymming!',
                icon: 'success',
                confirmButtonText: 'Close'
            }).then((result) => {
                if (result.isConfirmed) {
                    // If the user clicks "Close", submit the form
                    document.getElementById("contactForm").submit();
                }
            });
        });
    </script>
</body>
</html>
