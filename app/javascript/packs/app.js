$(function () {

  $('.dropdown-toggle').on('click', (e) => {
    e.preventDefault();

    $('.dropdown-menu').toggle();
  });

  $(document).on('click', function (e) {
    if (!$(e.target).closest('.dropdown-toggle').length) {
      $('.dropdown-menu').hide();
    } 
  });
  
  $('.navbar-toggler').on('click', (e) => {
    $('.navbar-collapse').toggle();
  });
  
  $(document).on('click', function (e) {
    if (!$(e.target).closest('.navbar-toggler').length && !$(e.target).closest('.nav-item').length) {
      $('.navbar-collapse').hide();
    } 
  });


  $('nav li a').each(function () {
    var $href = $(this).attr('href');
    if (location.href.match($href)) {
      $(this).parent().addClass('active');
    } else {
      $(this).parent().removeClass('active');
    }
  });

  $(document).ready('turbolinks:read', function() {
    if(location.pathname != "/") {
        $('.nav li a[href^="/' + location.pathname.split("/")[1] + '"]').addClass('active');
    } else $('.nav li a:eq(0)').addClass('active');
  });

  const msg = window.sessionStorage.getItem(['flash_message']);
  //もしセッションにメッセージがあればスライドダウンさせる
  if(msg !== null){
    // location.reload()
    $('.js-delete-text').html(msg);
    $('.js-delete-message').show();
  //ほんで3秒後にしまってセッション削除
  //セッションの削除はwindow.sessionStorage.removeItem([プロパティ名])
    setTimeout(()=>{
      $('.js-delete-message').fadeOut();
      window.sessionStorage.removeItem(['flash_message']);
    },3000)
  }
  $('.message').val('');



  if($('.js-toggle-msg') && $('.js-toggle-msg').text().length){
    
    $('.js-toggle-msg').show()
    setTimeout(()=>{
      
      $('.js-toggle-msg').fadeOut()
    },3000)

    
  }

  $('.js-reload-btn').on('click',function(){
    $(this).prop("disabled", true);
    $(this).closest('form').submit();
    setTimeout(() => {
      location.reload()
      
    },1000 );
  });


  //自動スクロール
  $('.js-message-submit').on('click',function(){
    $('.js-form-submit').click();
    var obj = document.getElementById('container');

    
  });
  
  $('.js-textarea').keypress(function(e) {
    if(e.which == 13) {
      
    }
  });

  $(".inline").modaal();
  $('.inner-close').on('click',function(){
    $('.inline').modaal('close');
  })

})



