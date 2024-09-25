// $(document).ready(function() {
//     // Highlight the active link based on the current URL
//     var pathname = window.location.pathname;
//     $('.side-link li a').each(function() {
//         var linkPath = $(this).attr('href');
//         if (pathname === linkPath) {
//             $(this).addClass('active');
//         }
//     });
//
//     // Handle link clicks
//     $(document).on('click', '.side-link li a', function(event) {
//         if ($(this).hasClass('active')) {
//             // If the clicked link is already active, do nothing
//             return;
//         }
//         // Remove the active class from all links
//         $('.side-link li a').removeClass('active');
//         // Add the active class to the clicked link
//         $(this).addClass('active');
//     });
// });
document.addEventListener('DOMContentLoaded', function() {
    // Retrieve the last active item from localStorage, if available
    const activeLink = localStorage.getItem('activeLink');

    // Get all sidebar items
    const sideLinks = document.querySelectorAll('.side-link-item');

    // If there was a previous active link, set it as active
    if (activeLink) {
        const previousActive = document.querySelector(`.side-link-item[href='${activeLink}']`);
        if (previousActive) {
            previousActive.classList.add('active');
        }
    }

    // Add event listener to each sidebar link
    sideLinks.forEach(link => {
        link.addEventListener('click', function() {
            // Remove 'active' class from all links
            sideLinks.forEach(item => item.classList.remove('active'));

            // Add 'active' class to the clicked link
            this.classList.add('active');

            // Store the clicked link in localStorage
            localStorage.setItem('activeLink', this.getAttribute('href'));
        });
    });
});
