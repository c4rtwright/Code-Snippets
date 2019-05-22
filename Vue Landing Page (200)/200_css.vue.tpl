{literal}
    <style type="text/css">
        .fade-enter-active, .fade-leave-active {
            transition: opacity .5s;
        }
        .fade-enter, .fade-leave-to {
            opacity: 0;
        }
        .fadeOutUp {
            -webkit-animation-name: fadeOutUp;
            animation-name: fadeOutUp;
            -webkit-animation-duration: .5s;
            animation-duration: .5s;
        }
        .fade {
            -webkit-animation-name: fade;
            animation-name: fade;
            -webkit-animation-duration: .5s;
            animation-duration: .5s;
        }
        .fadeInDown {
            -webkit-animation-name: fadeInDown;
            animation-name: fadeInDown;
            -webkit-animation-duration: .5s;
            animation-duration: .5s;
        }
        .fadeOutDown {
            -webkit-animation-name: fadeOutDown;
            animation-name: fadeOutDown;
            -webkit-animation-duration: .5s;
            animation-duration: .5s;
        }
        body {
            background: url("{/literal}{$_PATH_IMG}{literal}/landing_pages/200/noise.png") repeat scroll center #ececec;
            font-family: 'Open Sans',sans-serif;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .header {
            background: rgb(51,51,51);
            background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzMzMzMzMyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwMDAwMDAiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
            background: -moz-linear-gradient(top, rgba(51,51,51,1) 0%, rgba(0,0,0,1) 100%);
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(51,51,51,1)), color-stop(100%,rgba(0,0,0,1)));
            background: -webkit-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: -o-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: -ms-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: linear-gradient(to bottom, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#333333', endColorstr='#000000',GradientType=0 );
            height: auto;
            padding: 12px 0;
            width: 100%;
        }
        label {
            text-transform: uppercase;
        }
        .logo {
            background: url("{/literal}{$_PATH_IMG}{literal}/landing_pages/logo_57.png") no-repeat scroll center top rgba(0, 0, 0, 0);
            height: 57px;
            width: auto;
        }
        .main {
            height: auto;
            margin: auto;
            padding-bottom: 140px;
            position: relative;
            width: 1024px;
        }
        .main p {
            margin: 0;
        }
        .registrationStatus {
            border-bottom: 1px dotted #ccc;
            color: #f31;
            font-size: 80px;
            font-weight: bold;
            letter-spacing: -4px;
            margin: 30px 0 20px;
            padding-bottom: 20px;
        }
        .timer {
            color: #333;
            font-size: 24px;
            letter-spacing: -1px;
        }
        .cd {
            color: #f31;
        }
        .login {
        }
        .login div {
            display: inline-block;
            margin-right: 2px;
        }
        .login input {
            border: 1px solid #ccc;
            color: #777;
            margin: 0;
            outline: medium none;
            padding: 5px 8px;
        }

        .loginb {
            height: 28px;
            width: 70px;
            cursor: pointer;
            position: relative;
            top: 9px;
        }

        .photoBg {
            background: url("{/literal}{$_PATH_IMG}{literal}/landing_pages/200/{/literal}{$smarty.session.skin.theme}{literal}/girls.jpg") repeat scroll 0 0 rgba(0, 0, 0, 0);
            background-size: contain;
            height: 479px;
            left: 50%;
            margin-left: -549px;
            position: absolute;
            top: 190px;
            width: 1098px;
            z-index: -1;
        }
        .form {
            background: none repeat scroll 0 0 rgba(255, 255, 255, 0.95);
            border-radius: 5px;
            box-shadow: 0 0 40px 0 rgba(0, 0, 0, 0.4), 0 10px 10px -10px rgba(0, 0, 0, 0.7);
            height: 290px;
            margin: 50px auto 20px;
            overflow: hidden;
            position: relative;
            width: 700px;
            z-index: 10;
        }
        .ui-icon{
            float: left;
            margin-right: 3px !important;
        }
        .s1_top {
            background: rgb(51,51,51);
            background: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iIzMzMzMzMyIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiMwMDAwMDAiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
            background: -moz-linear-gradient(top, rgba(51,51,51,1) 0%, rgba(0,0,0,1) 100%);
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,rgba(51,51,51,1)), color-stop(100%,rgba(0,0,0,1)));
            background: -webkit-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: -o-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: -ms-linear-gradient(top, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            background: linear-gradient(to bottom, rgba(51,51,51,1) 0%,rgba(0,0,0,1) 100%);
            filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#333333', endColorstr='#000000',GradientType=0 );
            color: white;
            font-size: 18px;
            margin-bottom: 20px;
            padding: 10px 0;
            width: 100%;
        }
        .step0, .step1, .step2, .step3, .step4, .step5 {
            padding: 20px;
            position: absolute;
            left: 0;
            top: 0;
            width: 93%;
        }
        .step0 {
            margin: 70px auto auto auto;
        }
        .button, .step5 input[type="submit"] {
            border-radius: 5px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.8);
            color: #eee;
            cursor: pointer;
            display: inline-block;
            font-family: 'Open Sans',sans-serif;
            font-size: 28px;
            font-weight: bold;
            height: auto;
            margin: 20px auto;
            padding: 14px 70px;
            position: relative;
            text-align: center;
            width: auto;
        }
        .step_number {
            border-radius: 200px;
            color: white;
            cursor: default;
            float: left;
            font-size: 50px;
            font-weight: bold;
            margin: 36px 20px 36px 40px;
            opacity: 0.4;
            padding: 40px 60px;
            position: relative;
        }
        .form_fields {
            display: inline-block;
            margin: 25px auto auto 20px;
            position: relative;
            text-align: left;
            top: 20px;
            width: 410px;
        }
        .stepb, .step5 input[type="submit"] {
            display: block;
            font-size: 20px;
            margin: 10px auto;
            padding: 8px;
        }
        .step_nav ul {
            cursor: default;
            list-style: none outside none;
            margin: auto;
            padding: 0;
            position: relative;
            text-align: center;
            top: 10px;
        }
        .step_nav ul li {
            background: none repeat scroll 0 0 rgba(0, 0, 0, 0.2);
            border: 1px solid #aaa;
            border-radius: 100px;
            cursor: pointer;
            display: inline-block;
            margin: 0 5px;
            opacity: 0.4;
            padding: 5px 12px;
        }
        .ui-widget {
            margin: 5px 0;
        }
        .ui-state-error {
            padding: 5px 12px;
        }
        .forint{
            display: none !important;
            visibility: hidden !important;
        }
        .active {
            color: white;
            font-weight: bold;
            opacity: 0.8 !important;
        }
        #lqForm_Iam {
            margin: 0;
            padding: 10px;
            width: 410px;
        }

        #lqForm_Email, #lqForm_Username {
            margin: 0;
            padding: 10px;
            width: 384px;
        }
        #lqForm_ComponentCountry, #lqForm_ComponentLocation {
            display: inline-block;
            margin: 0;
            width: 46%;
        }

        #lqForm_Country, #lqForm_Location {
            margin: 0;
            padding: 10px;
        }
        #lqForm_Country,
        #lqForm_Location {
            width: 100%;
        }

        #lqForm_Age select {
            height: auto;
            padding: 10px;
            margin: 10px 0 0;
            width: 133px;
        }
        #lqForm_ComponentTerms {
            text-align: center;
            font-size: 13px;
            width: 418px;
        }
        .terms {
            margin: auto auto 10px auto;
        }

        #lqForm_Agree, #oc_terms {
            position: relative;
            top: -3px;
        }
        .copy {
            color: #999;
            font-size: 12px;
            margin: 10px;
            margin: auto;
        }
        .button:hover {
            box-shadow: 0px 1px 2px rgba(0, 0, 0, 0.8),inset 0px 0px 100px 100px rgba(255, 255,255, 0.1);
        }
        .step_nav ul li:hover {
            opacity: .8;
        }
        .step5 input[type=submit]{
            border: none !important;
            width: 370px !important;
        }
        .compliance {
            color: #999;
            font-size: 12px;
            margin: 5px auto auto auto;
        }

        .form_fields select, .form_fields input[type=text] {
            font-size: 15px !important;
        }

        .footer {
            border-top: 1px dotted #ccc;
            left: 50%;
            margin-bottom: 50px;
            margin-left: -512px;
            padding-top: 20px;
            position: relative;
            width: 1024px;
        }
        .footer ul {
            list-style: none outside none;
            margin: 0;
            padding: 0;
        }
        #lqForm_ComponentTerms{
            margin: 10px 0px;
        }
        .footer ul li {
            border-right: 1px solid #ccc;
            color: #777;
            cursor: pointer;
            display: inline-block;
            font-size: 12px;
            padding: 0 5px;
            transition: all 0.1s ease-in-out 0s;
        }
        a {
            color: #777 !important;
        }
        .forgot {
            color: #aaa;
            cursor: pointer;
            font-size: 11px;
            margin: 5px 0 15px;
            position: relative;
            width: 110px;
        }
        .footer ul li:hover {
            color: #000;
        }
        .footer ul li:last-child {
            border-right: medium none;
        }
        .largeForm {
            height: 375px;
        }
    </style>
{/literal}
