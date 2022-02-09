// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

require("packs/vendor/jquery-2.2.4.min")
require("packs/vendor/popper.min")
require("packs/vendor/bootstrap.min")
require("packs/jquery.ajaxchimp.min")
require("packs/jquery.nice-select.min")
require("packs/jquery.sticky")
require("packs/nouislider.min")
require("packs/jquery.magnific-popup.min")
require("packs/main")
require("packs/owl.carousel.min")
require("packs/gmaps.min")
// require("packs/countdown")
// require("packs/ion.rangeSlider")
// require("packs/parallax.min")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
global.$ = jQuery;
require("controllers")
global.toastr = require("toastr")
