var Pin = (function() {
	
	var apiUrl = "";

	var pins;
	var pinTemplateHtml;

  var makeGetRequest = function(url, onSuccess, onFailure) {
     $.ajax({
         type: 'GET',
         url: apiUrl + url,
         dataType: "json",
         success: onSuccess,
         error: onFailure
     });
  };

  var insertPin = function(pin, beginning){
    var newElem = $(pinTemplateHtml);
    newElem.attr('id', pin.id);
    newElem.find('.title').text(pin.title);
    newElem.find('.company').text(pin.company);
    newElem.find('.date').text(pin.date);
    //newElem.find('.type').text(pin.type);
    newElem.find('.attire').text(pin.attire);
    newElem.find('.difficulty').text(pin.difficulty);
    newElem.find('.length').text(pin.length);
    newElem.find('.questions').text(pin.questions);
    newElem.find('.description').text(pin.description);
    newElem.find('.like_count').text(pin.like_count);
    newElem.find('.timestamp').text(pin.created_at);

    console.log(newElem);

    if (beginning){
      pins.prepend(newElem);
    } else {
      pins.append(newElem);
    }

  }

  var displayPins = function() {
    var onSuccess = function(data){
      var pins_array = data["pins"];
      for (i = pins_array.length - 1; i > -1; i--){
        insertPin(pins_array[i], true);
        //console.log(pins_array[i]);
      }
    };
    var onFailure = function(){
      //console.error("error");
    }

    makeGetRequest("/pins", onSuccess, onFailure);
  };



  var start = function() {
    pinTemplateHtml = $(".pins .pin")[0].outerHTML;
    //console.log(pinTemplateHtml);

    pins = $(".pins");
    pins.html('');

  	displayPins();
    
  }

  return {
      start: start
  };

})();