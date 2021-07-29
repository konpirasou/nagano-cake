// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage

//= require jquery.raty.js
//= require chartkick
//= require Chart.bundle
//= require_tree .

/*global $*/

$(function() {
  $(".slick").slick({
    arrows: false,
    dots: true,
    autoplay: true,
    autoplaySpeed: 2000,
    speed: 1500,
    fade: true,
    pauseOnFocus: false,
    pauseOnHover: false,
    pauseOnDotsHover: false,
    swipe: true,
  });
});

$('head').append(
'<style>body{display:none;}'  //body {display:none;}を指定して要素を隠す
);
$(window).on("load", function() {
$('body').delay(600).fadeIn("slow");
});

