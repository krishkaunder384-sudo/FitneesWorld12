<div class="container mt-5">
    <h1>Add Gym Details</h1>
    <form id="add-post-form" action="addpostservlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="gymName">Gym Name</label>
            <input name="gym_name" type="text" id="gymName" placeholder="Gym Name" class="form-control" required />
        </div>

        <div class="form-group">
            <label for="gymPhoto">Upload Gym Photo</label>
            <input type="file" name="gymPhoto" class="form-control" id="gymPhoto" accept="image/*" />
            <div id="gymPhotoPreview" class="photo-preview">No photo uploaded</div>
        </div>

        <div class="form-group">
            <label for="ownerName">Owner Name</label>
            <input name="owner_name" type="text" id="ownerName" placeholder="Owner Name" class="form-control" required />
        </div>

        <div class="form-group">
            <label for="ownerEmail">Owner Email</label>
            <input name="owner_email" type="email" id="ownerEmail" placeholder="Owner Email" class="form-control" required />
        </div>


        <div class="form-group">
            <label for="ownerAddress">Owner Address</label>
            <input name="owner_address" type="text" id="ownerAddress" placeholder="Owner Address" class="form-control" required />
        </div>

        <div class="form-group">
            <label for="ownerPhoto">Upload Photo of Owner</label>
            <input type="file" name="ownerPhoto" class="form-control" id="ownerPhoto" accept="image/*" onchange="previewPhoto('ownerPhoto', 'ownerPhotoPreview')" />
            <div id="ownerPhotoPreview" class="photo-preview">No photo uploaded</div>
        </div>

        <div class="form-group">
            <label for="gymAbout">About Gym</label>
            <textarea name="about_gym" class="form-control" id="gymAbout" style="height: 150px;" placeholder="About Gym"></textarea>
        </div>

        <div class="container text-center mt-4">
            <button type="submit" class="btn btn-outline-primary">Submit</button>
        </div>
    </form>
</div>

<script>
    function previewPhoto(inputId, previewId) {
        const fileInput = document.getElementById(inputId);
        const previewContainer = document.getElementById(previewId);
        const file = fileInput.files[0];

        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                previewContainer.innerHTML = '<img src="' + e.target.result + '" alt="Photo Preview" style="max-width: 100%; height: auto;" />';
            }
            reader.readAsDataURL(file);
        } else {
            previewContainer.innerHTML = 'No photo uploaded';
        }
    }
</script>


 <!-- 
    <div class="container mt-5">
        <h1>Add Gym Details</h1>
        <form id="add-post-form" action="addpostservlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input name="gymName" type="text" placeholder="Gym Name" class="form-control" required />
            </div>

            <div class="form-group">
                <label for="gymPhoto">Upload Gym Photo</label>
                <input type="file" name="gymPhoto" class="form-control" id="gymPhoto" accept="image/*"  />
                <div id="gymPhoto" class="photo-preview">No photo uploaded</div>
            </div>

            <div class="form-group">
                <input name="ownerName" type="text" placeholder="Owner Name" class="form-control" required />
            </div>

            <div class="form-group">
                <input name="ownerEmail" type="email" placeholder="Owner Email" class="form-control" required />
            </div>

            <div class="form-group">
                <input name="ownerPhone" type="tel" placeholder="Owner Phone" class="form-control" required />
            </div>

            <div class="form-group">
                <input name="ownerAddress" type="text" placeholder="Owner Address" class="form-control" required />
            </div>

            <div class="form-group">
                <label for="ownerPhoto">Upload Photo of Owner</label>
                <input type="file" name="ownerPhoto" class="form-control" id="ownerPhoto" accept="image/*" onchange="previewPhoto('ownerPhoto', 'ownerPhotoPreview')" />
                <div id="ownerPhotoPreview" class="photo-preview">No photo uploaded</div>
            </div>

            <div class="form-group">
                <textarea name="gymAbout" class="form-control" id="gymAbout" style="height: 150px;" placeholder="About Gym"></textarea>
            </div>

            <h3>Services</h3>
            <button type="button" class="btn btn-outline-primary" onclick="addService()">Add Service</button>
            <div id="services-container" class="grid-container"></div>

            <h3>Trainers</h3>
            <button type="button" class="btn btn-outline-primary" onclick="addTrainer()">Add Trainer</button>
            <div id="trainers-container" class="grid-container"></div>

            <h3>Rewards</h3>
            <button type="button" class="btn btn-outline-primary" onclick="addReward()">Add Reward</button>
            <div id="rewards-container" class="grid-container"></div>

            <div class="container text-center mt-4">
                <button type="submit" class="btn btn-outline-primary">Submit</button>
            </div>
        </form>
    </div>
 --> 