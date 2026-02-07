$(document).ready(function(e){
/*	alert("Add Post ");
*/	
	$('#add-post-form').on('submit' , function(event){
		//This code get call when form is submitted..
		//asynchronous
		console.log("You have clicked on Submit");
		event.preventDefault();
		
		let form = new FormData(this);
		
		
		//now request to servlet
		$.ajax({
			
			url:"addpostservlet",
			type:"POST",
			data :form,
			success: function(data , textStatus , jqXHR){
				//success..
				console.log(data); 
				
				if(data.trim()=="done"){
					swal("Good job!", "saved successfully", "success")
					.then(function() {
					                        // Redirect immediately after clicking "Done"
					                        window.location.href = "profile.jsp";
					                    });
					
				}else{
					//error
					swal("Error!!", "Something went wrong try again...", "error");
				}
				
			
				
			},
			error:function(data , textStatus , errorThrown){
				//error..
				swal("Error!!", "Something went wrong try again...", "error");
			},
			processData :false,
			contentType: false
			
		})
		
	})
	
	
	
});