$('.document').ready(function () {
    $(".checkbox_user").attr("checked", false)
    $("#trash").attr("disabled", true);
    $("#lock").attr("disabled", true);
    $("#unlock").attr("disabled", true);
    $("#mkadmin").attr("disabled", true);
    ["#trash","#lock","#unlock","#mkadmin"].forEach((value) => {
    let jqObj = $(value); 
    let href = jqObj.attr('href'); 
    jqObj.on('click', (event) => { 
    let newHref = href + '?' 
    $('.checkbox_user').each(function () { 
    if ($(this).prop('checked') == true) { 
    newHref += 'user_check%5B%5D=' + $(this).val() + '&' 
    } 
    }); 
    jqObj.attr('href', newHref) 
    }); 
    })

    $('#checkBoxAll').click(function () {
        if ($(this).is(":checked"))
            $('.checkbox_user').prop('checked', true);
        else
            $('.checkbox_user').prop('checked', false);
    });


    $('.checkbox_user').on('click', function () {
        var count = $('#checkbox_user:checked').length;

        $("#goodsLenght").text(count);
        if (count == 0) {
            $("#trash").attr("disabled", true);
            $("#lock").attr("disabled", true);
            $("#unlock").attr("disabled", true);
            $("#mkadmin").attr("disabled",true);
        }
        else {
            $("#trash").attr("disabled", false);
            $("#lock").attr("disabled", false);
            $("#unlock").attr("disabled", false);
            $("#mkadmin").attr("disabled",false);
        }


    });


    
});