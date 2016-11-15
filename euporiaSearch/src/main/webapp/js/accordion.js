/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/*START*/
var target;
var xhttp = new XMLHttpRequest();

function check(obj) {
    $(obj).val(obj.checked ? 1 : 0);
}

/*STOP*/

jQuery(document).ready(function () {
    function close_accordion_section() {
        jQuery('.accordion .accordion-section-title').removeClass('active');
        jQuery('.accordion .accordion-section-content').slideUp(300).removeClass('open');
    }

    jQuery('.accordion-section-title').click(function (e) {
// Grab current anchor value
        var currentAttrValue = jQuery(this).attr('href');
        if (jQuery(e.target).is('.active')) {
            close_accordion_section();
        } else {
            close_accordion_section();
            // Add active class to section title
            jQuery(this).addClass('active');
            // Open up the hidden content panel
            jQuery('.accordion ' + currentAttrValue).slideDown(300).addClass('open');
        }

        e.preventDefault();
    });
});

