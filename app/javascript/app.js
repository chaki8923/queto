$('turbolinks:render',function(){
  $('h1').css('color',"#333");
  console.log('jqueryは読み込んでる');

  $('.dropdown-toggle').on('click',(e)=>{
    e.preventDefault();

    $('.dropdown-menu').toggle();
  });
  
  $(document).on('click',function(e) {
    if(!$(e.target).closest('.dropdown-toggle').length) {
      $('.dropdown-menu').hide();
    } else {

    }
 });

  
})