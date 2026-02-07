<link rel="stylesheet"
      href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<style>
/* ================= MAIN-1 (HERO FEATURE) ================= */

.main-1 {
    position: relative;
    height: 90vh;
    background:
        linear-gradient(rgba(0,0,0,0.65), rgba(0,0,0,0.65)),
        url("assets/background-main.png") center/cover no-repeat;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
}

/* Content box */
.fw-main1-content {
    text-align: center;
    max-width: 700px;
    padding: 20px;
    animation: fadeUp 0.9s ease;
}

/* Headings */
.fw-main1-content h1 {
    font-family: "Crimson Text", serif;
    font-size: 3rem;
    font-weight: 700;
    color: #fff;
    letter-spacing: 2px;
}

.fw-main1-content h1 span {
    color: #ff2e2e;
}

.fw-main1-content p {
    color: #ddd;
    font-size: 1.1rem;
    margin: 20px auto 30px;
    line-height: 1.7;
}

/* CTA button */
.fw-main1-btn {
    background: transparent;
    border: 2px solid #fff;
    color: #fff;
    padding: 12px 34px;
    font-weight: 600;
    border-radius: 30px;
    transition: all 0.3s ease;
}

.fw-main1-btn:hover {
    background: #ff2e2e;
    border-color: #ff2e2e;
    transform: translateY(-2px);
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

/* Mobile */
@media (max-width: 768px) {
    .fw-main1-content h1 {
        font-size: 2.2rem;
    }
}
</style>

<!-- ================= MAIN-1 ================= -->
<div class="main-1">

    <div class="fw-main1-content">

        <h1>
            HOME OF THE <span>STRONGEST</span><br>
            CREW
        </h1>

        <p>
            Train with elite coaches, modern equipment and a community
            that pushes you beyond limits. Welcome to FitnessWorld.
        </p>

        <button class="fw-main1-btn"
                onclick="location.href='login.jsp'">
            JOIN NOW
        </button>

    </div>

</div>
