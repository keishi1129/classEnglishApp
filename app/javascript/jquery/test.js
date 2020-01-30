



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
  },100);
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
    correct_number = $('.your-answer').children('.correct').length;
    $('#timer').addClass('stop').hide();
    $('.word-test').hide();
    $('.answer').show();
    $('.answer-rate').show();
    $('.answer-rate').prepend(answer_rate(words_length, correct_number))  
  }
}

$(document).on('turbolinks:load', function(){

  // if (window.location.href.match(/\/test/)){

    $('.word-test').hide();
    $('.word-detail').hide();
    $('.answer-rate').hide();
    let index = 0;
    random_num = Math.floor( Math.random()*4);

    $('.start-btn').click(function(){
      $('.start-box').hide();
      layout(index, random_num);
    });
  
    $('.select-answers').on('click', '.selector', function(){
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
  
    $('.select-answers').on('click', '.next', function(){
      index += 1
      random_num = Math.floor( Math.random()*4);
      layout(index, random_num);
    });

  // }
  if ($('.start-btn').data('cardset-use') === "テスト用") {
    $('.answer-rate').append(`<div class='report-score'>スコアを報告する</>
                              <div id="modal-main"></div>`)

    $('.answer-rate').on('click', '.report-score', function(){
      words_length = $('.start-btn').data('words-length')
      correct_number = $('.your-answer').children('.correct').length;
      answer_rate = correct_number / words_length 
      if (answer_rate >= 0.8) {
        $("#modal-main").text("合格です。")
        $.ajax({
          type: "GET",
          url: 'word_score',
          data: { score: correct_number},
          dataType: "json"
        })
      }else{
        $("#modal-main").text("不合格です。")
      }
      $("body").append('<div id="modal-bg"></div>');
    //画面中央を計算する関数を実行
      modalResize();
 
    //モーダルウィンドウを表示
      $("#modal-bg,#modal-main").fadeIn("slow");
 
    //画面のどこかをクリックしたらモーダルを閉じる
      $("#modal-bg,#modal-main").click(function(){
        $("#modal-main,#modal-bg").fadeOut("slow",function(){
          //挿入した<div id="modal-bg"></div>を削除
          $('#modal-bg').remove() ;
           $('.report-score').hide();
        });
 
      });
 
    //画面の左上からmodal-mainの横幅・高さを引き、その値を2で割ると画面中央の位置が計算できます
     $(window).resize(modalResize);
      function modalResize(){
 
        var w = $(window).width();
        var h = $(window).height();
        var cw = $("#modal-main").outerWidth();
        var ch = $("#modal-main").outerHeight();

    //取得した値をcssに追加する
        $("#modal-main").css({
            "left": ((w - cw)/2) + "px",
            "top": ((h - ch)/2) + "px"
        });
     }
    
    })
  }

  // $('.score-input').click(function(){
  //   correct_number = $('.your-answer').children('.correct').length;
  //   score = 
  //   $.ajax({
  //     url: "success_or_fail",
  //     type: "GET",
  //     dataType: 'json',
  //     data: {
  //       max: words_length,
  //       score: correct_number 
  //     }
  //   })
  //   .done(function(){
  //     $('.answer-rate').append('<div class="msg">スコアを提出しました！</div>');
  //   })
    
  // })
});
