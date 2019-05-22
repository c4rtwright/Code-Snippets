{add_script_head_file file="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.13/vue.min.js"}
{add_css_file file="/css/jquery/jquery-ui.css"}
{add_css_file file="/css/font-awesome/css/font-awesome.min.css"}
{add_css_file file="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css"}
{add_css_file file="/css/jquery/jquery-ui.css"}
{add_css_file file="/css/jquery/chosen.css"}
{include file="$_THEME/`$_SETTINGS.color_scheme`/css/200_template_colors.css.tpl"}
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300,700,300italic' rel='stylesheet' type='text/css'>
<div id="app">
    <div class="header">
        <div class="logo"></div>
    </div>
    <div class="main">
        <h1 class="registrationStatus">{$top_text}</h1>
        <div v-if="timeExceeded===true" class="timeUp">
            We let more men in each day. Come back later!
        </div>
        <div v-else class="timer">
            Registration for men will remain open for the next
            {literal}
                <span class="cd"> 00 : {{minutes}} : {{seconds}}</span>
            {/literal}
        </div>
        <p>Attention! This site likely contains sexually explicit photos of someone you know!</p>
        <div class="photoBg"></div>
        <div v-bind:class="{last-step: largeForm}" class="form">
            {include file="$_THEME/components_new/join/liquid/components/base_form.tpl"}
            <transition name="fade" mode="out-in">
                <div class="s1_top" v-if="currentStep == 0"> Before signing up you must agree to the following rules: </div>
            </transition>
            <transition name="fade" enter-active-class="animated fadeIn" leave-active-class="animated fadeOutUp">
                <div class="step0" v-if="currentStep == 0">
                    <div class="rule">
                        If I see pictures of someone I know I will be discreet to protect their privacy.
                        <br />
                        I'll respect the sexual desires of other members.
                    </div>
                    <div v-on:click="gotoNext" class="button buttonColor">I Agree</div>
                </div>
            </transition>
            <transition name="fade" leave-active-class="animated fadeOutUp" enter-active-class="animated fadeIn">
                <div class="step1" v-show="currentStep == 1">
                    <div class="step_number">1</div>
                    <div class="form_fields">
                        <div> I AM A </div>
                        <div>
                            <div class="forint">
                                {include file="$_THEME/components_new/join/liquid/components/base_interested.tpl"}
                                {include file="$_THEME/components_new/join/liquid/components/base_for.tpl"}
                            </div>
                            <select name="{if empty($form_type)}reg_quickjoin{else}{$form_type}{/if}[Iam]" id="lqForm_Iam{if ($id_tag)}_{$id_tag}{/if}">
                                <option data-for_select="2" value="1" {if ($reg_iam == "1" && $reg_interested == "2") }selected {/if}>Man Seeking Woman </option>
                                <option data-for_select="1" value="2" {if ($reg_iam == "2" && $reg_interested == "1") }selected {/if}>Woman Seeking Man </option>
                                <option data-for_select="1" value="11" {if ($reg_iam == "1" && $reg_interested == "1") }selected {/if}>Man Seeking Man </option>
                                <option data-for_select="2" value="22" {if ($reg_iam == "2" && $reg_interested == "2") }selected {/if}>Woman Seeking Woman </option>
                            </select>
                        </div>
                        <next-step v-on:click.native="gotoNext"></next-step>
                    </div>
                </div>
            </transition>
            <transition name="fade" enter-active-class="animated fadeIn" leave-active-class="animated fadeOutUp">
                <div class="step2" v-show="currentStep==2">
                    <div class="step_number">2</div>
                    <div class="form_fields">
                        <div>
                            {include file="$_THEME/components_new/join/liquid/components/base_age.tpl" label="DATE OF BIRTH"}
                        </div>
                        <next-step v-on:click.native="gotoNext"></next-step>
                    </div>
                </div>
            </transition>
            <transition name="fade" enter-active-class="animated fadeIn" leave-active-class="animated fadeOutUp">
                <div class="step3" v-show="currentStep == 3">
                    <div class="step_number">3</div>
                    <div class="form_fields">
                        <div>
                            <img style="display: none;" id="lqForm_LocationIcon{if ($id_tag)}_{$id_tag}{/if}" src="{$_PATH_IMG}/mini_icons/trans.png">
                            {include file="$_THEME/components_new/join/liquid/components/base_country.tpl" label="IN"}
                            {include file="$_THEME/components_new/join/liquid/components/base_location.tpl"}
                            <error v-bind:error-message="app.errorMessage" v-if="errorThrown"></error>
                        </div>
                        <next-step v-on:click.native="gotoNext"></next-step>
                    </div>
                </div>
            </transition>
            <transition name="fade" enter-active-class="animated fadeIn" leave-active-class="animated fadeOutUp">
                <div v-show="currentStep == 4" class="step4">
                    <div class="step_number">4</div>
                    <div class="form_fields">
                        {include file="$_THEME/components_new/join/liquid/components/base_email.tpl" label="Email"}
                        <error v-bind:error-message="app.errorMessage" v-if="errorThrown"></error>
                        <next-step v-on:click.native="gotoNext"></next-step>
                    </div>
                </div>
            </transition>
            <transition name="fade" enter-active-class="animated fadeIn" leave-active-class="animated fadeOutUp">
                <div  v-show="currentStep == 5"class="step5">
                    <div class="step_number">5</div>
                    <div class="form_fields">
                        <div>
                            {include file="$_THEME/components_new/join/liquid/components/base_username.tpl" label="Username"}
                            {include file="$_THEME/components_new/join/liquid/components/base_terms.tpl"}
                        </div>
                        <error v-bind:error-message="app.errorMessage" v-if="errorThrown"></error>
                        <input type="submit" id="lqForm_Submit{if ($id_tag)}_{$id_tag}{/if}" value="Sign Me Up">
                    </div>
                </div>
            </transition>
            {if !empty($lpEmailPrepopValue)}
                <input type="hidden" name="prePopEmail" value="{$lpEmailPrepopValue}">
            {/if}
            </form>
        </div>
    </div>


    <div class="footer">
        <form method="post" action="/login.php">
            <div class="login">
                <div>Login:</div>
                <div><input type='text' class="username" name="login" id="loginField" value="Username"/></div>
                <div><input type='password' name="password" id="passField" class="password" value="Password"/></div>
                <input type="hidden" name="sie" value="{$sie}">
                <div style="position: relative; bottom: 10px;">
                    <input style="color: white; font-size: 11px; font-weight: bold;" value="LOG IN" type='submit' class="loginb">
                </div>
                <a class="forgot" href="/get_pass.php" >Forgot Password?</a>
            </div>
            {if !empty($smarty.get.le)}<div style="color: red;">INVALID USERNAME / PASSWORD</div>{/if}
        </form>
        <div class="copy">Copyright &copy;1999-{$smarty.now|date_format:"%Y"} {$_SETTINGS.site_name} All rights reserved.</div>
        <div class="footer_nav">
            <ul>
                <li><a id="contact" class="link_popup" href="#">Contact Us</a></li>
                {if $show_webmaster_link}<li><a href="{$smarty.session.wm_link.url}" target="_blank">{$smarty.session.wm_link.name}</a></li>{/if}
                <li><a id="privacy" class="link_popup" href="#">Privacy Policy</a></li>
                <li><a id="antispam" class="link_popup" href="#">Anti-Spam</a></li>
                <li><a id="terms" class="link_popup" href="#">Terms</a></li>
                <li><a id="dmca" class="link_popup" href="#">DMCA Notice</a></li>
            </ul>
        </div>
        <a id="notice" href="#" class="link_popup compliance">18 U.S.C. 2257 Record-Keeping Requirements Compliance Statement</a>
    </div>
</div>
{add_script_head_file file="/js/jquery.location_list.js"}
{add_script_head_file file="/js/landing_pages/footerLinks.js"}
{add_script_head_file file="/js/join/renderers/200_renderer.js"}
{add_script_head_file file="/js/join/chosen.jquery.min.js"}
{add_script_head_code}
    {include file="$_THEME/components_new/landing/js/200.js.tpl"}
{/add_script_head_code}
<script src="/js/landing_pages/200/appCode.js"></script>
