
$(document).on('turbolinks:load', function(){
  $('.mypage-tabs li').on('click',function(e){
    e.preventDefault(); 
    if($(this).not('active')){
      $(this).addClass('active').siblings('li').removeClass('active');
      var index = $(".mypage-tabs li").index(this);
      $(".mypage-content").children('.mypage-item').eq(index).addClass('active').siblings().removeClass('active');
    }
  });


  $('.SetPageModes-group .SetPageModes-buttonWrapper').on('click',function(e){
    if ($(this).hasClass('link') == false){
      e.preventDefault(); 
      if($(this).not('active')){
        $(this).addClass('active').siblings('.SetPageModes-buttonWrapper').removeClass('active');
        var index = $('.SetPageModes-group .SetPageModes-buttonWrapper').index(this);
        $(".cardset-content").children('div').eq(index).addClass('active').siblings().removeClass('active');
      }
    }
  });

}); 