// var init_freeuser_lookup;

console.log('beingloaded')
$(document).ready(function(){
	$(document).on('submit', '#user-lookup-form', function(e){
		console.log('is it getting herer')
		e.preventDefault();
		console.log('im going in to here')
		$.ajax({
			url: '/search_freeusers',
			type: "post",
			data: $(this).serialize()
		}).success(function(data){
			console.log(data);
			$('#user-lookup').replaceWith(data);
				// init_image_lookup();
		}).error(function(err){
			console.log(err);
			$('#user-lookup-results').replaceWith('');
			$('#user-lookup-errors').replaceWith('User was not found');
		})
		return false;			
	})
	
         
})