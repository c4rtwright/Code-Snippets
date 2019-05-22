function Renderer(skipEmailStep = false) {
    this.current_step = 0;
    this.skipEmailStep = skipEmailStep;
    this.fieldPages =
        {
            Iam: 1,
            Age_M: 2,
            Age_D: 2,
            Age_Y: 2,
            Age: 2,
            Country: 3,
            Location: 3,
            Email: 4,
            Username: 5,
            Terms: 5
        };
    this.pageFields =
        {
            1: ['Iam',],
            2: ['Age', 'Age_Y', 'Age_M', 'Age_D'],
            3: ['Country', 'Location'],
            4: ['Email'],
            5: ['Username', 'Terms']
        };
    this.savePage = null;
    this.savePageTimer = null;
}
Renderer.prototype = {
    gotoSavedPage:
        function() {
            this.gotoPage(this.savePage);
            this.savePageTimer = null;
            this.savePage = null;
        },

    validatePage: function(step) {
        console.log("validatePage() called");
        var validPage = true;
        if (step in this.pageFields) {
            for (let i = 0; i < this.pageFields[step].length; i++) {
                validPage = validPage &&
                    jQuery("#liquid_form").formValidation(
                        'checkField', this.pageFields[step][i], true
                    );
            }
        }
        return validPage;
    },

    triggerEmailVerify:
        function(email, key, skipEmailStep) {
            if (skipEmailStep == true) {
                this.skipEmailStep = true;
            }
            jQuery.ajax({
                url: "/includes/ajax_emailverifyservice.php",
                data: {
                    email: email,
                    key: key,
                    extended_status: true
                },
                type: "POST",
                dataType: 'json',
                success: function( data ){
                    // if email isnt valid, clear the field
                    if (data.status !== 'valid') {
                        jQuery('#lqForm_Email').attr('value', '');
                    }
                }
            });
        },

    emailVerifyDone:
        function(isSuccess) {
            if( isSuccess ){
                this.gotoPage(5);
            }
        }
};
