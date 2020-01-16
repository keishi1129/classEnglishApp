$(document).on('turbolinks:load', function(){


  $('.post-btn').on("change", "#csv-input", function(){
    value = $(this).prop('files')[0];
    if (value === undefined){
      $('#import-btn').prop("disabled", true)
    }else{
      $('#import-btn').prop("disabled", false)
    }
  })

})