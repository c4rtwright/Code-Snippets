<?php
require_once($CONFIG["absolute_path"] . "/members/session.inc");
require_once($CONFIG["absolute_path"] . "/includes/class.Profile.php");
require_once($CONFIG["absolute_path"] . "/includes/class.buddy_network.php");
require_once($CONFIG["absolute_path"] . "/includes/search_results/class.buddy_results.php");

//*****************************************************************************
// Is buddy system down?
//*****************************************************************************
if (BUDDY_IS_DOWN) {
    $_UI->assign("error_msg", "We're sorry but the buddy system is temporarily unavailable.");
    $_UI->render("pages/profiles/error_msg.tpl");
    exit();
}


//*****************************************************************************
$page_title = "view_buddies";
$mem_id = 0;
if (isset($_REQUEST['mem_id'])) {
    $mem_id = intval($_REQUEST['mem_id']);
}

if (!$mem_id) {
    $mem_id = $_SESSION['session_user_id'];
}


$per_page = 10;
if (!empty($_UI->_SETTINGS["amr2"])) {
    $per_page = 28;
}

//*****************************************************************************
$buddy = new BuddyNetwork($db);
$buddyresults = new BuddyResults($mem_id, $per_page, 3, 120, $buddy);

//*****************************************************************************
if (isset($_SESSION['search_results']) && isset($_SESSION['search_results'][$page_title])) {
    $search_options = $_SESSION['search_results'][$page_title];
} else {
    $search_options =
        array(
            'get_counts'      => 1,
            'show_me'         => 0,
            'looking_for'     => 0,
            'buddy_page_type' => "all_my_buddies", // this page is view buddies
            'selected_page'   => 1,
            'page_num'        => 1,
            'sort_by'         => 0 // 0: Recently Added, 1: Last Login, 2: Display Order
        );
}

$search_options['page_num'] = $search_options['selected_page'];
$page_num = $search_options['page_num'];
$sort_by = $search_options['sort_by'];

//*****************************************************************************
// Get what page they were on and load up to that page
//*****************************************************************************
$selected_page = ordefault($search_options['selected_page'], 1);

$_SESSION['search_results'][$page_title] = $search_options;

$_UI->assign("selected_page", $selected_page);            // This determines what page to load up to
$_UI->assign("per_page", $buddyresults->per_page);   // How many members to show per page
$_UI->assign("page_cache", $buddyresults->page_cache); // How many pages to load in advance with Ajax
$_UI->assign("page_title", $page_title);

if ($mem_id == $_SESSION['session_user_id']) {
    $_UI->assign("total_users_online_text", "buddies in your network");
    $_UI->assign("search_whitebox_title", "My Buddy List");
} else {
    $profile = Profile::get_profile($mem_id);
    $_UI->assign("search_whitebox_title", $db->escape_string($profile->basic_info['username']) . "'s Buddy List");
    $_UI->assign("total_users_online_text", "buddies displayed");
    $_UI->assign("_hide_dashboard", true);
    $_UI->assign("_hide_title_notes", true);
}
//*****************************************************************************
$attempts_allowed = 2;
do {
    $members = $buddyresults->return_members($page_num, $search_options); // search type = all_my_buddies
    _record_debug("Buddy members", $members);

    if ($members == "Out of members." && $page_num != 1) {
        $page_num = 1;
        $search_options['selected_page'] = $page_num;
        $search_options['page_num'] = $page_num;
        $_SESSION['search_results'][$page_title] = $search_options;
        $_UI->assign("selected_page", $selected_page);
        $attempts_allowed--;
    } else {
        $attempts_allowed = 0;
    }
} while ($attempts_allowed > 0);

//*****************************************************************************
$_UI->assign("user_id", $mem_id);
$_UI->assign("ajax_target", "/members/buddy_ajax.php");
$_UI->assign("page_num", $page_num);
$_UI->assign("looking_for", $search_options['looking_for']);
$_UI->assign("show_me", $search_options['show_me']);
$_UI->assign("sort_by", $search_options['sort_by']);
$_UI->assign("members", $members);

$_UI->assign("_logged_in", 1);
$_UI->assign("_hide_total_users_matching", true);
$_UI->assign("_update_total_users_dynamically", true);
$_UI->assign("_hide_require_pic", true);
$_UI->assign("_hide_distance", true);
$_UI->assign("_show_sortby", true);

//*****************************************************************************
$_UI->assign("_page_name", "view_buddies_new");
$_UI->render("content/page.tpl");


//*****************************************************************************
function ordefault($val, $default = null)
{
    return (isset($val) && !empty($val) ? $val : $default);
}
