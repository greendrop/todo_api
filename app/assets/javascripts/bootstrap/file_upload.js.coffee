$(document).on(
  'change',
  '.input-group-file :file',
  ->
    input = $(this)
    label = input.val().replace(/\\/g, '/').replace(/.*\//, '')
    input.trigger('fileselect', [label])
)
  
$(document).on(
  'click',
  '.input-group-file .btn-file',
  ->
    $(this).parents('.input-group').find(':file').click()
)
      
$(document).on(
  'fileselect',
  '.input-group-file :file',
  (event, label) ->
    input = $(this).parents('.input-group').find(':text')
    input.val(label) if input.length
)

