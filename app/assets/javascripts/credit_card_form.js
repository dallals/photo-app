// $(document).ready(function(){
// 	console.log('is this being loaded')
// 	var show_error, stripeResponseHandler, submitHandler;

// 	submitHandler= function(event){
// 		var $form = $(event.target);
// 		$form.find("input[type=submit]").prop("disabled", true);
// 		//If sripe was init correctly this will create a token using the credit card info
// 		if(Stripe){
// 			Stripe.card.createToken($form, stripeResponseHandler);
// 		} else {
// 			show_error("Failed to load credit card processing function. Please reload this page")
// 		}
// 		return false;
// 	};

// 	$(".cc_form").on('submit', submitHandler);

// 	stripeResponseHandler = function(status, response){
// 		var token, $form;
// 		$form = $('.cc_form');

// 		if (response.error){
// 			console.log(response.error.message);
// 			show_error(response.error.message);
// 			$form.find("input[type=submit]").prop("disabled", false);

// 		}else{
// 			token = response.id;
// 			$form.append($("<input type=\"hidden\" name=\"payment[token]\" />").val(token));
// 			$("[data-stripe=number]").remove();
// 			$("[data-stripe=cvv]").remove();
// 			$("[data-stripe=exp-year]").remove();
// 			$("[data-stripe=label]").remove();
// 		}

// 		return false;
// 	};

// 	show_error = function(message){
// 		if($("#flash-message").size() < 1){
// 			$('div.container.main div:first').prepend("<div id='flash-messages'></div>")
// 		}
// 		$("#flash-message").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">x</a><div id="flash_alert">' + message + '</div></div>');
// 		$('.alert').delay(5000).fadeOut(3000);
// 		return false;
// 	};
// })