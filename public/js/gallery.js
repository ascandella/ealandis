$(function() {
  var $gallery = $('#gallery'),
      $controls = $('#galleryControls'),
      $play = $controls.find('.play');

  $.ajax({
    url: '/images.json',
    dataType: 'json',
    type: 'GET'
  }).done(function(images) {
    $gallery.galleria({
      autoplay: 7000,
      dataSource: images
    });
  }).fail(function() {
    $gallery.append($("<h1>Error retrieving image data</h1>"));
  });
    

  $play.click(function(event) {
    event.preventDefault();
    $gallery.data('galleria').playToggle();
  });
});
