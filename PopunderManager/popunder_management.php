<?php
$__rootadminNoHTML = true;
require "rootadmin.inc";
require_once($CONFIG["absolute_path"] . "/includes/class.Popunder.php");
require_once("classes/class.ThemeAdmin.php");

$_UI->assign("_no_prototype", true);

switch ($_GET['popunderAction']) {
    case 'addNewPopunder':
        if (empty($_GET['addPopunderData']) || empty($_GET['popunderType'])) {
            echo false;
            exit();
        }

        $addNewPopunderData = json_decode($_GET['addPopunderData']);
        $isMobile = $_GET['popunderSiteType'] == 'mobile' ? true : false;
        try {
            Popunder::add_popunder($addNewPopunderData->popunderName, $addNewPopunderData->popunderUrl, $addNewPopunderData->popunderNotes);

            if (!empty($addNewPopunderData->enableForAllThemes) && isset($addNewPopunderData->enableForAllThemes)) {
                $defaultStartDate    = strtotime(date('Y-m-d'));
                $defaultEndDate      = strtotime(date('Y-m-d', strtotime('+1 year')));

                $popunderThemes = getThemes();

                foreach ($popunderThemes as $k => $v) {
                    if (!empty($isMobile) && isset($isMobile)) {
                        $themeId = themeIdToMobileSiteId($v['theme_id']);
                    } else {
                        $themeId = $v['theme_id'];
                    }

                    Popunder::del($themeId, $addNewPopunderData->popunderName, true, true, $addNewPopunderData->popunderType, $isMobile);
                    Popunder::add($themeId, $addNewPopunderData->popunderName, $addNewPopunderData->popunderWeight, $defaultStartDate, $defaultEndDate, $addNewPopunderData->popunderType, $isMobile);
                }
            }
        } catch (Exception $e) {
            $response = array(
                "error" => true,
                "status" => "There was a problem creating this popunder, please try again."
            );
            echo json_encode($response);
            exit();
        }
        $response = array(
            "error" => false,
            "status" => "New popunder added successfully"
        );
        echo json_encode($response);
        exit();
        break;

    case 'addPopunderToThemes':
        if (empty($_GET['popunderData']) || !isset($_GET['popunderData']) ) {
            $response = array(
                "error" => true,
                "status" => "Popunder data not set"
            );
            echo false;
            exit();
        }

        $popunderData = json_decode($_GET['popunderData']);
        $isMobile = $_GET['popunderSiteType'] == 'mobile' ? true : false;

        if (!empty($popunderData->activateForAllThemes) && isset($popunderData->activateForAllThemes)) {
            $popunderThemes = getThemes();

            foreach ($popunderThemes as $k => $v) {
                if (isset($isMobile) && !empty($isMobile)) {
                    $themeId = themeIdToMobileSiteId($v['theme_id']);
                } else {
                    $themeId = $v['theme_id'];
                }

                $defaultStartDate    = strtotime(date('Y-m-d'));
                $defaultEndDate      = strtotime(date('Y-m-d', strtotime('+1 year')));
                $defaultWeight       = 10;
                $defaultPopunderType = 'show_popunder';

                try {
                    Popunder::del($themeId, $popunderData->popunderName, true, true, $popunderData->popunderType, $isMobile);
                    Popunder::add($themeId, $popunderData->popunderName, $defaultWeight, $defaultStartDate, $defaultEndDate, $popunderData->popunderType, $isMobile);
                } catch (Exception $e) {
                    $response = array(
                        "error" => true,
                        "status" => "There was a problem adding the popunder to themes, please try again"
                    );
                    echo json_encode($response);
                    break;
                }
            }
            $response = array(
                "error" => false,
                "status" => "Successfully added popunder to the chosen themes"
            );

            echo json_encode($response);
            exit();
            break;
        }

        foreach ($popunderData as $k => $v) {
            if (isset($isMobile) && !empty($isMobile)) {
                $themeId = themeIdToMobileSiteId($k);
            } else {
                $themeId = $k;
            }

            try {
                if (empty($v->startDate) || !isset($v->startDate)) {
                    $v->startDate = strtotime(date('Y-m-d'));
                } else {
                    $v->startDate = strtotime("{$v->startDate}");
                }
                if (empty($v->endDate) || !isset($v->endDate)) {
                    $v->endDate = strtotime(date('Y-m-d', strtotime('+1 year')));
                } else {
                    $v->endDate = strtotime("{$v->endDate}");
                }
                Popunder::del($themeId, $v->popunderName, true, true, $v->popunderType, $isMobile);
                Popunder::add($themeId, $v->popunderName, $v->popunderWeight, $v->startDate, $v->endDate, $v->popunderType, $isMobile);
            } catch (Exception $e) {
                $response = array(
                    "error" => true,
                    "status" => "There was a problem adding the popunder to themes, please try again"
                );
                echo json_encode($response);
                exit();
                break;
            }
        }
        $response = array(
            "error" => false,
            "status" => "Successfully added popunder to the chosen themes"
        );
        echo json_encode($response);
        exit();
        break;

    case 'fetchThemes':
        $popunderDataByTheme = Popunder::getPopundersByTheme($_GET['popunderName'], $_GET['popunderType'], $_GET['popunderSiteType']);
        if (!empty($popunderDataByTheme) && isset($popunderDataByTheme)) {
            echo json_encode($popunderDataByTheme);
        } else {
            echo false;
        }
        exit();
        break;

    case 'getPopunderInfo':
        $popunderName = $_GET['popunderName'];
        if (empty($popunderName) || !isset($popunderName)) {
            echo false;
            exit();
            break;
        }
        $popunderInfo = Popunder::getPopunder($popunderName);
        echo json_encode($popunderInfo);
        exit();
        break;

    case 'handleSubmittedPopunderData':
        $popunderDates = array();
        $popunderData = json_decode($_GET['submittedPopunderData']);
        $isMobile = $_GET['popunderSiteType'] == 'mobile' ? true: false;

        if (!empty($popunderData->disableEnableAllThemes) && isset($popunderData->disableEnableAllThemes)) {
            $popunderThemes = getThemes();
            foreach ($popunderThemes as $k => $v) {
                if (!empty($isMobile) && isset($isMobile)) {
                    $themeId = themeIdToMobileSiteId($v['theme_id']);
                } else {
                    $themeId = $v['theme_id'];
                }

                try {
                    Popunder::del($themeId, $popunderData->popunderName, true, true, $popunderData->popunderType, $isMobile);
                } catch (Exception $e) {
                    $response = array(
                        "error" => true,
                        "status" => "There was a problem adding the popunder to themes, please try again"
                    );
                    echo json_encode($response);
                    break;
                }
            }
            $response = array(
                "error" => false,
                "status" => "Popunder data successfully updated"
            );
            echo json_encode($response);
            exit();
            break;
        }

        if (!empty($popunderData) && isset($popunderData)) {
            foreach($popunderData as $k => $v) {
                if ($v->keepPopunder === false) {
                    $popunderDates = explode("-", $v->popunderDates);
                    try {
                        Popunder::del($v->themeId, $_GET['popunderName'], true, true, $_GET['popunderType'], $isMobile);
                    } catch (Exception $e) {
                        $response = array(
                            "error" => true,
                            "status" => "There was a problem removing this popunder, please try again."
                        );
                        echo json_encode($response);
                        exit();
                    }
                }
            }
        }
        $response = array(
            "error" => false,
            "status" => "Popunder data successfully updated"
        );
        echo json_encode($response);
        exit();
        break;
}


$popUnders = Popunder::get_popunders(1, true);
// Get active popunders (active == theres at least one row set for this popunder in theme settings)
$activePopunders = array();
foreach ($popUnders as $k => $v) {
    $popunderIsActive = checkActive($k);
    if (isset($popunderIsActive) && !empty($popunderIsActive)) {
        $activePopunders[$k] = true;
    };
}
$listingData        = initListingData(true, true);
$popunders_active   = Popunder::get_popunders_archived(0, true);
$popunders_archived = Popunder::get_popunders_archived(1, true);

$_UI->assign("pop_name_filter", $listingData['pop_name_filter']);
$_UI->assign("popunders", $popUnders);
$_UI->assign("activePopunders", $activePopunders);
$_UI->assign("by_site_historical", $listingData['popunderInfo']);

$sitesByTheme = $listingData['sitesByTheme'];

//Only add to the themes to show in Add site the ones not already assigned ot popunders
$_UI->assign("popunders_active", $popunders_active);
$_UI->assign("popunders_archived", $popunders_archived);
$_UI->assign("themes", getThemes());
$_UI->assign('page_title', 'Pop-Under Manager');
$_UI->assign('_page_name', 'popunder_management');
$_UI->render('rootadmin/ui/page.tpl');

function checkActive($popunder = '') {
    global $db;

    $checkActiveDesktop = "SELECT 
            *
        FROM
            theme_settings
        WHERE
            (setting_name = 'show_popunder'
                OR setting_name = 'show_login_popunder')
                AND setting_value LIKE '%{$popunder}%'
        LIMIT 1";

    $activeForDesktop = $db->query($checkActiveDesktop, 1, 0, 0);

    $checkActiveMobile = "
        SELECT 
            *
        FROM
            mobile.site_settings
        WHERE
            (setting = 'show_popunder'
                OR setting = 'show_login_popunder')
                AND value LIKE '%{$popunder}%'
        LIMIT 1";

    $activeForMobile = $db->query($checkActiveMobile, 1, 0, 0);

    if (empty($activeForDesktop) || !isset($activeForDesktop)) {
        if (empty($activeForMobile) || !isset($activeForMobile)) {
            return false;
        }
    }

    return true;

}

/**
 * Process the actions submitted through the management form
 */
function actionSubmitted(){
    global $_UI;
    $_TA = new ThemeAdmin();
    $actionResult = "<h1>Invalid Action</h1>";
    switch($_POST['action']) {
        //Update site popunder (ajax)
        case "update":
            $is_mobile = (int)$_POST['is_mobile'];
            $theme_id = (int)$_POST['theme_id'];
            $pop_name = $_POST['pop_name'];
            $weight = (int)$_POST['weight'];
            $start = empty($_POST['start']) ? null : strtotime($_POST['start']);
            $end = empty($_POST['end']) ? null : strtotime($_POST['end']);
            $new_pop = $_POST['new_pop'];
            $new_start = empty($_POST['new_start']) ? null : strtotime($_POST['new_start']);
            $new_end = empty($_POST['new_end']) ? null : strtotime($_POST['new_end']);
            $type = $_POST['type'];
            try{
                if (empty($theme_id)){
                    throw new Exception("strange 'theme' parameter");
                }
                if (empty($weight)){
                    throw new Exception("strange 'weight' parameter");
                }
                Popunder::del($theme_id,$pop_name,$start,$end, $type, $is_mobile);
                Popunder::add($theme_id,$new_pop,$weight,$new_start,$new_end, $type, $is_mobile);
                $_TA->recache_theme_settings($theme_id);
                $status = 'ok';
                $result = 'update successful';
            } catch (Exception $exc) {
                $status = 'error';
                $result = $exc->getMessage();
            }
            $actionResult =
                json_encode(
                    array(
                        'status' => $status,
                        'result' => $result,
                    )
                );
            break;
        default:
            break;
    }
    return $actionResult;
}

function getThemes() {
    global $db;

    $themeSql =
        "SELECT 
            ts1.theme_id, ts1.setting_value AS site_name
         FROM
            theme_settings ts1
                INNER JOIN
            theme_settings ts2 ON ts1.theme_id = ts2.theme_id
                AND ts2.setting_name = 'deniro_product'
         WHERE
            ts1.setting_name = 'site_name'
                AND ts2.setting_value
         ORDER BY ts1.setting_value ASC";

    $themeRes = $db->query($themeSql, 1, 0, 0);

    if (!empty($themeRes) && isset($themeRes)) {
        return $themeRes;
    } else {
        return false;
    }
}

/**
 * Get a random number for the index part of site_item_index
 * See libs/templates/default/popunder_management.tpl -> applySubmittedData
 * for explanation of site_item_index which is taken from the theme and an index
 * @return int
 */
function getRandomSiteItemIndex(){
    return mt_rand(100000, 1000000);
};

/**
 * Initialize data used in the popunder listings
 * @param bool $popunderInfo True generates popunderInfo array
 * @param bool $sitesByTheme True generates sitesByTheme array
 * @return array In the form:
 *  array('sitesByTheme' => return of Popunder::getSitesFromThemeSettings | false,
 *          Sites already present in the popunderInfo array will not be returned here
 *        'popunderInfo' => return of Popunder::getPopunderInfo | false
 *        'pop_name_filter' => If filtering using the popunder name is active (=='' if its not)
 *  )
 */
function initListingData($popunderInfo=true, $sitesByTheme=false){
    $pop_name_filter=$_POST['pop_name_filter'];
    $sitesByThemeRes = $sitesByTheme;

    if ($popunderInfo) {
        $popunderInfo = Popunder::getPopunderInfo(true);
        if($pop_name_filter != ''){
            $popunderInfo = Popunder::getPopunderInfoIncPopunderName($popunderInfo, $pop_name_filter);
        }
    }

    if ($sitesByTheme) {
        $sitesByTheme = Popunder::getSitesFromThemeSettings();
        $sitesByThemeRes =
            array(
                -1 =>
                    array(
                        array(
                            'popunder_site_key' => -1,
                            'popunder_site_name' => 'Select Site',
                            'is_mobile' => 0
                        ),
                    ),
            );
        if(!$popunderInfo){
            $sitesByThemeRes +=  $sitesByTheme;
        } else{
            //If popunderinfo, do not return the sites already associated with popups
            //for use with the add site selector
            $popunderSiteKeys = array();
            //Get all the defined site keys
            foreach($popunderInfo as $theme_id => $popunderInfoItem){
                foreach($popunderInfoItem as $popunderInfoItemSite){
                    $popunderSiteKeys[ $popunderInfoItemSite['popunder_site_key'] ] = 0;
                }
            }

            $siteKeysInserted = array();
            //Remove the already existing site keys
            foreach($sitesByTheme as $theme_id => $siteByTheme){
                foreach($siteByTheme as $index => $siteInfo){
                    if( !array_key_exists($siteInfo['popunder_site_key'], $popunderSiteKeys) &&
                        !array_key_exists($siteInfo['popunder_site_key'], $siteKeysInserted)  ){
                        $sitesByThemeRes[$theme_id][] = $siteInfo;
                        $siteKeysInserted[ $siteInfo['popunder_site_key'] ] = 0;
                    }
                }
            }
        }
    }
    return
        array(
            'sitesByTheme' => $sitesByThemeRes,
            'popunderInfo' => $popunderInfo,
            'pop_name_filter' => $pop_name_filter
        );
}
function themeIdToMobileSiteId($themeId = false) {
    global $db;

    $sql = "
    SELECT 
        ms.site_id
    FROM
        am.theme_settings ts
            INNER JOIN
        am.theme_info ti ON ti.theme_id = ts.theme_id
            INNER JOIN
        mobile.sites ms ON ms.affiliate_id = ti.aff_id
    WHERE
        ti.theme_id = '{$themeId}'
    ";

    $res = $db->query($sql, 1, 0, 0);

    if (empty($res) || !isset($res)) {
        return false;
    } else {
        return $res[0]['site_id'];
    }
}