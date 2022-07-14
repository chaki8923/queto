$(function () {
  $('h1').css('color', "#333");
  console.log('jqueryは読み込んでる');

  $('.dropdown-toggle').on('click', (e) => {
    e.preventDefault();

    $('.dropdown-menu').toggle();
  });

  $(document).on('click', function (e) {
    if (!$(e.target).closest('.dropdown-toggle').length) {
      $('.dropdown-menu').hide();
    } else {

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
console.log('ターーーボリンクス無効化にしたいいいいい');
  $(document).ready('turbolinks:read', function() {
    if(location.pathname != "/") {
        $('.nav li a[href^="/' + location.pathname.split("/")[1] + '"]').addClass('active');
    } else $('.nav li a:eq(0)').addClass('active');
  });
})


