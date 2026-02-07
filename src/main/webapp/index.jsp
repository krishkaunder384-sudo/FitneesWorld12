<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitnessWorld</title>

    <!-- ================= Bootstrap ================= -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          crossorigin="anonymous">

    <!-- ================= Font Awesome ================= -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- ================= Global CSS ================= -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/assets/css/index.css">

    <!-- ================= HERO STYLES ================= -->
    <style>
        .fw-hero {
            min-height: 100vh;
            background:
                linear-gradient(rgba(0,0,0,0.72), rgba(0,0,0,0.72)),
                url("<%= request.getContextPath() %>/assets/images/hero-gym.jpg")
                center/cover no-repeat;
            display: flex;
            align-items: center;
            position: relative;
            color: #fff;
        }

        .fw-hero h1 {
            font-size: 3.8rem;
            font-weight: 800;
            line-height: 1.15;
        }

        .fw-hero span {
            color: #ff2e2e;
        }

        /* DARK SECTIONS */
        .fw-dark-section {
            background: #0b0b0b;
            padding: 90px 0;
        }

       /* CENTERED CONTENT CARD (FIXED DARK THEME) */
       .fw-card {
           max-width: 1200px;
           margin: auto;
           background: rgba(20,20,20,0.95);
           color: #e5e7eb;
           border-radius: 24px;
           padding: 60px 50px;
           box-shadow: 0 30px 70px rgba(0,0,0,0.7);
       }

       /* Ensure inner text consistency */
       .fw-card h1,
       .fw-card h2,
       .fw-card h3,
       .fw-card h4 {
           color: #ffffff;
       }

       .fw-card p {
           color: #bbbbbb;
       }

       /* Mobile fix */
       @media (max-width: 768px) {
           .fw-card {
               padding: 40px 22px;
               border-radius: 18px;
           }
       }


        /* Mobile fix */
        @media (max-width: 768px) {
            .fw-card {
                padding: 40px 22px;
                border-radius: 18px;
            }
        }


        .fw-hero p {
            font-size: 1.15rem;
            margin: 22px 0;
            max-width: 560px;
            color: #ddd;
        }

        .fw-btn-primary {
            background: #ff2e2e;
            color: #fff;
            border: none;
            padding: 12px 34px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .fw-btn-primary:hover {
            background: #e60023;
            transform: translateY(-2px);
        }

        .fw-btn-outline {
            border: 1px solid #fff;
            color: #fff;
            padding: 12px 30px;
            border-radius: 30px;
            margin-left: 15px;
            transition: all 0.3s ease;
        }

        .fw-btn-outline:hover {
            background: #fff;
            color: #000;
        }

        .fw-scroll {
            position: absolute;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            font-size: 0.85rem;
            color: #ccc;
            letter-spacing: 1px;
            animation: bounce 2s infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translate(-50%, 0); }
            50% { transform: translate(-50%, -8px); }
        }

        .fw-section {
            padding: 90px 0;
        }

        .fade-up {
            animation: fadeUp 0.9s ease;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(40px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .fw-hero h1 {
                font-size: 2.6rem;
            }

            .fw-btn-outline {
                display: block;
                margin: 15px 0 0;
            }
        }
    </style>
</head>

<body>

    <!-- ================= NAVBAR ================= -->
    <%@ include file="navbar.jsp" %>


    <section class="fw-hero">
        <div class="container fade-up">
            <h1>
                Build Your <span>Best Body</span><br>
                With FitnessWorld
            </h1>

            <p>
                Discover nearby gyms, expert trainers, flexible memberships
                and everything you need to transform your fitness journey.
            </p>

            <a href="<%= request.getContextPath() %>/signup.jsp"
               class="fw-btn-primary">
                Get Started
            </a>

            <a href="<%= request.getContextPath() %>/public-trainers.jsp"
               class="fw-btn-outline">
                Explore Trainers
            </a>
        </div>

        <div class="fw-scroll">SCROLL ↓</div>
    </section>


    <section class="fw-dark-section">
        <div class="fw-card">
            <%@ include file="pages/Main-1.jsp" %>
        </div>
    </section>

    <section class="fw-dark-section">
        <div class="fw-card">
            <%@ include file="pages/Main-2.jsp" %>
        </div>
    </section>

    <section class="fw-dark-section">
        <div class="fw-card">
            <%@ include file="pages/Main-3.jsp" %>
        </div>
    </section>



    <%@ include file="pages/Main-4_Footer.jsp" %>
    <%@ include file="script.jsp" %>

</body>
</html>
