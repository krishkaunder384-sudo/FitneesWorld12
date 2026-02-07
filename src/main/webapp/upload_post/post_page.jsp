<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[Gym Name] - Your Fitness Destination</title>
    <style>
        /* Basic Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Body Styling */
        body {
            font-family: 'Poppins', sans-serif;
            line-height: 1.6;
            background: linear-gradient(135deg, #f4f4f4, #e8e8e8);
            color: #333;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        /* Header */
        header {
            background-image: url('https://via.placeholder.com/1200x400'); /* Replace with your gym image */
            background-size: cover;
            background-position: center;
            color: white;
            text-align: center;
            padding: 5rem 2rem;
            position: relative;
            overflow: hidden;
        }

        header h1 {
            font-size: 3rem;
            animation: fadeInDown 1s ease-in-out;
        }

        header p {
            font-size: 1.5rem;
            margin-top: 1rem;
            animation: fadeInUp 1s ease-in-out;
        }

        @keyframes fadeInDown {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Main Content */
        .content {
            padding: 3rem 2rem;
            text-align: center;
        }

        .content section {
            margin-bottom: 3rem;
        }

        h2 {
            margin-bottom: 1rem;
            color: #333;
            font-size: 2.5rem;
            position: relative;
            display: inline-block;
        }

        p {
            margin-bottom: 1rem;
            color: #666;
            font-size: 1.1rem;
        }

        /* Centered Header */
        .centered-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        /* Scrollable Cards */
        .scrollable-cards {
            display: flex;
            flex-wrap: nowrap;
            overflow-x: auto;
            padding: 1rem 0;
            gap: 1rem;
        }

        .scrollable-cards::-webkit-scrollbar {
            height: 8px;
        }

        .scrollable-cards::-webkit-scrollbar-thumb {
            background-color: #ff6b6b;
            border-radius: 10px;
        }

        .scrollable-cards::-webkit-scrollbar-track {
            background-color: #f4f4f4;
        }

        /* Styling for individual cards */
        .service-item, .trainer, .rewards-item {
            flex: 0 0 auto;
            width: calc(25% - 1rem); /* 4 items per row */
            box-sizing: border-box;
            background-color: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }

        .service-item h3, .trainer h3, .rewards-item h4 {
            color: #ff6b6b;
        }

        .service-item:hover, .trainer:hover {
            transform: translateY(-10px);
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.2);
        }

        /* Owner Section */
        .owner {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #fff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .owner img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
            object-fit: cover;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            margin-bottom: 1rem;
            animation: zoomIn 1s ease-in-out;
        }

        @keyframes zoomIn {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .owner-info {
            max-width: 500px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        .owner-info h3 {
            color: #ff6b6b;
            margin-bottom: 1rem;
            font-size: 1.8rem;
            opacity: 0;
            animation: fadeInUp 1s ease-in-out 0.5s forwards;
        }

        .owner-info p {
            font-size: 1.1rem;
            color: #666;
        }

        @keyframes fadeInUp {
            from {
                transform: translateY(30px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Register Form */
        .register-form {
            max-width: 600px;
            margin: 2rem auto;
            padding: 3rem;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            animation: popUp 0.5s ease-in-out;
        }

        @keyframes popUp {
            from {
                transform: scale(0.9);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .register-form input, .register-form button {
            width: 100%;
            padding: 1rem;
            margin: 0.5rem 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .register-form button {
            background-color: #ff6b6b;
            color: white;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        .register-form button:hover {
            background-color: #e05757;
        }

        /* Footer */
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 2rem 2rem;
            margin-top: 2rem;
        }

        footer a {
            color: #ff6b6b;
            margin: 0 10px;
            transition: color 0.3s ease-in-out;
        }

        footer a:hover {
            color: #e05757;
        }

    </style>
</head>
<body>

    <!-- Header Section -->
    <header>
        <h1>Welcome to [Gym Name]</h1>
        <p>Your Journey to Fitness Starts Here</p>
    </header>

    <!-- Main Content -->
    <div class="content">

        <!-- About Section -->
        <section class="about">
            <h2>About Us</h2>
            <p>We are dedicated to helping you achieve your fitness goals with our state-of-the-art equipment, certified trainers, and a variety of classes and programs.</p>
        </section>

        <!-- Services Section -->
        <section class="services">
            <div class="centered-header">
                <h2>Our Services</h2>
            </div>
            <div class="scrollable-cards">
                <div class="service-item">
                    <h3>Personal Training</h3>
                    <p>One-on-one training sessions with our certified trainers to help you achieve your specific fitness goals.</p>
                </div>
                <div class="service-item">
                    <h3>Group Classes</h3>
                    <p>Join our high-energy group classes, including yoga, HIIT, spinning, and more, designed to challenge and inspire.</p>
                </div>
                <div class="service-item">
                    <h3>Cardio & Strength Equipment</h3>
                    <p>Access a wide range of modern cardio and strength equipment to build endurance and muscle.</p>
                </div>
                <div class="service-item">
                    <h3>Nutrition Counseling</h3>
                    <p>Get expert advice on nutrition to complement your fitness routine and achieve optimal results.</p>
                </div>
                <!-- Add more service items as needed -->
            </div>
        </section>

        <!-- Trainers Section -->
        <section class="trainers">
            <div class="centered-header">
                              <h2>Meet Our Trainers</h2>
            </div>
            <div class="scrollable-cards">
                <div class="trainer">
                    <img src="https://via.placeholder.com/150" alt="Trainer 1"> <!-- Replace with actual trainer image -->
                    <h3>Trainer Name 1</h3>
                    <p>Specialty: Strength Training</p>
                </div>
                <div class="trainer">
                    <img src="https://via.placeholder.com/150" alt="Trainer 2"> <!-- Replace with actual trainer image -->
                    <h3>Trainer Name 2</h3>
                    <p>Specialty: Yoga & Flexibility</p>
                </div>
                <div class="trainer">
                    <img src="https://via.placeholder.com/150" alt="Trainer 3"> <!-- Replace with actual trainer image -->
                    <h3>Trainer Name 3</h3>
                    <p>Specialty: Cardio & Conditioning</p>
                </div>
                <div class="trainer">
                    <img src="https://via.placeholder.com/150" alt="Trainer 4"> <!-- Replace with actual trainer image -->
                    <h3>Trainer Name 4</h3>
                    <p>Specialty: Functional Training</p>
                </div>
                <!-- Add more trainer items as needed -->
            </div>
        </section>

        <!-- Owner Section -->
        <section class="owner">
            <img src="https://via.placeholder.com/150" alt="Gym Owner"> <!-- Replace with actual owner's photo -->
            <div class="owner-info">
                <h3>Owner Name</h3>
                <p>Welcome to [Gym Name]! I am dedicated to providing a top-notch fitness experience and helping you achieve your goals. Feel free to reach out to me if you have any questions or need assistance.</p>
            </div>
        </section>

        <!-- Rewards and Awards Section -->
        <section class="rewards">
            <div class="centered-header">
                <h2>Our Rewards and Awards</h2>
            </div>
            <div class="scrollable-cards">
                <div class="rewards-item">
                    <h4>Best Fitness Center 2023</h4>
                    <p>Awarded by [Fitness Association] for excellence in facilities and service.</p>
                </div>
                <div class="rewards-item">
                    <h4>Top Personal Trainer 2023</h4>
                    <p>Recognized by [Fitness Magazine] for outstanding personal training services.</p>
                </div>
                <div class="rewards-item">
                    <h4>Most Innovative Gym 2023</h4>
                    <p>Honored for our innovative fitness programs and cutting-edge equipment.</p>
                </div>
                <div class="rewards-item">
                    <h4>Best Community Engagement</h4>
                    <p>Awarded for our commitment to community fitness and health initiatives.</p>
                </div>
                <!-- Add more rewards items as needed -->
            </div>
        </section>

        <!-- Registration Form Section -->
        <section class="registration">
            <div class="centered-header">
                <h2>Register Now</h2>
            </div>
            <form class="register-form">
                <input type="text" placeholder="Full Name" required>
                <input type="email" placeholder="Email Address" required>
                <input type="tel" placeholder="Phone Number" required>
                <input type="text" placeholder="Preferred Training Time" required>
                <button type="submit">Register</button>
            </form>
        </section>

    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 [Gym Name]. All Rights Reserved.</p>
        <p>
            <a href="#">Privacy Policy</a> | 
            <a href="#">Terms of Service</a> | 
            <a href="#">Contact Us</a>
        </p>
    </footer>

</body>
</html>