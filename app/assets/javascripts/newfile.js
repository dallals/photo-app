var init_image_lookup;

console.log('beingloaded')
$(document).ready(function(){
	$(document).on('submit', '#image-lookup-form', function(e){
		console.log('is it getting herer')
		e.preventDefault();
		console.log('im going in to here')
		$.ajax({
			url: '/search_images',
			type: "post",
			data: $(this).serialize()
		}).success(function(data){
			console.log(data);
			$('#image-lookup').replaceWith(data);
				// init_image_lookup();
		}).error(function(err){
			console.log(err);
			$('#image-lookup-results').replaceWith('');
			$('#image-lookup-errors').replaceWith('Image was not found');
		})
		return false;
		
			
	})

	
		$('#slideshowHolder').jqFancyTransitions({ width: 700, height: 450});
	

	// init_image_lookup = function(){

	// 		$('#image-lookup-form').on('ajax:before', function(event, data, status){
	// 			// show_spinner();
	// 			console.log('before ajax')
	// 		});

	// 	// $('#image-lookup-form').on('ajax:after', function(event, data, status){
	// 	// 	hide_spinner();
	// 	// });



	// 		$('#image-lookup-form').on('ajax:success', function(event, data, status){
	// 			$('#image-lookup').replaceWith(data);
	// 			init_image_lookup();
	// 		});

	// 		$('#image-lookup-form').on('ajax:error', function(event, xhr, status, error){
	// 			// hide_spinner(); 
	// 			console.log(error)
	// 			$('#image-lookup-results').replaceWith('');
	// 			$('#image-lookup-errors').replaceWith('Image was not found');
	// 		});
	// }

})



// init_image_lookup = function(){

// 	$('#image-lookup-form').on('ajax:before', function(event, data, status){
// 		// show_spinner();
// 		console.log('before ajax')
// 	});

// 	// $('#image-lookup-form').on('ajax:after', function(event, data, status){
// 	// 	hide_spinner();
// 	// });



// 	$('#image-lookup-form').on('ajax:success', function(event, data, status){
// 		console.log(data, event, status);
// 		console.log('something succes')
// 		$('#image-lookup').replaceWith(data);
// 		init_image_lookup();
// 	});

// 	$('#image-lookup-form').on('ajax:error', function(event, xhr, status, error){
// 		// hide_spinner(); 
// 				console.log('something error')

// 		console.log(error)
// 		$('#image-lookup-results').replaceWith('');
// 		$('#image-lookup-errors').replaceWith('Image was not found');
// 	});
// }