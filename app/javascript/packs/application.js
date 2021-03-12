// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "select2";
import { LoginToggle } from '../components/login_form';
import { RegCheck } from '../components/login_form';
// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { loadDynamicBannerText } from '../components/banner';
import { initUpdateNavbarOnScroll } from '../components/navbar';

document.addEventListener('turbolinks:load', () => {

  // Call your functions here, e.g:
  // initSelect2();
  if (document.querySelector('.sign-in')) {
    console.log('sign in found');
    RegCheck();
    LoginToggle();
  }
 if (document.querySelector('.usp')) {
    loadDynamicBannerText();
    initUpdateNavbarOnScroll();
  }
  $('#share_select').select2({
    tags: true
  });
});

$(document).ready(function () {

    $('a[name=creditos]').click(function (e) {
        e.preventDefault();

        var maskHeight = $(document).height();
        var maskWidth = $(window).width();
        var docHeight = $(window).height();

        $('#titles').css({
            'width': maskWidth,
            'height': maskHeight
        });

        $('#titles').fadeIn(200);
        $('#titles').fadeTo();
        $('#titles').fadeIn();
        $('#credits').css("left", (($('#credits').parent().width() - $('#credits').outerWidth()) / 2) + "px");
        $('#credits').css("bottom", "-" + (docHeight * 1.25) + "px");
        $('#credits').show();

        $('#credits').animate({
            bottom: (maskHeight * 1)
        }, {
            duration: 60000,
            complete: function () {
                $('#titles').fadeOut();
                $('.window').fadeOut();
                $('#credits').css("bottom", "-" + (maskHeight * 0.1) + "px");
            },
            step: function (n, t) {
                var pos = $(this).position();
                console.log('X: ' + pos.left.toFixed(2) + ' Y: ' + pos.top.toFixed(2));
            }
        });

    });

    $('.window .close').click(function (e) {
        e.preventDefault();
        $('#credits').css("bottom", "-" + ($(document).height() * 2) + "px");
        $('#titles').hide();
        $('.window').hide();
    });

    $('#titles').click(function () {
        $(this).hide();
        $('#credits').css("bottom", "-" + ($(document).height() * 2) + "px");
        $('.window').hide();
    });
});


