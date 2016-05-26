$(document).ready(function(){
	console.log('is this file being loaded');
})
var init_image_lookup;


	$("#image-lookup-form").submit(function(e){
		e.preventDefault();
		console.log('im going in to here')
		$.ajax({
			url: '/search_images',
			type: "post",
			data: $(this).serialize()
		}).success(function(data){
			console.log(data);
		}).error(function(err){
			console.log(err);
		})
		return false;
	})

init_image_lookup = function(){

	$('#image-lookup-form').on('ajax:before', function(event, data, status){
		// show_spinner();
		console.log('before ajax')
	});

	// $('#image-lookup-form').on('ajax:after', function(event, data, status){
	// 	hide_spinner();
	// });



	$('#image-lookup-form').on('ajax:success', function(event, data, status){
		console.log(data, event, status);
		console.log('something succes')
		$('#image-lookup').replaceWith(data);
		init_image_lookup();
	});

	$('#image-lookup-form').on('ajax:error', function(event, xhr, status, error){
		// hide_spinner(); 
				console.log('something error')

		console.log(error)
		$('#image-lookup-results').replaceWith('');
		$('#image-lookup-errors').replaceWith('Image was not found');
	});
}



$(document).ready(function(){
	init_image_lookup();

});