$(function() {
  var $add = $('div.add-note'),
      $addButton = $add.find('.add-button'),
      $addForm = $add.find('form.note-form'),
      $cancel = $addForm.find('.cancel'),
      $submit = $addForm.find('.submit'),
      $notes = $('section.notes'),
      $template = $('.template');

  $addButton.click(function(event) {
    event.preventDefault();
    $addForm.fadeIn();
    $addButton.toggleClass('disabled');
  });

  $submit.click(function(event) {
    event.preventDefault();
    $addButton.toggleClass('disabled');
    var data = $addForm.serialize();
    $.ajax({
      url: '/notes',
      type: 'POST',
      dataType: 'json',
      data: data,
      success: function(data) {
        $addForm.fadeOut();
        $addButton.toggleClass('disabled');
        renderNote(data);
      }
    });
  });

  $cancel.click(function(event) {
    event.preventDefault();
    $addForm.slideUp();
    $addButton.toggleClass('disabled');
  });

  var renderNote = function(data) {
    var $newNote = $template.clone().removeClass('template');
    for (var key in data) {
      $newNote.find('.note-' + key).html(data[key]);
    }
    $newNote.addClass('highlighted');
    $notes.prepend($newNote);
  };
});
