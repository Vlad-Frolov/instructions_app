 
  $('#upload_widget_opener').cloudinary_upload_widget(
    { cloud_name: 'druq4napx', upload_preset: 'eaj9ogad', 
      cropping: 'server', folder: 'user_photos' },
    function(error, result) { $("#url_up").val(result[0].secure_url) });