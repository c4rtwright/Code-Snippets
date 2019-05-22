<link rel="stylesheet" href="/css/popunderManager/style.css">
<div id="popunderManager" class="popunder-management-container white_panel">
    <div id="active_popunders">
        <div class="popunder-menu">
            <ul class="menu">
                {literal}
                    <li class="menu-item" v-on:click="changeActivePanel('add')" v-bind:class="{active: currentPanel == 'add'}">Add New Popunder</li>
                    <li class="menu-item" v-on:click="changeActivePanel('manage')" v-bind:class="{active: currentPanel == 'manage'}">Manage Active Popunders</li>
                    <li class="menu-item" v-on:click="changeActivePanel('add-to-theme')" v-bind:class="{active: currentPanel == 'add-to-theme'}">Add Popunder To Theme</li>
                {/literal}
            </ul>
            <div class="popunder-type">
                <div class="toggle-popunder-type">
                    <span>Toggle Popunder Type</span>
                    <input type="radio" name="popunder_type" value="show_popunder" v-model="popunderType" checked>
                    <label>Landing Page Popunder</label>

                    <input type="radio" name="popunder_type" value="show_login_popunder" v-model="popunderType">
                    <label>Login Popunder</label>
                </div>

                <div class="toggle-site-type">
                    <span>Toggle Site Type</span>
                    <input type="radio" name="popunder_site_type" value="desktop" v-model="popunderSiteType" checked>
                    <label>Desktop</label>

                    <input type="radio" name="popunder_site_type" value="mobile" v-model="popunderSiteType">
                    <label>Mobile</label>
                </div>
            </div>
            <div class="popunder-info">
                {literal}
                <div class="popunder-name">
                    <span>Popunder: {{popunderInfo.popunderName}}</span>
                </div>
                <div class="popunder-url">
                    <span>URL: {{popunderInfo.popunderUrl}}</span>
                </div>
                <div class="popunder-notes">
                    <span>Notes: {{popunderInfo.popunderNotes}}</span>
                </div>
                {/literal}
            </div>
        </div>
        <div class="add-popunder-panel" v-if="currentPanel == 'add'">
            <div class="add-popunder">
                <div class="add-popunder-form">
                    <div class="popunder-type">
                        {literal}
                            <div class="error" v-if="errorMsg !== ''">
                                {{errorMsg}}
                            </div>
                            <div class="success" v-if="successMsg !== ''">
                                {{successMsg}}
                            </div>
                            <div class="add-popunder-fields">
                                <input type="checkbox" v-model="addPopunderData.enableForAllThemes">
                                Enable for all themes

                                <label>Name</label>
                                <input type="text" placeholder="e.g.: Perkiss Stream Desktop 17" v-model="addPopunderData.popunderName">
                                <label>URL</label>
                                <input type="text" placeholder="https://example.com" v-bind:value="popunderInfo.popunderUrl" v-model="addPopunderData.popunderUrl">
                                <label>Notes</label>
                                <input type="text" placeholder="e.g.: This is a popunder note" v-bind:value="popunderInfo.popunderNotes" v-model="addPopunderData.popunderNotes">
                                <label>Weight String</label>
                                <input type="number" placeholder="e.g.: 10" min="1" max="100" v-model="addPopunderData.popunderWeight">
                            </div>
                            <div v-on:click="addNewPopunder" class="submitButton addPopunderSubmit" id="addNewPopunder">
                                Submit
                            </div>
                        {/literal}
                    </div>
                </div>
            </div>
        </div>
        <div class="manage-panel" v-if="currentPanel == 'manage'">
            <div class="active-popunders">
                <label>Active Popunders</label>
                <select v-model="selectedPopunder" class='popunders'>
                    {foreach from=$activePopunders key="popunder_name" item="pop_row" name=popundersAvailable}
                        <option name="{$popunder_name}">
                            {$popunder_name}
                        </option>
                    {/foreach}
                </select>
                <div v-on:click="displayPopunderStatus" class="submitButton displayStatusSubmit">
                    Display Status
                </div>
            </div>
            <div class="all-popunders">
                <label>All Popunders</label>
                <select v-model="selectedPopunder" class='popunders'>
                    {foreach from=$popunders key="popunder_name" item="pop_row" name=popundersAvailable}
                        <option name="{$popunder_name}">
                            {$popunder_name}
                        </option>
                    {/foreach}
                </select>
                <div v-on:click="displayPopunderStatus" class="submitButton displayStatusSubmit">
                    Display Status
                </div>
            </div>
            <div id="sites" class="sites add_site">
                {literal}
                    <label v-if="popunderData" class="currently-active-label">Currently active for the following themes: </label>
                    <div v-if="popunderData" class="disableEnableAll">
                        <input type="checkbox" v-on:change="disableEnableAll" v-model="disableEnableAllThemes">
                        Disable / Enable for all current themes
                    </div>
                    <div v-if="errorMsg !== ''"class="error">
                        {{errorMsg}}
                    </div>
                    <div v-if="successMsg !==''" class="success">
                        {{successMsg}}
                    </div>
                {/literal}
                <div class="popunder-themes">
                    <div v-for="item in popunderData">
                        {literal}
                            <span class="theme-name">{{item.name}}</span>
                            <input type="checkbox" class="isActiveForTheme" v-bind:data-starttime="item.startTimestamp" v-bind:data-endtime="item.endTimestamp" v-bind:id="item.name" v-bind:data-themeid="item.theme_id" checked>
                            <div class="popunder-weight"> Weight: {{item.weight}}</div>
                        {/literal}
                        <div v-for="popunder in popunderData.popunder_data">
                            <div class="popunder-theme">
                                {literal}
                                    {{popunder}}
                                {/literal}
                            </div>
                        </div>
                    </div>
                    <div v-if="popunderData" v-on:click="submitPopunderData" class="submitButton" id="submitPopunderData">
                        Submit
                    </div>
                </div>
            </div>
        </div>
        <div class="add-theme-panel" v-if="currentPanel == 'add-to-theme'">
            <div class="all-popunders">
                <label class="description-label">Select a theme(s) that should be associated with the selected popunder</label>
                <div class="active-popunders">
                    <label>Active Popunders</label>
                    <select v-model="selectedPopunder" class='popunders'>
                        {foreach from=$activePopunders key="popunder_name" item="pop_row" name=popundersAvailable}
                            <option name="{$popunder_name}">
                                {$popunder_name}
                            </option>
                        {/foreach}
                    </select>
                </div>
                <div class="all-popunders">
                    <label>All Popunders</label>
                    <select v-model="selectedPopunder" class='popunders'>
                        {foreach from=$popunders key="popunder_name" item="pop_row" name=popundersAvailable}
                            <option name="{$popunder_name}">
                                {$popunder_name}
                            </option>
                        {/foreach}
                    </select>
                </div>
                <div v-if="selectedPopunder" class="activateAll">
                    <input type="checkbox" v-on:change="activateAll">
                    Activate for all themes
                </div>
                {literal}
                    <div v-if="errorMsg !== ''" class="error">
                        {{errorMsg}}
                    </div>
                    <div v-if="successMsg !==''" class="success">
                        {{successMsg}}
                    </div>
                {/literal}
                <div class="popunder-add-themes">
                    {foreach from=$themes key='theme' item='themeRes' name=allThemes}
                        <div class="theme-cell">
                            <span>{$themeRes.site_name}</span>
                            <input type="checkbox" value="1" name="addPopunderToTheme" data-themeName="{$themeRes.site_name}" data-themeid="{$themeRes.theme_id}">
                            <input type="number" placeholder="e.g.: 10" min="10" max="100" id="weight-{$themeRes.theme_id}">
                        </div>
                    {/foreach}
                    <div v-on:click="addPopunderToThemes" class="submitButton addPopunderSubmit" id="addPopunderToThemes">
                        Submit
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.16/vue.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.18.0/axios.min.js"></script>
<script src="popunder_management.js"