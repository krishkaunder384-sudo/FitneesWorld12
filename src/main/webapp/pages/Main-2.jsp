

<style>
/* ================= FITNESSWORLD INTRO (MAIN-2) ================= */

.fw-section {
    max-width: 1200px;
    margin: 6rem auto 5rem;
    padding: 0 3rem;
    animation: fadeUp 0.9s ease forwards;
}

/* Title */
.fw-title {
    text-align: center;
    font-family: "Poppins", Arial, sans-serif;
    font-size: 3.1rem;
    font-weight: 800;
    letter-spacing: 2px;
    color: #111;
    margin-bottom: 4rem;
}

/* Layout */
.fw-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 4.5rem;
}

/* Text */
.fw-text {
    flex: 1.2;
}

.fw-heading {
    font-size: 2.4rem;
    font-weight: 700;
    margin-bottom: 1.5rem;
    color: #111;
}

.fw-heading span {
    color: #ff2e2e;
}

.fw-paragraph {
    font-size: 1.05rem;
    line-height: 1.9rem;
    color: #444;
    margin-bottom: 2rem;
}

/* CTA */
.fw-cta {
    display: inline-block;
    margin-top: 10px;
    padding: 10px 26px;
    border-radius: 30px;
    border: 2px solid #ff2e2e;
    color: #ff2e2e;
    font-weight: 600;
    transition: all 0.3s ease;
    text-decoration: none;
}

.fw-cta:hover {
    background: #ff2e2e;
    color: #fff;
    transform: translateY(-2px);
}

/* Image */
.fw-image {
    flex: 1;
    display: flex;
    justify-content: flex-end;
}

.fw-image img {
    width: 100%;
    max-width: 520px;
    border-radius: 18px;
    object-fit: cover;
    box-shadow: 0 25px 50px rgba(0,0,0,0.2);
    transition: transform 0.4s ease;
}

.fw-image img:hover {
    transform: scale(1.05);
}

/* Animation */
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

/* Responsive */
@media (max-width: 900px) {
    .fw-section {
        padding: 0 1.5rem;
        margin: 4rem auto;
    }

    .fw-row {
        flex-direction: column;
        text-align: center;
        gap: 3rem;
    }

    .fw-title {
        font-size: 2.4rem;
    }

    .fw-heading {
        font-size: 2rem;
    }

    .fw-image {
        justify-content: center;
    }
}
</style>

<!-- ================= MAIN-2 ================= -->
<section class="fw-section">

    <h1 class="fw-title">FITNESSWORLD</h1>

    <div class="fw-row">

        <!-- TEXT -->
        <div class="fw-text">
            <div class="fw-heading">
                FITNESS TRAINING<br>
                <span>FitnessWorld</span>
            </div>

            <p class="fw-paragraph">
                Welcome to FitnessWorld — the platform that connects you with
                top-rated gyms and expert trainers around you. Whether you’re
                just starting out or pushing elite fitness goals, we help you
                find the perfect environment to succeed.
                <br><br>
                Discover gyms with real reviews, modern equipment and flexible
                memberships designed around your lifestyle.
            </p>

            <a href="<%= request.getContextPath() %>/nearbygym/nearbygym.jsp"
               class="fw-cta">
                Find Gyms Near You
            </a>
        </div>

        <!-- IMAGE -->
        <div class="fw-image">
            <img src="<%= request.getContextPath() %>/assets/r-1-1.png"
                 alt="Fitness Training">
        </div>

    </div>
</section>
