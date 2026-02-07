//load posts using ajax
//Main Body of the pages

function getPosts(catId , temp){
	$("#loader").show();
	$("#post-container").hide();
	
	/*Active link */
	$(".c-link").removeClass('active')
	
	
	
	$.ajax({
		url:"load_posts.jsp",
		data:{cid:catId},
		success: function( data , textStatus , jqXHR){
/*			console.log(data);
*/			$("#loader").hide();
			$("#post-container").show();
			$("#post-container").html(data)
			$(temp).addClass('active');
		}
		
	})
}



$(document).ready(function(e){
/*	alert ("Loading page");*/

let allPostRef=$('.c-link')[0]

getPosts(0 , allPostRef)


	
});