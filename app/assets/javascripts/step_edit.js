var global_counter=  1;
$(document).ready(function(){
  if(document.getElementById("upload_widget_opener")){
    document.getElementById("upload_widget_opener").addEventListener("click", function() {
      cloudinary.openUploadWidget({ cloud_name: 'druq4napx', upload_preset: 'eaj9ogad'},
        function(error, result) { console.log(result[0].secure_url);create_new_image(result[0].secure_url) });
    }, false);
  }
});