$(document).on('turbolinks:load', function(){
  $('.search-btn').click(function(){
    $('.chatroom-form--select').show();
    $('.chatroom-form--add').hide();
  })

  $('.add-btn').click(function(){
    $('.chatroom-form--select').hide();
    $('.chatroom-form--add').show();
  })

  // $('.new_chatroom').on('submit', function(e){
  //   e.preventDefault();
  //   var formData = new FormData(this);
  //   var url = $(this).attr('action');
  //   console.log(url)
  //   $.ajax({
  //     url: url,
  //     type: "POST",
  //     data: formData,
  //     dataType: 'json',
  //     processData: false,
  //     contentType: false
  //   })
  //   .done(function(chatroom) {
  //     console.log(chatroom)
  //   })
  //   .fail(function() {
  //   });
  // }) 
})