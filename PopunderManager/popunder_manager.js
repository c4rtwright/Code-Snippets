var vm = new Vue({
    el: "#popunderManager",
    data: {
        activateForAllThemes: false,
        addPopunderData: {
            enableForAllThemes: false,
            popunderName: '',
            popunderNotes: '',
            popunderUrl: '',
            popunderWeight: 10
        },
        currentPanel: 'manage',
        deactivateAll: false,
        defaultWeight: 10,
        disableEnableAllThemes: false,
        editPopunderDate: false,
        errorMsg: '',
        popunderActionResult: false,
        popunderCheckboxes: false,
        popunderData: false,
        popunderInfo: {
            popunderName: '',
            popunderNotes: '',
            popunderUrl: ''
        },
        popunderEndDate: false,
        popunderStartDate: false,
        popunderSiteType: 'desktop',
        popunderType: 'show_popunder',
        selectedPopunder: false,
        submittedPopunderData: {},
        successMsg: ''
    },
    methods: {
        activateAll() {
            // Checking the box == checking all the theme checkboxes
            // Unchecking the box ==  disable all the theme checkboxes

            let selectAll = document.querySelector(".activateAll input[type=checkbox]:checked");
            let currentThemes = document.querySelectorAll('.theme-cell input[type=checkbox]');

            if (selectAll !== null) {
                vm.activateForAllThemes = true;
                for (let i = 0; i < currentThemes.length; i++) {
                    currentThemes[i].setAttribute('checked', true);
                }
            } else {
                vm.activateForAllThemes = false;
                for (let i = 0; i < currentThemes.length; i++) {
                    currentThemes[i].removeAttribute('checked');
                }
            }
        },
        addNewPopunder() {
            vm.errorMsg = '';
            vm.successMsg = '';
            vm.addPopunderData.popunderType = vm.popunderType;

            if (vm.addPopunderData.popunderName == '') {
                vm.errorMsg = "Enter a popunder name";
                return;
            }
            if (vm.addPopunderData.popunderUrl == '') {
                vm.errorMsg = "Enter a URL for this popunder";
                return;
            }

            if (vm.popunderType == '') {
                vm.errorMsg = "Popunder type not set";
                return;
            }

            axios.get('popunder_management.php', {
                params: {
                    popunderAction: 'addNewPopunder',
                    addPopunderData: vm.addPopunderData,
                    popunderType: vm.popunderType,
                    popunderSiteType: vm.popunderSiteType
                }
            }).then(function(response) {
                if (response.data.error === false) {
                    vm.successMsg = response.data.status
                } else {
                    vm.errorMsg = response.data.status
                }
                if (response.data === false) {
                    vm.errorMsg = "There was a problem submitting the popunder data. Please try again";
                }
            })
        },
        addPopunderToThemes() {
            vm.errorMsg = '';
            vm.successMsg = '';

            let popunderData = {};
            let popunderThemes = $(".popunder-add-themes .theme-cell input[type=checkbox]").toArray();

            if (vm.selectedPopunder === false) {
                vm.errorMsg = "A popunder must be selected.";
                return;
            }

            if (vm.activateForAllThemes === true) {
                let popunderData = {
                    activateForAllThemes: true,
                    popunderName: vm.selectedPopunder,
                    popunderSiteType: vm.popunderSiteType,
                    popunderType: vm.popunderType
                };

                axios.get('popunder_management.php', {
                    params: {
                        popunderAction: 'addPopunderToThemes',
                        popunderData: JSON.stringify(popunderData),
                    }
                }).then(function(response) {
                    if (response.data.error == false) {
                        vm.successMsg = response.data.status;
                    } else {
                        vm.errorMsg = response.data.status;
                    }
                    if (response.data == false) {
                        vm.errorMsg = "There was a problem submitting the popunder data. Please try again";
                    }
                });

                return;
            }

            popunderThemes.forEach(function(element, index) {
                let themeId = $(element).data("themeid");
                let addTheme = $(element).is(":checked");

                if (addTheme === true) {

                    let popunderWeight = $(`.popunder-add-themes .theme-cell #weight-${themeId}`).val();

                    popunderData[themeId] = {
                        popunderName: vm.selectedPopunder,
                        popunderType: vm.popunderType,
                        popunderWeight: popunderWeight
                    };
                }
            });

            axios.get('popunder_management.php', {
                params: {
                    popunderAction: 'addPopunderToThemes',
                    popunderSiteType: vm.popunderSiteType,
                    popunderData: JSON.stringify(popunderData),
                }
            }).then(function(response) {
                if (response.data.error === false) {
                    vm.successMsg = response.data.status;
                } else {
                    vm.errorMsg = response.data.status;
                }
                if (response.data === false) {
                    vm.errorMsg = "There was a problem with this request. Please try again";
                }
            });
        },
        changeActivePanel(panelName) {
            vm.errorMsg = '';
            vm.successMsg = '';
            vm.currentPanel = panelName;
        },
        disableEnableAll() {
            // Checking the box == unchecking all checkboxes for current themes
            // Unchecking the box ==  re-checking all checkboxes for current themes

            let selectAll = document.querySelector(".disableEnableAll input[type=checkbox]:checked");
            let currentThemes = document.querySelectorAll('.popunder-themes .isActiveForTheme');

            if (selectAll !== null) {

                for (let i = 0; i < currentThemes.length; i++) {
                    currentThemes[i].removeAttribute('checked');
                }
            } else {
                for (let i = 0; i < currentThemes.length; i++) {
                    currentThemes[i].setAttribute('checked', true);
                }
            }
        },
        displayPopunderStatus() {
            // Reset the popunder data property before making the call
            vm.popunderData = false;

            vm.errorMsg = '';
            vm.successMsg = '';

            axios.get('popunder_management.php', {
                params: {
                    popunderAction: 'getPopunderInfo',
                    popunderName: vm.selectedPopunder
                }
            }).then(function(response) {
                vm.popunderInfo.popunderName = response.data.popunder_name;
                vm.popunderInfo.popunderUrl = response.data.url;
                if (response.data.notes === '') {
                    response.data.notes = "<no notes>"
                }
                vm.popunderInfo.popunderNotes = response.data.notes;
                
                // Bind returned data to addNewPopunder object
                vm.addPopunderData.popunderName = vm.popunderInfo.popunderName;
                vm.addPopunderData.popunderUrl = vm.popunderInfo.popunderUrl;
                vm.addPopunderData.popunderNotes = vm.popunderInfo.popunderNotes;
            });

            axios.get('popunder_management.php', {
                params: {
                    popunderAction: 'fetchThemes',
                    popunderName: vm.selectedPopunder,
                    popunderType: vm.popunderType,
                    popunderSiteType: vm.popunderSiteType
                }
            }).then(function(response) {
                vm.errorMsg = '';

                if (response.data) {
                    vm.popunderData = response.data;
                } else {
                    vm.errorMsg = "No data found for the given popunder and type";
                }
            });
        },
        submitPopunderData() {

            if (vm.disableEnableAllThemes === true) {
                let popunderData = {
                    disableEnableAllThemes: true,
                    popunderName: vm.selectedPopunder,
                    popunderType: vm.popunderType
                };

                axios.get('popunder_management.php', {
                    params: {
                        popunderAction: 'handleSubmittedPopunderData',
                        popunderType: vm.popunderType,
                        popunderSiteType: vm.popunderSiteType,
                        submittedPopunderData: JSON.stringify(popunderData),
                    }
                }).then(function(response) {
                    if (response.data.error == false) {
                        vm.successMsg = response.data.status;
                    } else {
                        vm.errorMsg = response.data.status;
                    }
                    if (response.data == false) {
                        vm.errorMsg = "There was a problem submitting the popunder data. Please try again";
                    }
                });

                return;
            }

            // clear array before resubmitting
            vm.submittedPopunderData = {};

            $("#sites input[type=checkbox]").toArray().forEach(function(element, index) {
                vm.submittedPopunderData[index] = {
                    keepPopunder: $(element).is(":checked"),
                    themeId: $(element).data("themeid"),
                    popunderDates: `${$(element).data("starttime")}-${$(element).data("endtime")}`
                }
            });

            axios.get('popunder_management.php', {
                params: {
                    popunderAction: 'handleSubmittedPopunderData',
                    popunderName: vm.selectedPopunder,
                    popunderType: vm.popunderType,
                    popunderSiteType: vm.popunderSiteType,
                    submittedPopunderData: vm.submittedPopunderData
                }
            }).then(function(response) {
                if (response.data.error == false) {
                    vm.successMsg = response.data.status;
                } else {
                    vm.errorMsg = response.data.status;
                }
                if (response.data == false) {
                    vm.errorMsg = "There was a problem submitting the popunder data. Please try again";
                }
            });
        }
    }
})