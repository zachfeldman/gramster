$(function(){

var mySlideBar = new $.slidebars();

      $('.fa').on('click', function() {
        mySlideBar.toggle('right');
      });
});