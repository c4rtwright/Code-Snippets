{literal}
    var renderer = new Renderer();

    jQuery('#liquid_form').formValidation( {
        emailVerifyServiceKey : smartyVar_emailVerifyService_key,
        location_altLocationlabel: 'location_label',
        ErrorRenderer: {
            displayError: function(field, message) {
                app.errorMessage = message;
                app.errorThrown = true;
                console.log("Hello, teenaged america!!")
            },
            clearError: function(field) {
                app.errorThrown = false;
                console.log("Can you govern your soul?")
            }
        }
    });
{/literal}
{if !empty($smarty.session.registration.validation)}
    jQuery('#liquid_form').formValidation( 'handleRegData', {$smarty.session.registration.validation|@json_encode} );
{/if}
{literal}
$(function(){
    jQuery('.form').keypress(function(e){
        if (e.keyCode == '13'){
            e.preventDefault();
        }
    });

    $(".nav_step1, .nav_step2, .nav_step3, .nav_step4, .nav_step5").on("click", function(){
        var step = $(this).index()+1;
        // If they are going back to fix something, skip the validate on the current page at this time.
        if( step >= renderer.current_step && ! renderer.validatePage(renderer.current_step) ){
            return;
        }

        renderer.gotoPage(step);
    });

    // Login field values
    $('.username').focus(function() {
        if(this.value == 'Username'){
            this.value = '';
        }
    });

    $('.username').blur(function(){
        if(this.value == ''){
            this.value = 'Username';
        }
    });

    $('.password').focus(function(){
        if(this.value == 'Password'){
            this.value = '';
        }
    });

    $('.password').blur(function() {
        if(this.value == '') {
            this.value = 'Password';
        }
    });

    // Iam - Interested Calculation
    $("#liquid_form").on("submit", function(){
        cur_select_iam = $("#lqForm_Iam option:selected").val(); // get selected "iam" val

        switch(cur_select_iam) {
            case "1":
                // man for woman, switch the val to '1' at this point and switch the interest to '2'
                $("#lqForm_Iam option:selected").attr('value', '1');
                $("#lqForm_Interested option:eq(1)").attr('selected', true);
                break;
            case "2":
                // woman for man, switch the val to '2' at this point and switch the interest to '1'
                $("#lqForm_Iam option:selected").attr('value', '2');
                $("#lqForm_Interested option:eq(0)").attr('selected', true);
                break;
            case "11":
                // man for man, switch the val to '1' at this point and switch the int val to '1'
                $("#lqForm_Interested option:eq(0)").attr('selected', true);
                $("#lqForm_Iam option:selected").attr('value', '1');
                break;
            case "22":
                // woman for woman, switch the val to '2' at this point and switch the int val to '2'
                $("#lqForm_Interested option:eq(1)").attr('selected', true);
                $("#lqForm_Iam option:selected").attr('value', '2');
                break;
        }
    });
});
{/literal}
{if !empty($emailPassedError)}
    renderer.displayError('Email', '{$emailPassedError}', true);
{/if}
