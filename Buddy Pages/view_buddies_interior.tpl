{literal}
    <style>
        li.router-link-active span {
            border-bottom: 1px solid #1acccc;
            padding-bottom: 4px;
        }
        #app {
            box-sizing: border-box;
            margin: 15px 0 0 0;
        }
        #app hr {
            clear: both;
            display: inline-block;
            width: 300px;
        }
        #app ul {
            list-style-type: none;
        }
        .basic-user,
        .online-cupid {
            background: linear-gradient(45deg, #ffffff 0%,#dbdbdb 26%,#e5e5e5 50%,#f2f2f2 50%,#ffffff 76%,#eee 100%);
            border: 1px solid #ccc;
        }
        .block-list-component > span:first-child {
            display: block;
            margin: 15px auto auto auto;
        }
        .buddy-list-component > div {
            margin: 5px auto auto auto;
        }
        ul.buddies-navigation {
            display: flex;
            justify-content: space-between;
            margin: 14px auto 14px auto;
            padding: 10px;
            width: 80%;
        }
        .buddies-navigation > li {
            cursor: pointer;
            display: inline-block;
        }
        .interaction-buttons {
            background-color: #404445;
            border-left: 1px solid #ccc;
            height: 61%;
            margin: auto 2px auto auto;
            position: absolute;
            right: 0;
            text-align: center;
            top: 27px;
            width: 32px;
            z-index: 0;
        }
        .interaction-buttons > div {
            margin: 5px auto auto auto;
        }

        /* route transition styles */
        .fade-enter-active, .fade-leave-active {
            transition-property: opacity;
            transition-duration: .25s;
        }
        .fade-enter-active {
            transition-delay: .25s;
        }
        .fade-enter, .fade-leave-active {
            opacity: 0
        }
        .page-description {
            margin: 14px 5px -4px 10px;
        }
        .profile-user-info {
            font-size: 11px;
            font-weight: bold;
            padding: 3px 0 0 5px;
            text-align: center;
        }
        #paging_div {
            background: #FDFFE9;
            border: 1px solid #E2E2E2;
            border-radius: 5px;
            margin: -10px 10px 10px;
            padding: 0;
            position: relative;
        }
        #paging_div_center {
            margin: 0;
            padding: 5px;
            position: relative;
        }
        #paging_div_center ul {
            display: flex;
            height: 20px;
            justify-content: center;
            position: relative;
            top: 1px;
        }
        .profile-container {
            padding: 3px;
            width: 100%;
        }
        .profile-cell {
            background: linear-gradient(to bottom, #ffffff 0%,#f3f3f3 100%);
            border: 1px solid #d6d6d6;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            display: inline-block;
            height: 163px;
            margin: 8px 5px 10px 8px;
            position: relative;
            width: 137px;
        }
        .profile-image {
            height: 100px;
            margin: auto auto auto 3px;
            width: 100px;
        }
        .profile-type-banner {
            font: bold 12px/18px arial, helvetica, sans-serif;
            height: 18px;
            width: 135px;
            margin: 0 0 0 0;
            padding: 3px 0 3px 0;
            text-align: center;
            color: #5e5e5e;
            text-shadow: 0px 1px 0px white;
            z-index: 1;
            border: 1px solid #ccc;
            position: relative;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/nprogress/0.2.0/nprogress.css">

    <!-- Vue Stuff -->
    <script src="https://unpkg.com/vue/dist/vue.js"></script>
    <script src="https://unpkg.com/vue-router/dist/vue-router.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/nprogress/0.2.0/nprogress.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.17.1/axios.js"></script>
{/literal}
<p class="page-description">
    Four Vue Routes for each separate page in the 'Buddies' sub-menu.
</p>
<div id="app">
    <ul class="buddies-navigation">
        <router-link tag="li" to="/" exact>
            <span>View Buddies</span>
        </router-link>
        <router-link tag="li" to="/new-buddy-requests" :event="['mousedown', 'touchstart']" >
            <span>New Requests</span>
        </router-link>
        <router-link tag="li" to="/pending-buddy-requests" :event="['mousedown', 'touchstart']" >
            <span>My Requests</span>
        </router-link>
        <router-link tag="li" to="/block-list" >
            <span>My Block List</span>
        </router-link>
    </ul>
    <div id="paging_div" style="display: none;"><div id="paging_div_center"></div></div>
    <router-view></router-view>
</div>
{literal}
<script>
    var mailbox_img_path   = '{/literal}{$_PATH_IMG}{literal}/amr2/who/mail_on.gif';
    var chat_img_path      = '{/literal}{$_PATH_IMG}{literal}/amr2/who/chat_on.gif';
    var add_buddy_img_path = '{/literal}{$_PATH_IMG}{literal}/amr2/who/add_buddy_on.gif';
    var sms_img_path       = '{/literal}{$_PATH_IMG}{literal}/amr2/text2date/text_icon.png';

    /***
     * fetchBuddyData() -- this function does double-duty: it fires off the AJAX requests to obtain profile data
     * for a given route, then builds out the first and subsequent pages
     */
    function fetchBuddyData(ajaxPath, userID, cellsPerPage, pageToLoad, pageTitle) {
        var pageContainer = jQuery(`<div class='results_page' id='page_number_${pageToLoad}'></div>`);
        var numberOfMembers = 0;

        axios.get(ajaxPath, {
            params: {
                user_id: userID,
                per_page: cellsPerPage,
                load_page: pageToLoad,
                page_title: pageTitle

            }
        }).then(function(response) {
            NProgress.done();
            var buddyData = response.data;
            numberOfMembers = buddyData.length;

            if (response.data === "Out of members.") {
                // Decrement the page number we're loading so we don't have an empty page in the pagination div.
                console.log("Final member count: " + numberOfMembers);
                pageToLoad--;
                return;
            } else {
                for (i = 0; i < buddyData.length; i++) {
                    let profileTypeLabel = buddyData[i].cupid_type = "nc" ? "Online Cupid" : "Nonce";
                    let profileUsername = truncate(buddyData[i].login);
                    let profileCell =
                        `
                        <div class='profile-cell'>
                             <div class='profile-type-banner online-cupid'>${profileTypeLabel}</div>
                             <div class='interaction-buttons'>
                                <div><a><img src='${mailbox_img_path}' /></a></div>
                                <div><a><img src='${chat_img_path}' /></a></div>
                                <div><a><img src='${add_buddy_img_path}' /></a></div>
                                <div><a><img src='${sms_img_path}' /></a></div>
                             </div>
                             <div class='profile-image'>
                             <a href="${buddyData[i].profile_link}">
                                 <img src='http://www.aaanimalcontrol.com/Professional-Trapper/images/birdcanadagoose.jpg' />
                             </a>
                             </div>
                             <div class='profile-user-info'>
                                <div>
                                    <a class="whosonlineUsername">${profileUsername}</a>, <span class='profile-user-age'>${buddyData[i].age}</span>
                                </div>
                                <div style="padding-top: 3px; font-size: 11px;">
                                    <span>${buddyData[i].city}${buddyData[i].state}</span>
                                </div>
                             </div>
                        </div>
                    `;
                    jQuery(profileCell).appendTo(pageContainer);
                }
                jQuery(pageContainer).appendTo(".profile-container");

                // Create the pagination object
                let objPagingDiv = jQuery('#paging_div_center');

                objPagingDiv.pagination({
                    pages: pageToLoad,
                    cssStyle: '',
                    hrefTextPrefix: 'javascript:void(0);//',
                    prevText: '<img src="{/literal}{$_PATH_IMG}/{$_SETTINGS.color_scheme}{literal}/amr2/gallery_paginate_left.gif" width="20" height="22" style="vertical-align: bottom;">',
                    nextText: '<img src="{/literal}{$_PATH_IMG}/{$_SETTINGS.color_scheme}{literal}/amr2/gallery_paginate_right.gif" width="20" height="22" style="vertical-align: bottom;">',
                    onPageClick: // Attach the click handler
                        function(pageNumber, event) {
                            jQuery(".results_page").hide();
                            jQuery('#page_number_'+pageNumber).show();
                        }
                });
                // Show the pagination element if we've been able to fetch more than one page
                if (pageToLoad > 1) {
                    jQuery(pageContainer).hide();
                    jQuery('#paging_div, #paging_div_center').show();
                }

                numberOfMembers += numberOfMembers;

                // Increment the page to load and run the function again.
                pageToLoad++;
                fetchBuddyData(ajaxPath, userID, cellsPerPage, pageToLoad, pageTitle)
            }
        });
    }

    // truncate(text) -- chop off a certain amount of characters from the given text to ensure uniform length
    // text *string -- text to be truncated
    function truncate(text){
        let len = 11;

        let trunc = text;

        if(text !== null ) {
            let len = 11;
            if (trunc.length > len) {
                trunc = trunc.substring(0, len);
                trunc = trunc.replace('/\w+$/', '');
            }
        }
        return trunc;
    }

    const viewMyBuddies = {
        template:
            `
                <div class='buddy-list-component'>
                    <div>
                        <span> My Buddy List. </span>
                    </div>
                    <div>
                        <span>Number of buddies: {{numberOfMembers}}</span>
                    </div>
                    <div class='my-buddies'>
                        <div class='profile-container'></div>
                    </div>
                </div>
                `,
        data: function() {
            return {
                numberOfMembers: 666,
                currentPage: 1,
                fetchPage: 1,
            }
        },
        beforeRouteEnter: function(to, from, next) {
            next(function(vm) {
                // Fire up the progress bar.
                NProgress.configure({ parent: "#app"});
                NProgress.start();
                next();

                let routeBuddyData = fetchBuddyData(
                    '/members/buddy_ajax.php',
                    {/literal}{$user_id}{literal},
                    28,
                    vm.currentPage,
                    "view_buddies"
                );
            })
        },
        beforeRouteLeave (to, from, next) {
            // Delete pagination element to be rebuilt on the next route.
            jQuery("#paging_div").hide();

            next();
        }
    };
    const newRequests = {
        template:
            `
                <div class='new-requests-component'>
                    <span> Approve or Deny buddy requests.</span>
                    <div class='my-buddy-requests'>
                        <div class='profile-container'></div>
                    </div>
                </div>
                `,
        data: function() {
            return {
                blockedAge: undefined,
                blockedStatus: undefined,
                blockedUsers: [],
                blockedUsername: undefined,
                currentPage: 1
            }
        },
        beforeRouteEnter: function(to, from, next) {
            next(function(vm) {
                // Fire up the progress bar.
                NProgress.configure({ parent: "#app"});
                NProgress.start();
                next();

                fetchBuddyData(
                    '/members/buddy_ajax.php',
                    {/literal}{$user_id}{literal},
                    28,
                    vm.currentPage,
                    "approve_buddies"
                );
            })
        },
        beforeRouteLeave (to, from, next) {
            // Hide the pagination container before leaving the route.
            jQuery("#paging_div").hide();

            next();
        }
    };
    const pendingRequests = {
        template:
            `
            <div class='block-list-component'>
                <div>
                    <span> Here's your pending buddy requests. </span>
                </div>
                <div class='blocked-users'>
                    <div class='profile-container'></div>
                </div>
            </div>
            `,

        data: function() {
            return {
                blockedAge: undefined,
                blockedStatus: undefined,
                blockedUsers: [],
                blockedUsername: undefined,
                currentPage: 1
            }
        },
        beforeRouteEnter: function(to, from, next) {
            next(function(vm) {
                // Fire up the progress bar.
                NProgress.configure({ parent: "#app"});
                NProgress.start();
                next();

                fetchBuddyData(
                    '/members/buddy_ajax.php',
                    {/literal}{$user_id}{literal},
                    28,
                    vm.currentPage,
                    "pending_buddies"
                );
            })
        },
        beforeRouteLeave (to, from, next) {
            // Delete pagination element to be rebuilt on the next route.
            jQuery("#paging_div").hide();

            next();
        }
    };
    // Draw X '.profile-cell' where X == numOfProfiles
    const blockList = {
        template:
            `
                <div class='block-list-component'>
                    <div>
                        <span> Here's your blocklist. </span>
                    </div>
                    <div>
                        <span>Number of buddies: {{numberOfBuddies}}</span>
                    </div>
                    <div class='blocked-users'>
                        <div class='profile-container'></div>
                    </div>
                </div>
            `,
        data: function() {
            return {
                blockedUsers: [],
                blockedUsername: undefined,
                blockedAge: undefined,
                blockedStatus: undefined,
                currentPage: 1
            }
        },
        beforeRouteEnter: function(to, from, next) {
            next(function(vm) {
                let routeBuddyData = fetchBuddyData(
                    '/members/buddy_ajax.php',
                    {/literal}{$user_id}{literal},
                    28,
                    vm.currentPage,
                    "blocklist"
                );
            })
        }
    };

    const router = new VueRouter({
        routes: [
            {
                path: '/',
                component: viewMyBuddies
            },
            {
                path: '/new-buddy-requests',
                component: newRequests
            },
            {
                path: '/pending-buddy-requests',
                component: pendingRequests
            },
            {
                path: '/block-list',
                component: blockList,
            },
        ]
    });

    Vue.use(VueRouter);

    new Vue({
        el: '#app',
        router: router
    });
</script>
{/literal}
