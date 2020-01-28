// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("channels")
require("jquery")
require("jquery/test") 
require("jquery/practice") 
require("jquery/tab") 
require("jquery/cardset_new") 
require("jquery/post") 
require("jquery/modal") 
require("jquery/slick") 

require.context('images', true, /\.(png|jpg|jpeg|svg)$/)



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@rails/actiontext").start()
require("@rails/ujs").start()
require("@rails/activestorage").start()
require("trix").start()
require("turbolinks").start()

// import "bootstrap"
import 'slick-carousel'
import 'slick-carousel/slick/slick/';
import 'slick-carousel/slick/slick.scss/';
import 'slick-carousel/slick/slick-theme.scss/';
import '@fortawesome/fontawesome-free/js/all'
import "../stylesheets/application"