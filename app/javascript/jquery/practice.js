


function previousCard(word, index) {
  let html = `<section class="CardsItem previous showing showing-first" id="card-${index}" data-index="${index}">
                <div class="CardsItemSide CardsItemSide--firstSide">
                  <div class="FormattedText notranslate lang-en">
                    <div style="display:block;">${word.name}</div>
                  </div>
                </div>
                <div class="CardsItemSide CardsItemSide--secondSide has-text">
                  <div class="FormattedText notranslate lang-ja">
                    <div style="display:block;">${word.meaning}</div>
                  </div>
                </div>
              </section>`

  return html;
}
function nextCard(word, index) {
  let html = `<section class="CardsItem next showing showing-first" id="card-${index}" data-index="${index}">
                <div class="CardsItemSide CardsItemSide--firstSide has-text">
                  <div class="FormattedText notranslate lang-en">
                    <div style="display:block;">${word.name}</div>
                  </div>
                </div>
                <div class="CardsItemSide CardsItemSide--secondSide has-text">
                  <div class="FormattedText notranslate lang-ja">
                    <div style="display:block;">${word.meaning}</div>
                  </div>
                </div>
              </section>`

  return html;
}


function go(word, required_word_index, direction){
  if (direction === 1){
    $('.previous').remove();
    $('.current').addClass('previous').removeClass('current');
    $('.next').addClass('current').removeClass('next');
    $(".CardsList-container").append(nextCard(word, required_word_index));
  }else if (direction === - 1){
    $('.next').remove();
    $('.current').addClass('next').removeClass('current');
    $('.previous').addClass('current').removeClass('previous');
    $(".CardsList-container").prepend(previousCard(word, required_word_index));
  }else{

  }
}

function go_without_card(direction){
  if (direction === 1){
    $('.previous').remove();
    $('.current').addClass('previous').removeClass('current');
    $('.next').addClass('current').removeClass('next');
  }else{
    $('.next').remove();
    $('.current').addClass('next').removeClass('current');
    $('.previous').addClass('current').removeClass('previous');
  }
}


function btnControl(required_card_index, required_ids){
  index = required_ids.indexOf(required_card_index) + 1
  $('.UIText').text(`${index}/${required_ids.length}`); //表示される数字
  $('button[title="前のカード"]').show();
  $('button[title="次のカード"]').show();
  if (index === 1){
    $('button[title="前のカード"]').hide();
  }else if(index === required_ids.length ){
    $('button[title="次のカード"]').hide();
  }
  
  if(required_ids.length === 1){
    $('.UIText').text('1/1');
    $('button[title="前のカード"]').hide();
    $('button[title="次のカード"]').hide();
  }
}

function word_find(index, direction){
  let required_word_index = index + direction
  let cardset_id = $('.CardsList-container').data('cardset-id')
  $.ajax({
    url: "/word_find",
    type: "GET",
    dataType: 'json',
    data: {
      index: required_word_index,
      cardset_id: cardset_id
    }
  })
  .done(function(word){
    go(word, required_word_index, direction)
  })
  .fail(function(){
    go_without_card(direction)
  })
}

function compareFunc(a, b) {
  return a - b;
}

// ロード開始
$(document).on('turbolinks:load', function(){
  let index = 1
  let maxIndex = $('.progressIndex').data('max-index');
  let required_ids = []
  for(let i=1; i<=maxIndex; i++){
    required_ids.push(i)
  }
  current_card_index = $('.current').data('index')
  btnControl(current_card_index, required_ids);


  $('.SetPageCardsPreview').on('click', '.current', function(){
    if($(this).hasClass('showing-first')){
      $(this).addClass('showing-second').removeClass('showing-first');
    }else{
      $(this).addClass('showing-first').removeClass('showing-second');
    }
  });

  $('.SetPageCardsPreview').on('click', 'button[title="前のカード"]', function(){
    button = $(this);
    direction = -1
    button.prop('disabled', true);
    let auto_move = function(){
      if ($.inArray(index - 1, required_ids) === - 1){ //前のカードの番目(index + 1)が表示されたいカード番号の配列に入っていないとき実行
        index -= 1
        word_find(index, direction);
        setTimeout(auto_move, 50);
      }else{
        index -= 1
        word_find(index, direction);
      }
      required_card_index = $('.current').data('index') - 1
      btnControl(required_card_index, required_ids);
      button.prop('disabled', false);
    } 
    auto_move()
    setTimeout(function(){
      button.prop('disabled', false);
    }, 4000, button)
  })

  $('.SetPageCardsPreview').on('click', 'button[title="次のカード"]', function(){
    button = $(this);
    direction = 1
    button.prop('disabled', true);
    let auto_move = function(){
      if ($.inArray(index + 1, required_ids) === -1){ //次のカードの番目(index + 1)が表示されたいカード番号の配列に入っていないとき実行
        index += 1
        word_find(index, direction);
        setTimeout(auto_move, 50);
      }else{
        index += 1
        word_find(index, direction);
      }
      required_card_index = $('.current').data('index') + 1
      btnControl(required_card_index, required_ids);
      button.prop('disabled', false);
    } 
    auto_move()
    setTimeout(function(){
      button.prop('disabled', false);
    }, 4000, button)
  })


  // カードを覚えた時

  $('.memorized').change(function(){
    let memorized_word_index = $('.memorized').index(this) + 1
    if ($(this).prop('checked')){ //チェックをつけたら実行
      $('.word-list').eq(memorized_word_index - 1).children('.listed-word').css("opacity","0.4");
      required_ids = required_ids.filter((value) => value !== memorized_word_index);
      required_ids.sort(compareFunc);



      // パターンは4種類
      // 1, チェックしたカードが表示されていたとき
      //   1-1, 残りの枚数が０の時(=終了カード表示)
      //   1-2, 残りの枚数が０の時以外
      //     1-2-1, 残ったカードが後にある時(=前に進む)
      //     1-2-1, 残ったカードが後にない時(=後ろに戻る)
      // 2, チェックしたカードが表示されていなかったとき

      if ($(`#card-${memorized_word_index}`).hasClass('current')){           // 1, チェックしたカードが表示されていたとき

        if (required_ids.length === 0){                                      //   1-1, 残りの枚数が０の時(=終了カード表示)

        }else{                                                               //   1-2, 残りの枚数が０の時以外
          if ( memorized_word_index < Math.max.apply(null, required_ids)) {  // 1-2-1, 残ったカードが後にある時(=前に進む)
            direction = 1
            let auto_move = function(){
              if ($.inArray(index + 1, required_ids) === -1){ 
                index += 1
                word_find(index, direction);
                setTimeout(auto_move, 50);
              }else{
                index += 1
                word_find(index, direction);
              }
            } 
            auto_move()
            setTimeout(function(){
              required_card_index = $('.current').data('index')
              btnControl(required_card_index, required_ids);
            },500)
          }else{                                                              //     1-2-1, 残ったカードが後にない時(=後ろに戻る)
            direction = -1
            let auto_move = function(){
              if ($.inArray(index - 1, required_ids) === -1){ 
                index -= 1
                word_find(index, direction);
                setTimeout(auto_move, 50);
              }else{
                index -= 1
                word_find(index, direction);
              }
            } 
            auto_move()
            setTimeout(function(){
              required_card_index = $('.current').data('index')
              btnControl(required_card_index, required_ids);
            },500)
          }                                                             
        }
        

      }else {                                                                  // 2, チェックしたカードが表示されていなかったとき
        required_card_index = $('.current').data('index') 
        btnControl(required_card_index, required_ids);
      }


    }else{                                                                      //チェックを外したら実行
      $('.word-list').eq(memorized_word_index - 1).children('.listed-word').css("opacity","1");
      required_ids.push(memorized_word_index)
      required_ids.sort(compareFunc);
      required_card_index = $('.current').data('index')
      btnControl(required_card_index, required_ids)
    }
  });  
}); 