$(document).on('turbolinks:load', function(){
  let words_length = $('.start-btn').data('words-length')
  function layout(index, random_num){
    let answer = $('.answer').eq(index).data("answer")
    if (index < words_length) {
      $('.answer').hide();
      $('.word-test').hide();
      $('.word-test').eq(index).show();
      $('.select-answers').eq(index).children("button").eq(random_num).text(answer);
      $('.select-answers button').show();
      $('.next').hide();
    }else {
      let correct_number = $('.your-answer').children('.correct').length;
      let score = (correct_number/words_length)
      $('.word-test').hide();
      $('.answer').show();
      $('.answer-rate').show();
      $('.answer-rate').prepend(answer_rate(correct_number))
      if (window.location.href.match(/\/word_king/)){
        console.log(score)
        $.ajax({
          url: "success_or_fail",
          type: "GET",
          dataType: 'json',
          data: {
            score: score
          }
        })
      }   
    }
  }

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
  function answer_rate(number){
    html = `<div>
              <p class="answer-rate__message">${words_length}問中${number}問正解</p>
            </div>`

    return html
  }


  if (window.location.href.match(/\/test/)){

    $('.word-test').hide();
    $('.word-detail').hide();
    $('.answer-rate').hide();
    let index = 0;
    let random_num = Math.floor( Math.random()*4);

    $('.start-btn').click(function(){
      $(this).hide();
      layout(index, random_num);
    });
  
    $(document).on('click', '.selector', function(){
      let input = $(this).text();
      let answer = $('.answer').eq(index).data("answer")
      if (input == answer) {
        $('.lower-info').eq(index).append(correctAnswer(answer));
        $('.your-answer').eq(index).append(correctAnswer(input));
      }else {
        $('.lower-info').eq(index).append(incorrectAnswer(answer));
        $('.your-answer').eq(index).append(incorrectAnswer(input));
      }
      $('.select-answers button').hide();
      $('.next').show();
    });
  
    $(document).on('click', '.next', function(){
      index += 1
      random_num = Math.floor( Math.random()*4);
      layout(index, random_num);
    });
  }
});
