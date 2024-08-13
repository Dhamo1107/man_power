$(document).ready(function() {
    // Highlight the active link based on the current URL
    var pathname = window.location.pathname;
    $('.side-link li a').each(function() {
        var linkPath = $(this).attr('href');
        if (pathname === linkPath) {
            $(this).addClass('active');
        }
    });

    // Handle link clicks
    $(document).on('click', '.side-link li a', function(event) {
        if ($(this).hasClass('active')) {
            // If the clicked link is already active, do nothing
            return;
        }
        // Remove the active class from all links
        $('.side-link li a').removeClass('active');
        // Add the active class to the clicked link
        $(this).addClass('active');
    });
});
