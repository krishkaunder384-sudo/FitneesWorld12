$(document).ready(function(){
	let editStatus=false;
	$('#edit-profile-button').click(function(){
		
		
		if(editStatus==false){
			/*alert("button clicked");*/
					$('#profile-details').hide()
					$('#profile-edit').show();
					editStatus=true;
					$(this).text("Back")
		}else{
			/*alert("button clicked");*/
					$('#profile-details').show()
					$('#profile-edit').hide();
					editStatus=false;
					$(this).text("Edit")
		}
		
		
		
		
		
		
	})
})