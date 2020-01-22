function wordHtml(word, url){
  if (url === "/find_words_name"){
    html = `<div class="AutosuggestContextItem" data-word-id="${word.id}" data-word-name="${word.name}">
              <div class="Ellipsis">
                ${word.name}
              </div>
            </div>`
  }else{
    html = `<div class="AutosuggestContextItem" data-word-id="${word.id}" data-word-name="${word.meaning}">
              <div class="Ellipsis">
                ${word.meaning}
              </div>
            </div>`
  }

  return html
}  


$(document).on('turbolinks:load', function(){
  let index = 30;
  $(document).scroll(function(){
    var scr_count = $(window).scrollTop(); 
    if (scr_count > 100){
      $('.CreateSetHeader').addClass('is-sticky');
    }else{
      $('.CreateSetHeader').removeClass('is-sticky');
    }
  })

  $('.UITextarea').focus(function(){
    $('.SpecialCharacterTextarea').addClass('is-focused');
  })

  $('.addCards').click(function(e){
    e.preventDefault();
    index = $("#input_cards .TermRows").length 
    $('#input_cards').append(`<div class="TermRows mt-5">
                                <div>
                                  <div class="TermRows-termRowWrap">
                                    <div class="TermRow">
                                      <div class="TermContent">
                                        <div class="TermContent-inner">
                                          <div class="StudiableItemToolbar">
                                            <span class="StudiableItemToolbar-counter"></span>
                                            <div class="StudiableItemToolbar-editableToggles"></div>
                                            <div class="StudiableItemToolbar-actionableToggles">
                                              <span class="ContextToggle">
                                                <button class="UIButton UIButton--borderles" aria-label="このカードを削除" tabindex= -1>
                                                  <span class="UIButton-wrapper">
                                                    <i class="fa fa-trash" aria-label="delete"></i>
                                                  </span>
                                                </button>
                                              </span>
                                            </div>                                         
                                          </div> 
                                          <div class="TermContent-inner">
                                            <div class="TermContent-sides">
                                              <div class="TermContent-sideWrap">
                                                <div class="TermContent-side TermContent-side--word">
                                                  <div class="WordSide">
                                                    <div class="SpecialCharacterTextarea">
                                                      <label class="UITextarea">
                                                        <div class="UITextarea-content">
                                                          <div class="AutoExpandTextarea UITextarea-textarea UITextarea-autoExpandTextarea">
                                                            <div class="AutoExpandTextarea-sizer"></div>
                                                            <div class="AutoExpandTextarea-wrapper">
                                                              <textarea name="cardset[words_attributes][${index}][name]" class="AutoExpandTextarea-textarea"></textarea>
                                                              <input type="checkbox" style="display:none" name="cardset[words_attributes][${index}][_destroy]", value="1"></input>
                                                            </div>
                                                          </div>
                                                          <span class="UITextarea-border"></span>
                                                        </div>
                                                        <span class="UITextarea-label">
                                                          <span>用語</span>
                                                        </span>
                                                      </label>
                                                    </div>
                                                  </div>
                                                </div>
                                                <div class="TermContent-side TermContent-side--definition">
                                                  <div class="DefinitionSide">
                                                    <div class="SpecialCharacterTextarea">
                                                      <label class="UITextarea">
                                                        <div class="UITextarea-content">
                                                          <div class="AutoExpandTextarea UITextarea-textarea UITextarea-autoExpandTextarea">
                                                            <div class="AutoExpandTextarea-sizer"></div>
                                                            <div class="AutoExpandTextarea-wrapper">
                                                              <textarea name ="cardset[words_attributes][${index}][meaning]" class="AutoExpandTextarea-textarea"></textarea>
                                                            </div>
                                                          </div>
                                                          <span class="UITextarea-border"></span>
                                                        </div>
                                                        <span class="UITextarea-label">
                                                          <span>定義</span>
                                                        </span>
                                                      </label>
                                                    </div>
                                                  </div>
                                                </div>
                                              </div>
                                            </div>
                                          </div>
                                        </div>
                                      </div>
                                    </div>
                                  </div>
                                  <div class="TermRowSeparator"></div>
                                </div>
                              </div>`)
   

  })

  $("#input_cards").on('click',"button[area-label=このカードを削除]",function(e){
    e.preventDefault();
    trash_can_parent= $(this).parents(".TermRows")
    trash_index = $("#input_cards .TermRows").index(trash_can_parent) 
    $('input[type="checkbox"]').eq(trash_index).prop('checked', true);
    trash_can_parent.hide();
  })


  $(".AutoExpandTextarea-textarea").focus(function(){
    $(this).parents('.AutoExpandTextarea').addClass('is-focused') 
    if ($(this).parents('.WordSide').length){
      $(this).parents('.WordSide').addClass('is-active')
      $(this).parents('.TermContent').addClass('is-active-word')
    }else{
      $(this).parents('.DefinitionSide').addClass('is-active')
      $(this).parents('.TermContent').addClass('is-active-definition')
    }

  })

  $(".AutoExpandTextarea-textarea").blur(function(){
    $(this).parents('.AutoExpandTextarea').removeClass('is-focused') 
    if ($(this).parents('.WordSide').length){
      $(this).parents('.WordSide').removeClass('is-active')
      $(this).parents('.TermContent').removeClass('is-active-word')
    }else{
      $(this).parents('.DefinitionSide').removeClass('is-active')
      $(this).parents('.TermContent').removeClass('is-active-definition')
    }
  })
  
  $('.UIContainer').on('keyup', ".AutoExpandTextarea.is-focused .AutoExpandTextarea-textarea", function(){
    input = $(this).val();
    $(this).val(input)
    if ($(this).parents('.TermContent').hasClass('is-active-word')){
      url = "/find_words_name"
      search_result = $('.is-active-word').find('.word-result')
    }else{
      url = "/find_words_definition"
      search_result = $('.is-active-definition').find('.definition-result')
    }
    $.ajax({
      type: "GET",
      url: url,
      data: { keyword: input},
      dataType: "json"
    })
    .done(function(words){
      $('.AutosuggestContextItem').remove();
      if (words.length !== 0) {
        words.forEach(function(word){
          search_result.append(wordHtml(word, url));
        });
      }else{
        return false;
      }
    })
    .fail(function(){
      return false;
    })
  });

  
  $(".UIContainer").on('click', '.AutosuggestContextItem', function(){
    wordId = $(this).data('word-id');
    value = $(this).data('word-name');
    textarea = $(this).parents('.TermContent-side').find('.AutoExpandTextarea-textarea')
    index = $('.UIContainer .AutoExpandTextarea-textarea').index(textarea)
    textarea.val(value);
    if($(this).parents('.word-result').length){
      $('.UIContainer .AutoExpandTextarea-textarea').eq(index + 1).focus();
      url = "/find_words_name"
      search_result = $('.is-active-definition').find('.definition-result')
      $.ajax({
        type: "GET",
        url: url,
        data: { keyword: value},
        dataType: "json"
      })
      .done(function(words){
        $(this).parents('.TermContent-side').find('.AutoExpandTextarea-wrapper').append(`<input value="${wordId}" name="cardset[[word_ids][]" type="hidden" />`)
        if (words.length !== 0) {
          words.forEach(function(word){
            search_result.append(wordHtml(word, "/find_words_definition"));
          });
        }else{
          return false;
        }
      })
    }
    $(this).parents('.AutosuggestContext-suggestions').empty();
  });

  // $('.UIContainer').on('change', '.AutoExpandTextarea-textarea', function(){
  //   let value = $(this).val()
  //   if (value === ""){
  //     $(this).parents('.AutoExpandTextarea').removeClass('is-not-empty')
  //   }else{
  //     $(this).parents('.AutoExpandTextarea').addClass('is-not-empty')
  //   }
  // })
  
});