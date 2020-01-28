$(document).on('turbolinks:load', function(){

  var init = {
    dots: true,
    infinite: true,
    // adaptiveHeight: true,
    slidesToShow: 1,
    slidesToScroll: 1 };
  
  
  $(function () {
    var win = $(window);
    var slider = $(".mypage-content");
  
    win.on("load resize", function () {
      if (win.width() < 576) {
        slider.not(".slick-initialized").slick(init);
      } else if (slider.hasClass("slick-initialized")) {
        slider.slick("unslick");
      }
    });
  });
  
  // if($(window).width() <= 750){ 
  //   $('.mypage-content').slick({
  //     // autoplay: true, //自動再生
  //     dots: true, //ドットのナビゲーションを表示
  //     autoplay: true,
  //     adaptiveHeight: true,
  //     arrows: true,
  //     prevArrow:'<div class="prev">PREV</div>',
  //     nextArrow:'<div class="next">NEXT</div>',
  //   })
  // }
  // $('.test-gates').slick({
  //   // autoplay: true, //自動再生
  //   dots: true, //ドットのナビゲーションを表示
  //   autoplay: true,
  //   adaptiveHeight: true,
  //   arrows: true,
  //   prevArrow:'<div class="prev">PREV</div>',
  //   nextArrow:'<div class="next">NEXT</div>'
  // });

  // $('.slider').slick({
  //   // autoplay: true, //自動再生
  //   dots: true, //ドットのナビゲーションを表示
  //   autoplay: true,
  //   adaptiveHeight: true,
  //   arrows: true,
  //   prevArrow:'<div class="prev">PREV</div>',
  //   nextArrow:'<div class="next">NEXT</div>'
  // });

})