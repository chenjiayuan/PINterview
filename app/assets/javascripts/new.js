var New = (function() {
	
	var apiUrl = "";


	var makeGetRequest = function(url, onSuccess, onFailure) {
		 $.ajax({
		     type: 'GET',
		     url: apiUrl + url,
		     dataType: "json",
		     success: onSuccess,
		     error: onFailure
		 });
	};

	var makePostRequest = function(url, data, onSuccess, onFailure) {
		 $.ajax({
		     type: 'POST',
		     url: apiUrl + url,
		     data: JSON.stringify(data),
		     contentType: "application/json",
		     dataType: "json",
		     success: onSuccess,
		     error: onFailure
		 });
	};

	var attachCreateButton = function(e) {
		$('.wrapper').on('click', '.create-button', function(e) {

			e.preventDefault();
			var pin = {};
			pin.title = create.find(".title-input").val()
			pin.company = create.find(".company-input").val()
			pin.date = create.find(".date-input").val()
			pin.difficulty = create.find(".difficulty-input").val()
			pin.attire = create.find(".attire-input").val()
			pin.questions = create.find(".questions-input").val()
			pin.like_count = create.find(".like_count-input").val()
			pin.length = create.find(".length-input").val()
			pin.description = create.find(".description-input").val()

			console.log(pin);

			var onSuccess = function(data){
				location.replace("/");
			}

			var onFailure = function(){
				console.error("error");
			}

			makePostRequest("/pins/new", pin, onSuccess, onFailure);

		});
	}

	var attachCancelButton = function(e) {
		$('.wrapper-1').on('click', '.cancel-button', function(e) {
			location.replace("/");
		});
	}


	var start = function() {
		create = $(".newform");
		attachCreateButton();
		attachCancelButton();
	}

	return {
	  start: start
	};


})();