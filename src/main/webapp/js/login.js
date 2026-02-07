function showUser() {
    document.getElementById("userLogin").classList.remove("hidden");
    document.getElementById("trainerLogin").classList.add("hidden");
}

function showTrainer() {
    document.getElementById("trainerLogin").classList.remove("hidden");
    document.getElementById("userLogin").classList.add("hidden");
}
