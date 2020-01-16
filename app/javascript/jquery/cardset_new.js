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
                                                          <div class="AutoExpandTextarea UITextarea-textarea">
                                                            <div class="AutoExpandTextarea-sizer"></div>
                                                            <div class="AutoExpandTextarea-wrapper">
                                                              <textarea name="cardset[words_attributes][${index}][name]" class="AutoExpandTextarea-textarea"></textarea>
                                                            </div>
                                                          </div>
                                                          <span class="UITextarea-border"></span>
                                                        <span class="UITextarea-label">
                                                          <span>用語</span>
                                                        </span>
                                                        </div>
                                                      </label>
                                                    </div>
                                                  </div>
                                                </div>
                                                <div class="TermContent-side TermContent-side--definition">
                                                  <div class="DefinitionSide">
                                                    <label class="UITextarea">
                                                      <div class="UITextarea-content">
                                                        <div class="AutoExpandTextarea UITextarea-textarea">
                                                          <div class="AutoExpandTextarea-sizer"></div>
                                                          <div class="AutoExpandTextarea-wrapper">
                                                            <textarea name ="cardset[words_attributes][${index}][meaning]" class="AutoExpandTextarea-textarea"></textarea>
                                                          </div>
                                                        </div>
                                                        <span class="UITextarea-border"></span>
                                                      <span class="UITextarea-label">
                                                        <span>定義</span>
                                                      </span>
                                                      </div>
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
    console.log("OK")
  })
});