$(document).on('turbolinks:load', function(){

  var init = {
    dots: true,
    infinite: true,
    // adaptiveHeight: true,
    slidesToShow: 1,
    slidesToScroll: 1 };
  
  
  $(function () {
    var win = $(window);
    var slider = $(".mypage-slick");
  
    win.on("load resize", function () {
      if (win.width() < 576) {
        slider.not(".slick-initialized").slick(init);
      } else if (slider.hasClass("slick-initialized")) {
        slider.slick("unslick");
      }
    });
  });
  

})