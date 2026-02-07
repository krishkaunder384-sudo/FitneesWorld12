

<style>
/* ================= SERVICES & FACILITIES (MAIN-3) ================= */

.main-3 {
    background: linear-gradient(to bottom, #f5f6f8, #ffffff);
    padding: 6rem 0;
    width: 100%;
}

/* Section heading */
.services-header {
    text-align: center;
    margin-bottom: 4rem;
}

.services-header h2 {
    font-family: "Poppins", Arial, sans-serif;
    font-size: 2.6rem;
    font-weight: 800;
    margin-bottom: 10px;
    color: #111;
}

.services-header span {
    color: #ff2e2e;
}

.services-header p {
    max-width: 620px;
    margin: auto;
    font-size: 1rem;
    color: #666;
    line-height: 1.7rem;
}

/* Cards grid */
.card-container {
    max-width: 1200px;
    margin: auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
    gap: 32px;
    padding: 0 2rem;
}

/* Card */
.service-card {
    background: #ffffff;
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 18px 40px rgba(0,0,0,0.12);
    transition: transform 0.4s ease, box-shadow 0.4s ease;
}

.service-card:hover {
    transform: translateY(-14px);
    box-shadow: 0 35px 70px rgba(0,0,0,0.22);
}

/* Image */
.service-card img {
    width: 100%;
    height: 220px;
    object-fit: cover;
    transition: transform 0.45s ease;
}

.service-card:hover img {
    transform: scale(1.08);
}

/* Content */
.service-content {
    padding: 1.8rem 1.6rem;
    text-align: center;
}

.service-content h4 {
    font-family: "Poppins", Arial, sans-serif;
    font-size: 1.15rem;
    font-weight: 700;
    color: #222;
    margin-bottom: 0.9rem;
    transition: color 0.3s ease;
}

.service-card:hover h4 {
    color: #ff2e2e;
}

.service-content p {
    font-size: 0.95rem;
    line-height: 1.65rem;
    color: #555;
}

/* Responsive */
@media (max-width: 768px) {
    .main-3 {
        padding: 4.5rem 0;
    }

    .services-header h2 {
        font-size: 2.1rem;
    }
}
</style>

<!-- ================= MAIN-3 ================= -->
<section class="main-3">

    <!-- SECTION HEADER -->
    <div class="services-header">
        <h2>
            Services & <span>Facilities</span>
        </h2>
        <p>
            Everything you need to build strength, flexibility and confidence —
            all under one platform.
        </p>
    </div>

    <!-- CARDS -->
    <div class="card-container">

        <div class="service-card">
            <img src="<%= request.getContextPath() %>/assets/r-2-1-2.png"
                 alt="Personal Trainers">
            <div class="service-content">
                <h4>PERSONAL & FLOOR TRAINERS</h4>
                <p>
                    Get access to certified personal and floor trainers who
                    guide you with custom workouts and real-time support.
                </p>
            </div>
        </div>

        <div class="service-card">
            <img src="<%= request.getContextPath() %>/assets/r-2-1-2.png"
                 alt="Yoga Instructors">
            <div class="service-content">
                <h4>YOGA INSTRUCTORS</h4>
                <p>
                    Improve flexibility, balance and mental focus with expert
                    yoga instructors suited for all levels.
                </p>
            </div>
        </div>

        <div class="service-card">
            <img src="<%= request.getContextPath() %>/assets/r-2-1-2.png"
                 alt="Nutritionists">
            <div class="service-content">
                <h4>NUTRITIONISTS</h4>
                <p>
                    Work with professional nutritionists to build sustainable
                    diet plans aligned with your fitness goals.
                </p>
            </div>
        </div>

        <div class="service-card">
            <img src="<%= request.getContextPath() %>/assets/r-2-1-2.png"
                 alt="Group Classes">
            <div class="service-content">
                <h4>GROUP FITNESS CLASSES</h4>
                <p>
                    Stay motivated with high-energy group classes led by
                    experienced trainers in a supportive environment.
                </p>
            </div>
        </div>

    </div>
</section>
