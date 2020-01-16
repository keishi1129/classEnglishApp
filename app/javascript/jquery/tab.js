
$(document).on('turbolinks:load', function(){
  $('.mypage-tabs li').on('click',function(e){
    e.preventDefault(); //ページトップへ移動するのを防ぐ
    if($(this).not('active')){
      $(this).addClass('active').siblings('li').removeClass('active');
      var index = $(".mypage-tabs li").index(this);
      $(".mypage-content").children('.mypage-item').eq(index).addClass('active').siblings().removeClass('active');
    }
  });


  $('.SetPageModes-group .SetPageModes-buttonWrapper').on('click',function(e){
    e.preventDefault(); //ページトップへ移動するのを防ぐ
    if($(this).not('active')){
      $(this).addClass('active').siblings('li').removeClass('active');
      var index = $('.SetPageModes-group .SetPageModes-buttonWrapper').index(this);
      $(".cardset-content").children('div').eq(index).addClass('active').siblings().removeClass('active');
    }
  });

}); 