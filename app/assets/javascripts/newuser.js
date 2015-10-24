/**
 * Created by wchoulos on 10/23/15.
 */
var Newuser = (function() {

    var apiUrl = "";

/*http://stackoverflow.com/questions/7203304/warning-cant-verify-csrf-token-authenticity-rails for the beforeSend line*/
    var makeGetRequest = function(url, onSuccess, onFailure) {
        $.ajax({
            type: 'GET',
            url: apiUrl + url,
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            dataType: "json",
            success: onSuccess,
            error: onFailure
        });
    };

    var makePostRequest = function(url, data, onSuccess, onFailure) {
        $.ajax({
            type: 'POST',
            url: apiUrl + url,
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            data: JSON.stringify(data),
            contentType: "application/json",
            dataType: "json",
            success: onSuccess,
            error: onFailure
        });
    };

    var attachCreateButton = function(e) {
        $('.wrapper-user').on('click', '.create-user-button', function(e) {

            e.preventDefault();
            var newUser = {};
            newUser.username = create.find(".username-input").val()
            newUser.email = create.find(".email-input").val()
            newUser.password = create.find(".password-input").val()
            newUser.password_confirmation = create.find(".password-confirmation-input").val()
            newUser.grad_class = create.find(".grad-class-input").val()
            newUser.major = create.find(".major-input").val()

            console.log(newUser);

            var onSuccess = function(data){
                location.replace("/");
            }

            var onFailure = function(){
                console.error("error");
            }

            makePostRequest("/users", newUser, onSuccess, onFailure);

        });
    }

    var attachCancelButton = function(e) {
        $('.wrapper-user-1').on('click', '.cancel-user-button', function(e) {
            location.replace("/welcome");
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