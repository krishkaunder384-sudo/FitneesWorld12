

<style>
/* ================= FITNESSWORLD FOOTER ================= */

.fw-footer {
    background: #0b0b0b;
    color: #ccc;
    padding: 70px 40px 25px;
    font-family: "Poppins", Arial, sans-serif;
}

/* Grid */
.fw-footer-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 40px;
    margin-bottom: 35px;
}

/* Titles */
.fw-footer h5 {
    color: #fff;
    font-size: 1.05rem;
    margin-bottom: 18px;
    letter-spacing: 1px;
}

/* Text & links */
.fw-footer p,
.fw-footer a {
    font-size: 0.92rem;
    color: #bbb;
    line-height: 1.7;
    text-decoration: none;
}

.fw-footer a:hover {
    color: #ff2e2e;
}

/* Brand block */
.fw-brand-text {
    max-width: 260px;
}

/* Social icons */
.fw-socials img {
    width: 26px;
    margin-right: 14px;
    cursor: pointer;
    opacity: 0.85;
    transition: transform 0.3s ease, opacity 0.3s ease;
}

.fw-socials img:hover {
    transform: scale(1.2);
    opacity: 1;
}

/* Contact */
.fw-contact {
    display: flex;
    align-items: center;
    margin-bottom: 12px;
}

.fw-contact img {
    width: 22px;
    margin-right: 12px;
    opacity: 0.8;
}

/* Bottom bar */
.fw-footer-bottom {
    border-top: 1px solid #222;
    padding-top: 18px;
    text-align: center;
    font-size: 0.85rem;
    color: #777;
}

/* Responsive */
@media (max-width: 768px) {
    .fw-footer {
        padding: 50px 22px 20px;
    }
}
</style>

<footer class="fw-footer">

    <div class="fw-footer-grid">

        <!-- BRAND -->
        <div class="fw-brand-text">
            <img src="<%= request.getContextPath() %>/assets/fitness-world.png"
                 width="85" alt="FitnessWorld">

            <p class="mt-3">
                Connecting gym owners and fitness enthusiasts on a single
                platform for a smarter and stronger fitness experience.
            </p>

            <div class="fw-socials mt-4">
                <img src="<%= request.getContextPath() %>/assets/insta.svg" alt="Instagram">
                <img src="<%= request.getContextPath() %>/assets/facebook.svg" alt="Facebook">
                <img src="<%= request.getContextPath() %>/assets/vector.svg" alt="Twitter">
                <img src="<%= request.getContextPath() %>/assets/mdi-linkedin.svg" alt="LinkedIn">
                <img src="<%= request.getContextPath() %>/assets/youtube.svg" alt="YouTube">
            </div>
        </div>

        <!-- QUICK LINKS -->
        <div>
            <h5>Quick Links</h5>
            <p><a href="<%= request.getContextPath() %>/index.jsp">Home</a></p>
            <p><a href="<%= request.getContextPath() %>/nearbygym/nearbygym.jsp">Find a Gym</a></p>
            <p><a href="<%= request.getContextPath() %>/about-us.jsp">About Us</a></p>
            <p><a href="<%= request.getContextPath() %>/contact-us.jsp">Contact</a></p>
        </div>

        <!-- EXPLORE -->
        <div>
            <h5>Explore</h5>
            <p><a href="#">FAQs</a></p>
            <p><a href="#">Privacy Policy</a></p>
            <p><a href="#">Terms & Conditions</a></p>
            <p><a href="#">Success Stories</a></p>
        </div>

        <!-- CONTACT -->
        <div>
            <h5>Contact</h5>

            <div class="fw-contact">
                <img src="<%= request.getContextPath() %>/assets/mdi-location.svg" alt="">
                <span>Mumbai, India</span>
            </div>

            <div class="fw-contact">
                <img src="<%= request.getContextPath() %>/assets/ant-design-phone-outlined.svg" alt="">
                <span>(+91) 98765 43210</span>
            </div>

            <div class="fw-contact">
                <img src="<%= request.getContextPath() %>/assets/message.svg" alt="">
                <span>support@fitnessworld.com</span>
            </div>
        </div>

    </div>

    <div class="fw-footer-bottom">
        © <span id="currentYear"></span> FitnessWorld. All rights reserved.
        <br>
        Empowering fitness communities.
    </div>

</footer>

<script>
    document.getElementById("currentYear").innerText =
        new Date().getFullYear();
</script>
