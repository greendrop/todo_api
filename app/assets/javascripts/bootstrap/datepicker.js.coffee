$(->
  $('.date_picker').datetimepicker({
    format: 'YYYY-MM-DD',
    locale: 'ja'
  })

  $('.datetime_picker').datetimepicker({
    format: 'YYYY-MM-DD HH:mm',
    locale: 'ja'
  })

  $('.month_picker').datetimepicker({
    format:       'YYYY-MM',
    locale:       'ja',
    viewMode:     'months',
    minViewMode:  'months'
  })
)

