/*
    function previewPhoto(inputId, previewId) {
        const fileInput = document.getElementById(inputId);
        const preview = document.getElementById(previewId);
        const file = fileInput.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Photo" style="max-width: 150px;">`;
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = 'No photo uploaded';
        }
    }


    // Add service for card display
    function addService() {
        const serviceContainer = document.getElementById('services-container');
        const serviceCard = document.createElement('div');
        serviceCard.className = 'card';
        serviceCard.innerHTML = `
            <input type="text" placeholder="Service Name" required>
            <textarea placeholder="Service Description"></textarea>
            <div class="file-input-wrapper">
                <label for="servicePhoto">Upload Service Photo</label>
                <input type="file" id="servicePhoto" accept="image">
            </div>
            <span class="remove-btn" onclick="removeCard(this)">Remove</span>
        `;
        serviceContainer.appendChild(serviceCard);
    }

    function previewServicePhoto(input) {
        const preview = input.nextElementSibling;
        const file = input.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Photo" style="max-width: 150px;">`;
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = 'No photo uploaded';
        }
    }
    // Function to remove a card (e.g., service card)
function removeCard(button) {
    const card = button.parentElement;
    card.remove();
}

    //add trainner for card display
    function addTrainer() {
        const trainerContainer = document.getElementById('trainers-container');
        const trainerCard = document.createElement('div');
        trainerCard.className = 'card';
        trainerCard.innerHTML = `
            <input type="text" placeholder="Trainer Name" required>
            <input type="number" placeholder="Trainer Age" required>
            <div class="file-input-wrapper">
                <label for="trainerPhoto">Upload Trainer Photo</label>
                <input type="file" id="trainerPhoto" accept="image">
            </div>
            <input type="text" placeholder="Award (Optional)">
            <input type="tel" placeholder="Phone Number (Optional)">
            <input type="text" placeholder="Social Media (Optional)">
            <input type="email" placeholder="Email (Optional)">
            <textarea placeholder="Address (Optional)"></textarea>
            <span class="remove-btn" onclick="removeCard(this)">Remove</span>
        `;
        trainerContainer.appendChild(trainerCard);
    }

    function previewTrainerPhoto(input) {
        const preview = input.nextElementSibling;
        const file = input.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Photo" style="max-width: 150px;">`;
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = 'No photo uploaded';
        }
    }


    //add reward for card display
    function addReward() {
        const rewardContainer = document.getElementById('rewards-container');
        const rewardCard = document.createElement('div');
        rewardCard.className = 'card';
        rewardCard.innerHTML = `
            <textarea placeholder="Reward Description"></textarea>
            <div class="file-input-wrapper">
                <label for="rewardPhoto">Upload Reward Photo</label>
                <input type="file" id="rewardPhoto" accept="image">
            </div>
            <span class="remove-btn" onclick="removeCard(this)">Remove</span>
        `;
        rewardContainer.appendChild(rewardCard);
    }


    function previewRewardPhoto(input) {
        const preview = input.nextElementSibling;
        const file = input.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Photo" style="max-width: 150px;">`;
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = 'No photo uploaded';
        }
    }

    function removeCard(element) {
        element.parentElement.remove();
    }

    function generateWebsite() {
        const gymName = document.getElementById('gymName').value;
        const gymOwner = document.getElementById('gymOwner').value;
        const ownerEmail = document.getElementById('ownerEmail').value;
        const ownerPhone = document.getElementById('ownerPhone').value;
        const ownerAddress = document.getElementById('ownerAddress').value;
        const gymAbout = document.getElementById('gymAbout').value;

        document.getElementById('outputGymName').textContent = gymName;
        document.getElementById('outputGymOwner').textContent = gymOwner;
        document.getElementById('outputOwnerEmail').textContent = `Email: ${ownerEmail}`;
        document.getElementById('outputOwnerPhone').textContent = `Phone: ${ownerPhone}`;
        document.getElementById('outputOwnerAddress').textContent = `Address: ${ownerAddress}`;
        document.getElementById('outputGymAbout').textContent = gymAbout;

        const servicesContainer = document.getElementById('services-container');
        const outputServices = document.getElementById('outputServices');
        outputServices.innerHTML = '';
        servicesContainer.querySelectorAll('.card').forEach(card => {
            const serviceName = card.querySelector('input[type="text"]').value;
            const serviceDesc = card.querySelector('textarea').value;
            const servicePhoto = card.querySelector('.photo-preview img')?.src || '';
            const serviceCard = document.createElement('div');
            serviceCard.className = 'card';
            serviceCard.innerHTML = `
                <h4>${serviceName}</h4>
                <p>${serviceDesc}</p>
                <img src="${servicePhoto}" alt="${serviceName}" style="max-width: 150px;">
            `;
            outputServices.appendChild(serviceCard);
        });

        const trainersContainer = document.getElementById('trainers-container');
        const outputTrainers = document.getElementById('outputTrainers');
        outputTrainers.innerHTML = '';
        trainersContainer.querySelectorAll('.card').forEach(card => {
            const trainerName = card.querySelector('input[type="text"]').value;
            const trainerAge = card.querySelector('input[type="number"]').value;
            const trainerPhoto = card.querySelector('.photo-preview img')?.src || '';
            const trainerAward = card.querySelector('input[type="text"]').value;
            const trainerPhone = card.querySelector('input[type="tel"]').value;
            const trainerSocial = card.querySelector('input[type="text"]').value;
            const trainerEmail = card.querySelector('input[type="email"]').value;
            const trainerAddress = card.querySelector('textarea').value;
            const trainerCard = document.createElement('div');
            trainerCard.className = 'card';
            trainerCard.innerHTML = `
                <h4>${trainerName} (Age: ${trainerAge})</h4>
                ${trainerAward ? `<p>Award: ${trainerAward}</p>` : ''}
                ${trainerPhone ? `<p>Phone: ${trainerPhone}</p>` : ''}
                ${trainerSocial ? `<p>Social Media: ${trainerSocial}</p>` : ''}
                ${trainerEmail ? `<p>Email: ${trainerEmail}</p>` : ''}
                ${trainerAddress ? `<p>Address: ${trainerAddress}</p>` : ''}
                <img src="${trainerPhoto}" alt="${trainerName}" style="max-width: 150px;">
            `;
            outputTrainers.appendChild(trainerCard);
        });

        const rewardsContainer = document.getElementById('rewards-container');
        const outputRewards = document.getElementById('outputRewards');
        outputRewards.innerHTML = '';
        rewardsContainer.querySelectorAll('.card').forEach(card => {
            const rewardDesc = card.querySelector('textarea').value;
            const rewardPhoto = card.querySelector('.photo-preview img')?.src || '';
            const rewardCard = document.createElement('div');
            rewardCard.className = 'card';
            rewardCard.innerHTML = `
                <p>${rewardDesc}</p>
                <img src="${rewardPhoto}" alt="Reward" style="max-width: 150px;">
            `;
            outputRewards.appendChild(rewardCard);
        });

        document.getElementById('input-form').classList.add('hidden');
        document.getElementById('website-output').classList.remove('hidden');
    }

    function editDetails() {
        document.getElementById('input-form').classList.remove('hidden');
        document.getElementById('website-output').classList.add('hidden');
    }





    function previewPhoto(inputId, previewId) {
        const fileInput = document.getElementById(inputId);
        const preview = document.getElementById(previewId);
        const file = fileInput.files[0];
        
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                preview.innerHTML = `<img src="${e.target.result}" alt="Uploaded Photo" style="max-width: 150px;">`;
            };
            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = 'No photo uploaded';
        }
    }




    function generateWebsite() {
        const gymName = document.getElementById('gymName').value;
        const gymOwner = document.getElementById('gymOwner').value;
        const ownerEmail = document.getElementById('ownerEmail').value;
        const ownerPhone = document.getElementById('ownerPhone').value;
        const ownerAddress = document.getElementById('ownerAddress').value;
        const gymAbout = document.getElementById('gymAbout').value;
        const gymPhoto = document.getElementById('gymPhoto').files[0];
        const ownerPhoto = document.getElementById('ownerPhoto').files[0];
    
        document.getElementById('outputGymName').innerText = `Welcome to ${gymName}`;
        document.getElementById('outputGymOwner').innerText = gymOwner;
        document.getElementById('outputOwnerEmail').innerText = `Email: ${ownerEmail}`;
        document.getElementById('outputOwnerPhone').innerText = `Phone: ${ownerPhone}`;
        document.getElementById('outputOwnerAddress').innerText = `Address: ${ownerAddress}`;
        document.getElementById('outputGymAbout').innerText = gymAbout;
    
        if (gymPhoto) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('gymHeader').style.backgroundImage = `url(${e.target.result})`;
            };
            reader.readAsDataURL(gymPhoto);
        }
    
        if (ownerPhoto) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById('outputOwnerPhoto').src = e.target.result;
            };
            reader.readAsDataURL(ownerPhoto);
        }
    
        const serviceCards = document.querySelectorAll('#services-container .card');
        const serviceOutput = document.getElementById('outputServices');
        serviceOutput.innerHTML = '';
        serviceCards.forEach(card => {
            const serviceName = card.querySelector('input[type="text"]').value;
            const serviceDesc = card.querySelector('textarea').value;
            const servicePhoto = card.querySelector('#servicePhoto').files[0];
            const serviceCard = document.createElement('div');
            serviceCard.className = 'card';
            serviceCard.innerHTML = `
                <h4>${serviceName}</h4>
                <p>${serviceDesc}</p>
                <img src="${servicePhoto ? URL.createObjectURL(servicePhoto) : 'https://via.placeholder.com/150'}" alt="${serviceName}">
            `;
            serviceOutput.appendChild(serviceCard);
        });
    
        const trainerCards = document.querySelectorAll('#trainers-container .card');
        const trainerOutput = document.getElementById('outputTrainers');
        trainerOutput.innerHTML = '';
        trainerCards.forEach(card => {
            const trainerName = card.querySelector('input[type="text"]').value;
            const trainerAge = card.querySelector('input[type="number"]').value;
            const trainerPhoto = card.querySelector('#trainerPhoto').files[0];
            const trainerCard = document.createElement('div');
            trainerCard.className = 'card';
            trainerCard.innerHTML = `
                 <h4>${trainerName}, ${trainerAge} years old</h4>
                <img src="${trainerPhoto ? URL.createObjectURL(trainerPhoto) : 'https://via.placeholder.com/150'}" alt="${trainerName}">
            `;
            trainerOutput.appendChild(trainerCard);
        });
    
        const rewardCards = document.querySelectorAll('#rewards-container .card');
        const rewardOutput = document.getElementById('outputRewards');
        rewardOutput.innerHTML = '';
        rewardCards.forEach(card => {
            const rewardDesc = card.querySelector('textarea').value;
            const rewardPhoto = card.querySelector('#rewardPhoto').files[0];
            const rewardCard = document.createElement('div');
            rewardCard.className = 'card';
            rewardCard.innerHTML = `
                <p>${rewardDesc}</p>
                <img src="${rewardPhoto ? URL.createObjectURL(rewardPhoto) : 'https://via.placeholder.com/150'}" alt="Reward Photo">
            `;
            rewardOutput.appendChild(rewardCard);
        });
    
        document.getElementById('input-form').classList.add('hidden');
        document.getElementById('website-output').classList.remove('hidden');
    }










    // JavaScript to handle dynamic behavior
function showPaymentOptions() {
    document.getElementById('paymentSection').classList.remove('hidden');
    document.querySelector('.registration').classList.add('hidden');
}

function handleRegistration() {
    var fullName = document.getElementById('fullName').value;
    var emailAddress = document.getElementById('emailAddress').value;
    var phoneNumber = document.getElementById('phoneNumber').value;
    var timeSlot = document.getElementById('timeSlot').value;

    if (fullName && emailAddress && phoneNumber && timeSlot) {
        showPaymentOptions();
    } else {
        alert('Please fill in all the required fields.');
    }
}

document.getElementById('medicalConditionsCheckbox').addEventListener('change', function() {
    var medicalConditionsDetails = document.getElementById('medicalConditionsDetails');
    if (this.checked) {
        medicalConditionsDetails.classList.remove('hidden');
    } else {
        medicalConditionsDetails.classList.add('hidden');
    }
});

document.getElementById('disabilityCheckbox').addEventListener('change', function() {
    var disabilityDetails = document.getElementById('disabilityDetails');
    if (this.checked) {
        disabilityDetails.classList.remove('hidden');
    } else {
        disabilityDetails.classList.add('hidden');
    }
});

// Function to populate time slots
function populateTimeSlots(timeSlots) {
    var timeSlotSelect = document.getElementById('timeSlot');
    timeSlots.forEach(function(slot) {
        var option = document.createElement('option');
        option.value = slot.value;
        option.textContent = slot.text;
        timeSlotSelect.appendChild(option);
    });
}

// Example time slots (to be replaced with dynamic data)
var timeSlots = [
    { value: '09:00-10:00', text: '09:00 AM - 10:00 AM' },
    { value: '10:00-11:00', text: '10:00 AM - 11:00 AM' },
    { value: '11:00-12:00', text: '11:00 AM - 12:00 PM' },
    { value: '12:00-01:00', text: '12:00 PM - 01:00 PM' },
    { value: '01:00-02:00', text: '01:00 PM - 02:00 PM' },
    { value: '02:00-03:00', text: '02:00 PM - 03:00 PM' }
];

// Populate time slots on page load
window.onload = function() {
    populateTimeSlots(timeSlots);
};






// <!-- JavaScript for Handling Form and Updating Footer -->
document.addEventListener('DOMContentLoaded', function() {
    const currentYear = new Date().getFullYear();
    document.getElementById('currentYear').textContent = currentYear;

    document.querySelector('button[onclick="generateWebsite()"]').addEventListener('click', function() {
        // Get gym name from the form
        const gymName = document.getElementById('gymName').value;

        if (gymName) {
            // Update footer with gym name
            document.getElementById('footerGymName').textContent = gymName;

            // Optionally, store the details locally (e.g., in localStorage or a database)
            localStorage.setItem('gymName', gymName);
            localStorage.setItem('registrationDate', new Date().toISOString());
        } else {
            alert('Please enter the gym name.');
        }
    });

    // Optionally, set the gym name from localStorage if it exists
    const storedGymName = localStorage.getItem('gymName');
    if (storedGymName) {
        document.getElementById('footerGymName').textContent = storedGymName;
    }
});

    
*/