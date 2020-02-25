$(document).on('turbolinks:load', function(){

  let messagesHtml = $(".messages");

  function appendMessage(message){
    
    let content = message.content ? `${ message.content }` : "";
    let img = message.image ? `<img src= ${ message.image }>` : "";
    console.log(message.image)

    var upper_info = `<div class="message" data-message-id="${message.id}">
                          <div class="message__upper-info">
                            <p class="message__upper-info__user-name">${message.name}</p>
                            <p class="message__upper-info__date">${message.date}</p>
                          </div>
                          <p class="message__text">${content}</p>
                          ${img}
                       </div>`
   
                        
    messagesHtml.append(upper_info)
    
  }

  function scrollBottom(){
    $('.messages').animate({
      scrollTop: $('.messages')[0].scrollHeight
    }, 'slow');
  }


$('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    // clickFlag = false;
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      if (message.id !== null){
        console.log(message)
        appendMessage(message);
        $("#message_content").val("");
        scrollBottom();
        $("#message_image").val("");
      } else {
        alert('メッセージを入力してください')
      }
    })
    .fail(function(){
      alert('エラー');
    })
    .always(function(){
      $(".submit").prop("disabled", false);
    })
  });
   
  var reloadMessages = setInterval(function() {
    if (window.location.href.match(/\/chatrooms\/\d+\/messages/)){
      last_message_id = $('.message:last').data("message-id");
      $.ajax({
        url: "api/messages",
        type: 'get',
        dataType: 'json',
        data: {id: last_message_id}
      })
      .done(function(messages) {
        messages.forEach(function (message) {
          var insertHtml = appendMessage(message); 
          $('.messages').append(insertHtml);
          $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'slow');
        })
      })
      .fail(function() {
        alert('自動更新に失敗しました');
      });

     } else {
       clearInterval(reloadMessages);
     } 
  } , 5000);
});