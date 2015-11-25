$(document).ready(function() {
    if ($('.pagination').length) {
        $(window).scroll(function() {
            var url = $('.pagination .next_page').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 60) {
                $('.pagination').text("Loading more Pins...");
                return $.getScript(url);
            }
        });
        return $(window).scroll();
    }
});