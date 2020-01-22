
function incorrectAnswer(answer){
  html = `<p class="word-meaning incorrect">
            × ${answer}
          </p>`

  return html
}
function correctAnswer(answer){
  html = `<p class="word-meaning correct">
            ◯ ${answer}
          </p>`

  return html
}
function answer_rate(words_length, number){
  html = `<div>
            <p class="answer-rate__message">${words_length}問中${number}問正解</p>
          </div>`

  return html
}

function countDown(index, answer){
  cnt = 5.00;
  $('#timer').text(cnt)
  cnDown = setInterval(function(){ //1秒おきにカウントマイナス
    cnt -= 0.1
    if(cnt <= 0.1){//0になったら停止する
      clearInterval(cnDown);
      $('#timer').text("Time Up");
      $('.lower-info').eq(index).append(incorrectAnswer(answer));
      $('.your-answer').eq(index).text('Time up')
      $('.select-answers button').hide();
      $('.next').show();
    }
    if($('#timer').hasClass('stop')){
      clearInterval(cnDown);
    }
    $('#timer').text(cnt.toFixed(1));
  },10);
}

function layout(index, random_num){
  if($('#timer').hasClass('stop')){
    $('#timer').removeClass('stop')
  }
  let words_length = $('.start-btn').data('words-length')
  answer = $('.answer').eq(index).data("answer")
  if (index < words_length) {
    $('.answer').hide();
    $('.word-test').hide();
    $('.word-test').eq(index).show();
    $('.select-answers').eq(index).children("button").eq(random_num).text(answer);
    $('.select-answers button').show();
    $('.next').hide();
    countDown(index, answer);
  }else {
    let correct_number = $('.your-answer').children('.correct').length;
    $('#timer').addClass('stop').hide();
    $('.word-test').hide();
    $('.answer').show();
    $('.answer-rate').show();
    $('.answer-rate').prepend(answer_rate(words_length, correct_number))  
  }
}

$(document).on('turbolinks:load', function(){

  if (window.location.href.match(/\/test/)){

    $('.word-test').hide();
    $('.word-detail').hide();
    $('.answer-rate').hide();
    let index = 0;
    random_num = Math.floor( Math.random()*4);

    $('.start-btn').click(function(){
      $(this).hide();
      layout(index, random_num);
    });
  
    $(document).on('click', '.selector', function(){
      let input = $(this).text();
      answer = $('.answer').eq(index).data("answer")
      $('#timer').addClass('stop')
      if (input == answer) {
        $('.lower-info').eq(index).append(correctAnswer(answer));
        $('.your-answer').eq(index).append(correctAnswer(input));
      }else {
        $('.lower-info').eq(index).append(incorrectAnswer(answer));
        $('.your-answer').eq(index).append(incorrectAnswer(input));
      }
      $('.select-answers button').hide();
      setTimeout(function(){
        $('.next').show();  
      }, 1000)
    });
  
    $(document).on('click', '.next', function(){
      index += 1
      random_num = Math.floor( Math.random()*4);
      layout(index, random_num);
    });
  }

  $('.score-input').click(function(){
    words_length = $('.start-btn').data('words-length')
    correct_number = $('.your-answer').children('.correct').length;
    score = 
    $.ajax({
      url: "success_or_fail",
      type: "GET",
      dataType: 'json',
      data: {
        max: words_length,
        score: correct_number 
      }
    })
    .done(function(){
      $('.answer-rate').append('<div class="msg">スコアを提出しました！</div>');
    })
    
  })
});
