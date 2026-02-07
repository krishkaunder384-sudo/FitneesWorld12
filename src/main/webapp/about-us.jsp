<%@ page contentType="text/html; charset=UTF-8" %>

<!-- ✅ HEADER FIRST -->
<%@ include file="header.jsp" %>

<!-- ✅ NAVBAR SECOND -->
<%@ include file="navbar.jsp" %>

<style>
/* PAGE BASE */
body {
    background: #0b0b0b;
    color: #e5e7eb;
    font-family: "Poppins", Arial, sans-serif;
}

/* OFFSET for fixed navbar */
.page-offset {
    padding-top: 100px;
}

/* WRAPPER */
.about-wrapper {
    padding: 40px 15px 70px;
}

/* CARD */
.about-card {
    max-width: 1200px;
    margin: auto;
    background: rgba(20,20,20,0.92);
    backdrop-filter: blur(14px);
    padding: 45px;
    border-radius: 22px;
    box-shadow: 0 30px 60px rgba(0,0,0,0.7);
}

/* TITLE */
.about-title {
    text-align: center;
    margin-bottom: 40px;
}

.about-title h1 {
    font-weight: 800;
    letter-spacing: 1px;
}

.about-title span {
    color: #ff2e2e;
}

.about-text p {
    font-size: 1.05rem;
    line-height: 1.9;
    color: #ccc;
    margin-bottom: 18px;
}

/* CAROUSEL */
.carousel-inner img {
    border-radius: 16px;
    height: 360px;
    object-fit: cover;
    box-shadow: 0 20px 40px rgba(0,0,0,0.5);
}

/* BUTTON */
.btn-home {
    background: #ff2e2e;
    border: none;
    padding: 12px 34px;
    border-radius: 30px;
    font-weight: 600;
    color: #fff;
    transition: all 0.3s ease;
}

.btn-home:hover {
    background: #e60023;
    transform: translateY(-2px);
}

/* MOBILE */
@media (max-width: 768px) {
    .about-card {
        padding: 30px 22px;
    }

    .carousel-inner img {
        height: 260px;
    }
}
</style>

<div class="page-offset">
    <div class="about-wrapper">

        <div class="about-card">

            <!-- TITLE -->
            <div class="about-title">
                <h1>About <span>FitnessWorld</span></h1>
                <p class="text-muted">
                    Empowering fitness communities everywhere
                </p>
            </div>

            <div class="row">

                <!-- CAROUSEL -->
                <div class="col-md-6 mb-4">
                    <div id="aboutCarousel"
                         class="carousel slide"
                         data-ride="carousel"
                         data-interval="2600">

                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="nearbygym/img/Active.jpg" class="d-block w-100">
                            </div>
                            <div class="carousel-item">
                                <img src="nearbygym/img/BUTWAL.jpg" class="d-block w-100">
                            </div>
                            <div class="carousel-item">
                                <img src="nearbygym/img/KTM.jpg" class="d-block w-100">
                            </div>
                            <div class="carousel-item">
                                <img src="nearbygym/img/ROYAL.jpg" class="d-block w-100">
                            </div>
                            <div class="carousel-item">
                                <img src="nearbygym/img/MOSAKA FITNESS.jpg" class="d-block w-100">
                            </div>
                        </div>

                        <a class="carousel-control-prev" href="#aboutCarousel" data-slide="prev">
                            <span class="carousel-control-prev-icon"></span>
                        </a>

                        <a class="carousel-control-next" href="#aboutCarousel" data-slide="next">
                            <span class="carousel-control-next-icon"></span>
                        </a>
                    </div>
                </div>

                <!-- TEXT -->
                <div class="col-md-6 d-flex align-items-center">
                    <div class="about-text">
                        <p>
                            <strong>FitnessWorld</strong> connects fitness enthusiasts with
                            top gyms, trainers, and facilities in their local area.
                        </p>

                        <p>
                            Gym owners can showcase facilities, manage memberships,
                            and grow communities while users enjoy seamless booking.
                        </p>

                        <p>
                            Whether you are starting your journey or scaling your gym,
                            FitnessWorld supports a healthier future.
                        </p>
                    </div>
                </div>

            </div>

            <!-- BUTTON -->
            <div class="text-center mt-5">
                <a href="<%= request.getContextPath() %>/index.jsp"
                   class="btn btn-home">
                    Back to Home
                </a>
            </div>

        </div>
    </div>
</div>

<!-- ✅ GLOBAL SCRIPTS ONLY -->
<%@ include file="script.jsp" %>
