<%@ Page Title="Attendance Entry Project" MetaDescription="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="AttendanceEntryProject.aspx.cs" Inherits="Payroll_AttendanceEntryProject" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>
<%@ Register Src="~/Controls/ucEmployeeLeaveBalance.ascx" TagPrefix="uc1" TagName="ucEmployeeLeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style type="text/css">

        .accordion
        {
            max-height: 40px;
            background-color: #eee;
            color: #444;
            cursor: pointer;
            padding: 0px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 15px;
            transition: 0.4s;
        }  
        #panel
        {
            padding: 0 0px;
            display: none;
        }
        .heading
        {
            display: inline-block;
            float: left;
            font-size: 12px;
            color: #2E6B9B;
        }
        button
        {
            text-transform:none;
        }
        .RadAjaxPanel
        {
            padding: 0px 0px 0px 0px;
        }
        .wEmployeePreview
        {
            margin-top: 3px;
            margin-left: 3px;
            margin-right: 3px;
        }
        .widget
        {
            margin-top: 0px;
            margin-left: 3px;
            margin-right: 3px;
        }
        .widget13, .widget14, .widget15
        {
            margin-top: 3px;
            margin-left: 3px;
            margin-right: 3px;
        }
        .form input[type=text], .form input[type=password], .form textarea
        {
            width:50%;
        }
  
        .wNavButtons .RadAjaxPanel
        {
            float: left;
            margin-left: 5px;
        }
        .rgEditForm > table tr td:first-child
        {
            min-width: 50px;
        }

        #mainDiv
        {
            padding: 5px;
            border: 1px solid #cdcdcd;
            margin: 5px;
        }
        .OuterddlsDiv
        {
            float:left;
            height: 46px;
        }
        .ddlLabel
        {
            padding-top: 7px;
            float: left;
            padding-left: 10px;
            width: 67px;
        }
        .OuterddlsDiv .RadAjaxPanel
        {
            float: left;
            margin-top: 5px;
        }
        .tab_content
        {
            padding: 0px 0px;
        }
        @media only screen and (min-width: 601px) and (max-width: 1025px)
        {
            .RadGrid_Silk input.rgFilterBox
            {
                width: 40%!important;
            }

            .RadGrid .rgFilterRow > td
            {
                padding-left: 0px!important;
                padding-right: 0px!important;
            }
            .ddlVisible
            {
                display:none;
            }
        }

        
        @media only screen and (min-width: 0px) and (max-width: 600px)
        {
            .pageTitle
            {
                padding: 7px 0px 0px 0px !important;
            }
            .pageTitle h5
            {
                font-size: 20px;
            }
            .RadGrid_Silk input.rgFilterBox
            {
                width: 80%!important;
            }

            .RadGrid_Silk .rgFilter
            {
                display: none;
            }

            .RadGrid .rgFilterRow > td
            {
                padding-left: 0px!important;
                padding-right: 0px!important;
            }

            #mainDiv
            {
                padding: 0px!important;
                border: 1px solid #cdcdcd;
                margin: 0px!important;
            }
            .ddlVisible
            {
                display:none;
            }
            .tabLabelVisible
            {
                display:none;
            }
            .tabimg
            {
                padding-top:6px;
            }
            .widget .title
            {
                height: 25px;
            }

            .wEmployeePreview .title .titleIcon
            {
                padding: 7px 8px;
            }
            .line
            {
                display:none;
            }
        }
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            //tab1 script
            //function onRequestStart(sender, args) {
            //    if (
            //        args.get_eventTarget().indexOf("btnFilesExcelExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnFilesCsvExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnFilesPdfExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnFilesPrint") >= 0 ||
            //        args.get_eventTarget().indexOf("btnFilesRefresh") >= 0 ||
            //        args.get_eventTarget().indexOf("btnAttendanceDetailExcelExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnAttendanceDetailCsvExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnAttendanceDetailPdfExport") >= 0 ||
            //        args.get_eventTarget().indexOf("btnAttendanceDetailPrint") >= 0 ||
            //        args.get_eventTarget().indexOf("btnAttendanceDetailRefresh") >= 0
            //        ) {
            //        args.set_enableAjax(false);
            //    }
            //}

            function GoToNewEntriesState() {
                $('#btnNewEntries').click();
            }

            function togleDisplay() {
                $('#panel').toggle();
            }

            function ConfirmSubmit() {
                
                if (confirm($("#hfbtnsubtxt").val()))
                    return true;
                else
                    return false;
            }

            function ValidateAtt(ddlEmployeeID, ddlEmpPosID, ddlProjectID, dtpDateID, txtattcmtID) {
                var str = '';
                if ($('#' + ddlEmployeeID).val() == undefined || $('#' + ddlEmployeeID).val() == "") {
                    str += 'Employee Code Required.<br/>';
                }

                if ($('#' + dtpDateID).val() == undefined || $('#' + dtpDateID).val() == "") {
                    str += 'Date Required.<br/>';
                }

                if ($('#' + ddlProjectID).val() == undefined || $('#' + ddlProjectID).val() == "") {
                    str += 'Project Required.<br/>';
                }

                if (($('#' + ddlEmpPosID).val() == undefined || $('#' + ddlEmpPosID).val() == "") && $('#' + ddlEmpPosID).is(':visible')) {
                    str += 'Employee Position Required.<br/>';
                }
                
                //if ($('#' + txtattcmtID).val() == undefined || $('#' + txtattcmtID).val() == "") {
                //    str += 'Comments Required.<br/>';
                //}
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateHourtype(ddlHourClassID, txtHoursID) {
                var str = '';
                if ($('#' + ddlHourClassID).val() == undefined || $('#' + ddlHourClassID).val() == "") {
                    str += 'Hour Type Required.<br/>';
                }
                
                if ($('#' + txtHoursID).val() == undefined || $('#' + txtHoursID).val() == "") {
                    str += 'Hour Value Required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidatePremtype(ddlPremTypeID, txtPremiumID) {
                var str = '';
                if ($('#' + ddlPremTypeID).val() == undefined || $('#' + ddlPremTypeID).val() == "") {
                    str += 'Premium Type Required.<br/>';
                }

                if ($('#' + txtPremiumID).val() == undefined || $('#' + txtPremiumID).val() == "") {
                    str += 'Premium Value Required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function OnProjectOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("prjcod");
                var id = args.getDataKeyValue("prjidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdProjectOuter4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function OnProjectRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("prjcod");
                var id = args.getDataKeyValue("prjidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdProject4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden3').click();
                }, 50);
            }
            function OnSubProjectRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("subprjcod");
                var id = args.getDataKeyValue("subprjidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdSubProject4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function OnHourClassOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("hrtcod");
                var id = args.getDataKeyValue("hrtidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdHourClassOuter4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function OnHourClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("hrtcod");
                var id = args.getDataKeyValue("hrtidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdHourClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden2').click();
                }, 50);
            }

            function RowClickedRevise(sender, args) {
                var cellValues = args.getDataKeyValue("ID");
                var UserID = args.getDataKeyValue("ID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLevels4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);

                    combo.commitChanges();
                }, 50);
            }


            function onNormalHoursChange(sender, args) {
                var nhrs = 0;
                var str = '';
                if (args.get_newValue() != '')
                    nhrs = parseFloat(args.get_newValue());
                else
                    $("#txtNormalHours").val('0');

                if ($("#maxnormalhrs").val() != null && $("#maxnormalhrs").val() != undefined) {
                    if (nhrs > parseFloat($("#maxnormalhrs").val())) {
                        str += 'Normal hrs in calender setup are : ' + $("#maxnormalhrs").val() + ' <br/>';
                        if (nhrs > 24) {
                            $("#txtNormalHours").val('24');
                            nhrs = 24;
                        }
                    }
                }

                if ($("#hfphrs").val() != null || $("#hfphrs").val() != undefined) {
                    if (nhrs > parseFloat($("#hfphrs").val())) {
                        str += 'Normal hrs cant be greater than : ' + $("#hfphrs").val() + ' <br/>';
                        $("#txtNormalHours").val($("#hfphrs").val());
                    }
                }

                var ovt1 = 0;
                if ($("#txtOvertime1").val() != "")
                    ovt1 = parseFloat($("#txtOvertime1").val());

                var ovt2 = 0;
                if ($("#txtOvertime2").val() != "")
                    ovt2 = parseFloat($("#txtOvertime2").val());

                $("#txtTotalOverTime").val(ovt1 + ovt2);
                $("#txtTotalHours").val(ovt1 + ovt2 + nhrs);
                if (ovt1 + ovt2 + nhrs > 24)
                    str += 'Total hrs cant be greater than 24';
                if (str != '')
                    showInfo(str, null, 10000);
            }

            function onOvertime1Change(sender, args) {
                var nhrs = 0;
                var str = '';
                if ($("#txtNormalHours").val() != '')
                    nhrs = parseFloat($("#txtNormalHours").val());
                var ovt1 = 0;
                if (args.get_newValue() != '')
                    ovt1 = parseFloat(args.get_newValue());
                else
                    $("#txtOvertime1").val('0');

                if ($("#hfpot1").val() != null || $("#hfpot1").val() != undefined) {
                    if (parseFloat(ovt1) > parseFloat($("#hfpot1").val())) {
                        str += 'Overtime 1 hours cant be greater than : ' + $("#hfpot1").val() + ' <br/>';
                        $("#txtOvertime1").val($("#hfpot1").val());
                        ovt1 = parseFloat($("#hfpot1").val());
                    }
                }

                var ovt2 = 0;
                if ($("#txtOvertime2").val() != "")
                    ovt2 = parseFloat($("#txtOvertime2").val());

                $("#txtTotalOverTime").val(ovt1 + ovt2);
                $("#txtTotalHours").val(ovt1 + ovt2 + nhrs);
                if (ovt1 + ovt2 + nhrs > 24)
                    str += 'Total hrs cant be greater than 24';

                if (str != '')
                    showInfo(str, null, 10000);
            }

            function onOvertime2Change(sender, args) {
                var nhrs = 0;
                var str = '';
                if ($("#txtNormalHours").val() != '')
                    nhrs = parseFloat($("#txtNormalHours").val());
                var ovt2 = 0;
                if (args.get_newValue() != '')
                    ovt2 = parseFloat(args.get_newValue());
                else
                    $("#txtOvertime2").val('0');

                if ($("#hfpot2").val() != null || $("#hfpot2").val() != undefined) {
                    if (parseFloat(ovt2) > parseFloat($("#hfpot2").val())) {
                        str += 'Overtime 2 hours cant be greater than : ' + $("#hfpot2").val() + ' <br/>';
                        $("#txtOvertime2").val($("#hfpot2").val());
                        ovt2 = parseFloat($("#hfpot2").val());
                    }
                }

                var ovt1 = parseFloat($("#txtOvertime1").val());

                $("#txtTotalOverTime").val(ovt1 + ovt2);
                $("#txtTotalHours").val(ovt1 + ovt2 + nhrs);

                if (ovt1 + ovt2 + nhrs > 24)
                    str += 'Total hrs cant be greater than 24';

                if (str != '')
                    showInfo(str, null, 10000);
            }

            function UpdateAllConfirmation() {
                return confirm("Are you sure you want to update all normal hours?");
            }

            function OnEmployeeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeID");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(id);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                $('#btnHidden').click();
                //refreshGrid();
                //refreshGrid2();
                /// $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_btnHidden').click();
                // }, 50);
            }
            
            function OnEmployeeOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployeeOuter4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(id);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                var grid = $find('<%= ddlHourClassOuter.Items[0].FindControl("rGrdHourClassOuter4DDL").ClientID %>');
                var masterTable = grid.get_masterTableView();
                masterTable.rebind();

                //$('#btnHidden1').click();
                //__doPostBack('ddlEmployeeOuter', '');
                //refreshGrid2();
                // $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_btnHidden').click();
                // }, 50);
            }

            function SettingDefaultEmpPos(idd, code) {
                var cellValues = code;
                var id = idd;
                var combo = $find(rGrdEmployee4DDL.ClientID.replace('_i0_rGrdEmpPos4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function OnEmpPosRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("poscod");
                var id = args.getDataKeyValue("posidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmpPos4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function OnPremTypeOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("premtype");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPremTypeOuter4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function OnPremTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("premtype");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPremType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden4').click();
                }, 50);
            }

            function OnPremType2RowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("premtype");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPremType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden6').click();
                }, 50);
            }

            function ShowEditForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowRecallForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            };

            function ShowSubmittedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowApproveForm(id, rowIndex, RequestStatusID, FormType) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ApproveForms/ApproveLeaveTransaction.aspx?RequestID=" + id + "&RequestStatusID=" + RequestStatusID + "&FormType=" + FormType, "RadWindow2");
                return false;
            }

            function showSuccessMessage(msg) {
                showSuccess(msg, null, 10000);
            }

            function ShowApprovalViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvApprovedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowPendingViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowSavedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewLeaveTransaction.aspx?LeaveTransactionID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowTab(tab) {
                var wd = $("div[class^='widget']");
                if (wd != null && wd != undefined) {
                    if (typeof wd.contentTabs !== 'undefined' && $.isFunction(wd.contentTabs)) {
                        wd.contentTabs();
                        wd.find("ul.tabs li:nth-child(n)").removeClass("activeTab").show(); //Activate first tab
                        wd.find(".tab_content:nth-child(n)").hide(); //Show first tab content 
                        wd.find('a[href="' + tab + '"]').parent().addClass("activeTab"); //Add "active" class to selected tab
                        $(tab).show(); //Fade in the active content
                    }
                }
            };

            function buttonClick() {
                $('#btnLdAdd').click();
            }

            function refreshGrid2() {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                if (ajaxManager != null) {
                    ajaxManager.ajaxRequest("Rebind");
                }
            }

            function refreshGrid(arg) {
                if (!arg) {
                    var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                    ajaxManager.ajaxRequest("Rebind");
                }
            }

            function ShowOrgChart(id, rowIndex) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("WorkflowChart.aspx?LeaveTransactionID=" + id, "RadWindowOrgChart");
                return false;
            }

            function ShowReport(RequestId, Reportname) {
                window.open("../Reports/LaunchReport.aspx?RequestId=" + RequestId + "&Reportname=" + Reportname);
                return false;
            }

            var currentLoadingPanel = null;
            var currentUpdatedControl = null;

            function RequestStart(sender, args) {
                currentLoadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                currentUpdatedControl = "<%= pnlAjaxForm.ClientID %>";
                currentLoadingPanel.show(currentUpdatedControl);
            }

            function ResponseEnd() {
                //hide the loading panel and clean up the global variables
                if (currentLoadingPanel != null)
                    currentLoadingPanel.hide(currentUpdatedControl);
                currentUpdatedControl = null;
                currentLoadingPanel = null;
            }


            function OpenEmployeeOuterddl() {
                //alert('EmployeeOuter');
                $('#empOuter .rcbSlide').show();
            }

            function OpenProjectOuterddl() {
                //alert('ProjectOuter');
                $('#prjOuter .rcbSlide').show();
            }

            function OpenHrClassOuterddl() {
                //alert('HrClassOuter');
                $('#hrClassOuter .rcbSlide').show();
            }

            function OpenPremOuterddl() {
                //alert('PremOuter');
                $('#premOuter .rcbSlide').show();
            }





            function OpenEmployeeddl() {
                $('#emp .rcbSlide').show();
            }

            function OpenProjectddl() {
                $('#prj .rcbSlide').show();
            }

            function OpenSubProjectddl()
            {
                $('#subprj .rcbSlide').show();
            }

            function OpenEmpPosddl() {
                $('#empPos .rcbSlide').show();
            }

            function OpenHourClassddl() {
                $('#hrClass .rcbSlide').show();
            }

            function OpenPremTypeddl() {
                $('#prem .rcbSlide').show();
            }

            function OpenPremType2ddl() {
                $('#prem2 .rcbSlide').show();
            }

            function closeddl()
            {
                $('.rcbSlide').hide();
            }
             
            function MainFunction() {
                $(".rcbArrowCell a").click(function () {

                    if ($('.rcbSlide').is(':visible'))
                    {
                        $('.rcbSlide').fadeOut('fast').hide();
                    }                
                });
            }
            

        </script>
    </telerik:RadCodeBlock>

    <script type="text/javascript">

        var maxHeight = 900;
        function OnClientShow(active) {
            setTimeout(function () {
                var height = active._tableElement.offsetHeight < maxHeight ? active._tableElement.offsetHeight : maxHeight;
                active.set_height(height);
                active.set_contentScrolling(Telerik.Web.UI.ToolTipScrolling.Auto);
                active._show();
            }, 0);
        }

        function OnClientHide(active) {
            active.set_height(0);
            active.set_contentScrolling(Telerik.Web.UI.ToolTipScrolling.Default);
        }

    </script>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvSubmittedRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"   />
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvPendingAppRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"   />
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvApprovedRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvApprovedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvSavedRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"   />
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvAtt">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSaveAndSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"/>
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"/>
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
        
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnNewEntries">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvAtt"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"/>
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlEmployee">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlEmpPos"/>
                    <telerik:AjaxUpdatedControl ControlID="ddlProject"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbEmployeeddl">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbEmployeeddl"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbProject">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbProject"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbHourClass">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbHourClass"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbPremType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbPremType"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmployeeOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployeeOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdHourClassOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdHourClassOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdProjectOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdProjectOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
        <%--<AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdPremTypeOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdPremTypeOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>--%>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmployee4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployee4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmpPos4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmpPos4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdProject4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdProject4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdSubProject4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdSubProject4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdHourClass4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdHourClass4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdPremType4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdPremType4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdProject4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdProject4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlEmployeeOuter">
                <UpdatedControls>
                    <%--<telerik:AjaxUpdatedControl ControlID="ddlEmployeeOuter"/>--%>
                    <telerik:AjaxUpdatedControl ControlID="ddlHourClassOuter"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    <%--<AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="btnHidden1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="ddlHourClassOuter"/>
                <telerik:AjaxUpdatedControl ControlID="ddlEmployeeOuter"/>
                <telerik:AjaxUpdatedControl ControlID="rGrdEmployeeOuter4DDL"/>
                
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>--%>
        
        
        
        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
        <div style="height: 29px;border-bottom: 1px solid lightgray;overflow: hidden;">
            <span style="float:right">
                <asp:Label ID="lblprintOptions" runat="server" Text="Print Options:" meta:resourcekey="Label1111111" Style="font-weight: bold;"></asp:Label>
                <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
            </span>
        </div>
        <ul class="tabs">
            <li class="Tab1 tabWidth">
                <a href="#tab1">
                    <img src="../../Images/16x16_tick2.png" alt="New Request" class="tabimg"/>
                    <label class="tabLabelVisible">New Requests</label>
                </a>
            </li>
            <li class="Tab2 tabWidth">
                <a href="#tab2">
                    <img src="../../Images/checkmark2.png" alt="Saved Request" class="tabimg"/>
                    <label class="tabLabelVisible">Saved Requests</label>
                </a>
            </li>
            <li class="Tab3 tabWidth">
                <a href="#tab3">
                    <img src="../../Images/16x16_process.png" alt="Submitted Request" class="tabimg"/>
                    <label class="tabLabelVisible">Submitted Requests</label>
                </a>
            </li>
            <li class="Tab4 tabWidth">
                <a href="#tab4">
                    <img src="../../Images/16x16_Check.png" alt="Pending Request" class="tabimg" />
                    <label class="tabLabelVisible">Decision Pending</label>
                </a>
            </li>
            <li class="Tab5 tabWidth">
                <a href="#tab5">
                    <img src="../../Images/16x16_approved.png" alt="Approved Requests" class="tabimg"/>
                    <label class="tabLabelVisible">Requests with Decisions</label>
                </a>
            </li>

        </ul>
        
        <div class="tab_container">
            <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                <div id="tab1" class="tab_content">
                    <fieldset>
                        <div class="wEmployeePreview">
                            <asp:Panel ID="TopPanel" runat="server" >
                                <button type="button" id="button1" class="accordion" onclick="togleDisplay()">
                                    <div class="title" style="width: 100%">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                        <h6 style="padding-top: 10px">Default Values</h6>
                                    </div>
                                </button>
                                <div id="panel">
                                    <table style="margin-top: 20px">
                                    <tr style="">
                                        <td>
                                            <div class="OuterddlsDiv" id="empOuter">
                                            <asp:Label ID="Label2" runat="server" Text="Employee:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                            <span class="combo180" Style="float:left;">
                                                <asp:Button ID="btnHidden1" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                <telerik:RadComboBox ID="ddlEmployeeOuter" runat="server"
                                                    Width="180px" DropDownWidth="180px" AutoPostBack="true"
                                                    EmptyMessage="Please select..." OnSelectedIndexChanged="ddlEmployeeOuter_SelectedIndexChanged">
                                                    <ItemTemplate>
                                                        <div style="overflow: auto; max-height: 200px;">
                                                            <telerik:RadGrid ID="rGrdEmployeeOuter4DDL" AllowMultiRowSelection="false" runat="server" 
                                                                AllowFilteringByColumn="true" OnItemCommand="rGrdEmployeeOuter4DDL_ItemCommand" ClientSettings-ClientEvents-OnRowSelected="closeddl"  
                                                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" GridLines="None" 
                                                                OnNeedDataSource="rGrdEmployeeOuter4DDL_NeedDataSource" Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>
                                                                <MasterTableView DataKeyNames="recidd,empcod,empfsn" ClientDataKeyNames="recidd,empcod,empfsn">
                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter recidd column"
                                                                            HeaderText="ID" UniqueName="recidd">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter empcod column"
                                                                            HeaderText="Code" UniqueName="empcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter empfsn column"
                                                                            HeaderText="Name" UniqueName="empfsn" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                                <ClientSettings>
                                                                    <ClientEvents OnRowClick="OnEmployeeOuterRowClicked"></ClientEvents>
                                                                </ClientSettings>
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                            </telerik:RadGrid>
                                                        </div>
                                                    </ItemTemplate>
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>
                                            </span>
                                            <telerik:RadCheckBox ID="rcbEmployeeddl" runat="server" Text="" style="margin-left:10px;"></telerik:RadCheckBox>
                                            </div>
                                            <div class="OuterddlsDiv" id="PrjOuter" >
                                                <asp:Label ID="Label1" runat="server" Text="Project:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                <span class="combo180" Style="float:left;">
                                                    <telerik:RadComboBox ID="ddlProjectOuter" runat="server"
                                                        Width="180px" DropDownWidth="180px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; max-height: 200px;">
                                                            <telerik:RadGrid ID="rGrdProjectOuter4DDL" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                AutoGenerateColumns="False" OnItemCommand="rGrdProjectOuter4DDL_ItemCommand" ClientSettings-ClientEvents-OnRowSelected="closeddl"  
                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdProjectOuter4DDL_NeedDataSource"
                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>

                                                                <MasterTableView DataKeyNames="prjidd,prjcod,prjds1"
                                                                    ClientDataKeyNames="prjidd,prjcod,prjds1" TableLayout="Fixed">
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>

                                                                        <telerik:GridBoundColumn DataField="prjidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                            HeaderText="ID" UniqueName="prjidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="prjcod" FilterControlAltText="Filter column2 column"
                                                                            HeaderText="Code" UniqueName="prjcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                            <HeaderStyle Width="100px" />
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="prjds1" FilterControlAltText="Filter  column3 column"
                                                                            HeaderText="Description" UniqueName="prjds1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                            <HeaderStyle Width="110px" />
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                                <ClientSettings>
                                                                    <ClientEvents OnRowClick="OnProjectOuterRowClicked"></ClientEvents>
                                                                </ClientSettings>
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                            </telerik:RadGrid>
                                                                </div>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </span>
                                                <telerik:RadCheckBox ID="rcbProject" runat="server" Text="" style="margin-left:10px;"></telerik:RadCheckBox>
                                            </div>

                                            <div class="OuterddlsDiv" id="hrClassOuter">
                                                <asp:Label ID="Label3" runat="server" Text="Hour Class:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                <span class="combo180" Style="float:left;">
                                                    <telerik:RadComboBox ID="ddlHourClassOuter" runat="server"
                                                        Width="180px" DropDownWidth="180px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; max-height: 200px;">
                                                            <telerik:RadGrid ID="rGrdHourClassOuter4DDL" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                AutoGenerateColumns="False" OnItemCommand="rGrdHourClassOuter4DDL_ItemCommand" ClientSettings-ClientEvents-OnRowSelected="closeddl"  
                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdHourClassOuter4DDL_NeedDataSource"
                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                <GroupingSettings CaseSensitive="false" />
                                                                <ClientSettings>
                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                </ClientSettings>

                                                                <MasterTableView DataKeyNames="hrtidd,hrtcod,hourtypedescription"
                                                                    ClientDataKeyNames="hrtidd,hrtcod,hourtypedescription">
                                                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </RowIndicatorColumn>
                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                    </ExpandCollapseColumn>
                                                                    <Columns>
                                                                        <telerik:GridBoundColumn DataField="hrtidd" Visible="false" FilterControlAltText="Filter hrtidd column"
                                                                            HeaderText="ID" UniqueName="hrtidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="hrtcod" FilterControlAltText="Filter hrtcod column"
                                                                            HeaderText="Code" UniqueName="hrtcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                        <telerik:GridBoundColumn DataField="hourtypedescription" FilterControlAltText="Filter hourtypedescription column"
                                                                            HeaderText="Description" UniqueName="hourtypedescription" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                        </telerik:GridBoundColumn>
                                                                    </Columns>
                                                                    <EditFormSettings>
                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                        </EditColumn>
                                                                    </EditFormSettings>
                                                                </MasterTableView>
                                                                <ClientSettings>
                                                                    <ClientEvents OnRowClick="OnHourClassOuterRowClicked"></ClientEvents>
                                                                </ClientSettings>
                                                                <FilterMenu EnableImageSprites="False">
                                                                </FilterMenu>
                                                            </telerik:RadGrid>
                                                                </div>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </span>
                                                <telerik:RadCheckBox ID="rcbHourClass" runat="server" Text="" style="margin-left:10px;"></telerik:RadCheckBox>
                                            </div>

                                            <div class="OuterddlsDiv" id="premOuter">
                                                <asp:Label ID="Label4" runat="server" Text="Prem Type:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                <span class="combo180" Style="float:left;">
                                                    <telerik:RadComboBox ID="ddlPremTypeOuter" runat="server"
                                                        Width="180px" DropDownWidth="180px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <div style="overflow: auto; max-height: 200px;">
                                                                <telerik:RadGrid ID="rGrdPremTypeOuter4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                    AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPremTypeOuter4DDL_NeedDataSource"
                                                                    Width="180px" ClientSettings-EnableRowHoverStyle="True" OnItemCommand="rGrdPremTypeOuter4DDL_ItemCommand"
                                                                    ClientSettings-ClientEvents-OnRowSelected="closeddl"  >
                                                                    <GroupingSettings CaseSensitive="false" />
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,premtype,premtypedescription" ClientDataKeyNames="recidd,premtype,premtypedescription">
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="2px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter recidd column"
                                                                                HeaderText="Id" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="premtype" FilterControlAltText="Filter premtype column"
                                                                                HeaderText="Code" UniqueName="premtype" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="premtypedescription" FilterControlAltText="Filter premtypedescription column"
                                                                                HeaderText="Description" UniqueName="premtypedescription" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                            </telerik:GridBoundColumn>

                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnPremTypeOuterRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>

                                                            </div>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </span>
                                                <telerik:RadCheckBox ID="rcbPremType" runat="server" Text="" Style="margin-left: 10px;"></telerik:RadCheckBox>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                </div>
                                
                            </asp:Panel>
                          
                            <asp:HiddenField ID="hfbtnsubtxt" runat="server" Value="Are you sure?" ClientIDMode="Static"/>
                            
                            <telerik:RadGrid ID="gvAtt" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvAtt_InsertCommand"
                                OnNeedDataSource="gvAtt_NeedDataSource" PageSize="31" OnDeleteCommand="gvAtt_DeleteCommand"
                                OnUpdateCommand="gvAtt_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvAtt_ItemDataBound"
                                OnItemCommand="gvAtt_ItemCommand" OnDetailTableDataBind="gvAtt_DetailTableDataBind"
                                OnItemCreated="gvAtt_ItemCreated" OnPreRender="gvAtt_PreRender" >
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings>
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <ExportSettings
                                    HideStructureColumns="true"
                                    ExportOnlyData="true"
                                    IgnorePaging="true"
                                    OpenInNewWindow="true">
                                    <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                                    <Pdf PaperSize="A4">
                                    </Pdf>
                                </ExportSettings>
                                <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False"  
                                    DataKeyNames="recidd,empidd,Date,empcod,prjcod,prjidd,subprjcod,subprjidd,posidd,poscod,attcmt,IsWeekend,IsPublicHoliday"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                    <DetailTables>
<%--     /////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="EditForms" Name="HourType" CommandItemDisplay="Top" DataKeyNames="recidd,mrecidd,hrclsidd,hrclscod">   
                                                <CommandItemTemplate>
                                                    <%--<div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Hour Type Detail</h6>
                                                    </div>--%>
                                                    <tr class="rgCommandRow">

                                                        <td colspan="8" class="rgCommandCell">

                                                            <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                                <caption>

                                                                    <span style="display: none">Command item</span>
                                                                </caption>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col"></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <tr>
                                                                        <td align="left">
                                                                            <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" style="float:left" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                            <h6 class="heading">Hour Type Detail</h6>
                                                                        </td>
                                                                        <td align="right">
                                                                            <%--<asp:Button runat="server" ID="btnLdExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnLdExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnLdExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />--%>
                                                                            <asp:Button runat="server" ID="btnLdPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <%--<asp:Button ID="btnLdRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />--%>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </CommandItemTemplate>
                                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <DetailTables>


                                                    <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="EditForms" Name="PremiumType2" CommandItemDisplay="Top" DataKeyNames="recidd,prtidd,prtcod">

                                                <CommandItemTemplate>
                                                    <%--<div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Premium Type Detail</h6>
                                                    </div>--%>
                                                    <tr class="rgCommandRow">

                                                        <td colspan="8" class="rgCommandCell">

                                                            <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                                <caption>

                                                                    <span style="display: none">Command item</span>
                                                                </caption>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col"></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <td align="left">
                                                                        <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd"  style="float:left" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        <h6 class="heading">Premium Type Detail</h6>
                                                                    </td>
                                                                   <td align="right">
                                                                         <%--<asp:Button runat="server" ID="btnLdpExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnLdpExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnLdpExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />--%>
                                                                        <asp:Button runat="server" ID="btnLdpPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <%--<asp:Button ID="btnLdpRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />--%>
                                                                    </td>

                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </CommandItemTemplate>
                                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <DetailTables>
                                                </DetailTables>
                                                <Columns>
                                                    <telerik:GridTemplateColumn DataField="prtcod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="prtcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Prem. Type" UniqueName="prtcod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPrTCod" runat="server" Text='<%# Eval("prtcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" id="prem2" style="border-bottom: 0px; padding-left: 0px">
                                                                        <span class="combo180">
                                                                            <asp:Button ID="btnHidden6" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                            
                                                                            <telerik:RadComboBox ID="ddlPremType2" runat="server"
                                                                                Width="180px" DropDownWidth="180px" OnPreRender="ddlPremType2_PreRender"
                                                                                EmptyMessage="Please select..." OnSelectedIndexChanged="ddlPremType2_SelectedIndexChanged">
                                                                                <ItemTemplate>
                                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                                        <telerik:RadGrid ID="rGrdPremType4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" 
                                                                                            AutoGenerateColumns="False" ClientSettings-ClientEvents-OnRowSelected="closeddl" OnItemCommand="rGrdPremType4DDL_ItemCommand1"
                                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPremHourType4DDL_NeedDataSource" AllowFilteringByColumn="true"
                                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                            <GroupingSettings CaseSensitive="false" />
                                                                                            <ClientSettings>
                                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                            </ClientSettings>
                                                                                            <MasterTableView DataKeyNames="recidd,premtype,premtypedescription" ClientDataKeyNames="recidd,premtype,premtypedescription">
                                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </RowIndicatorColumn>
                                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </ExpandCollapseColumn>
                                                                                                <Columns>
                                                                                                    <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter recidd column"
                                                                                                        HeaderText="Id" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="premtype" FilterControlAltText="Filter premtype column"
                                                                                                        HeaderText="Code" UniqueName="premtype" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="premtypedescription" FilterControlAltText="Filter premtypedescription column"
                                                                                                        HeaderText="Description" UniqueName="premtypedescription" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>

                                                                                                </Columns>
                                                                                                <EditFormSettings>
                                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                    </EditColumn>
                                                                                                </EditFormSettings>
                                                                                            </MasterTableView>
                                                                                            <ClientSettings>
                                                                                                <ClientEvents OnRowClick="OnPremType2RowClicked"></ClientEvents>
                                                                                            </ClientSettings>
                                                                                            <FilterMenu EnableImageSprites="False">
                                                                                            </FilterMenu>
                                                                                        </telerik:RadGrid>

                                                                                    </div>
                                                                                </ItemTemplate>
                                                                                <Items>
                                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                                </Items>
                                                                            </telerik:RadComboBox>
                                                                        </span>
                                                                        
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px;">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVal123" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlpremtype2"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="prtval" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="prtval" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Prem. Value" UniqueName="prtval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPrTVal" runat="server" Text='<%# Eval("prtval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadNumericTextBox ID="txtPremium"
                                                                            ClientIDMode="Static"
                                                                            MaxLength="4" runat="server" Text='<%# Eval("prtval") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldV212" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtPremium"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="ptdesc" FilterControlWidth="130px" SortExpression="ptdesc" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter ptdesc column"
                                                        HeaderText="Description" UniqueName="ptdesc">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblptdesc" runat="server" Text='<%# Eval("ptdesc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 180px; border-bottom: 0px">
                                                                        <telerik:RadTextBox runat="server" ID="txtptdesc" MaxLength="50" Text='<%# Eval("ptdesc") %>'></telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <%--<asp:RequiredFieldValidator ID="RFVtxtptdesc" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtptdesc"></asp:RequiredFieldValidator>--%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="Edit" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                                        ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="Delete" >
                                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                    </telerik:GridButtonColumn>

                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>




                                                </DetailTables>
                                                <Columns>
                                                    <telerik:GridTemplateColumn DataField="hrclscod" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="hrclscod"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Hour Type" UniqueName="hrclscod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblHourClass" runat="server" Text='<%# Eval("hrclscod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>

                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" id="hrClass" style="border-bottom: 0px; padding-left: 0px">
                                                                        <span class="combo180">
                                                                            <asp:Button ID="btnHidden2" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                            
                                                                            <%--<asp:TextBox ID="htxtEmpId" runat="server" visible="false" ></asp:TextBox>--%>

                                                                            <telerik:RadComboBox ID="ddlHourClass" runat="server"
                                                                                Width="180px" DropDownWidth="180px" OnPreRender="ddlHourClass_PreRender"
                                                                                EmptyMessage="Please select..." OnSelectedIndexChanged="ddlHourClass_SelectedIndexChanged">
                                                                                <ItemTemplate>
                                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                                    <telerik:RadGrid ID="rGrdHourClass4DDL" runat="server" AllowSorting="True" OnItemCommand="rGrdHourClass4DDL_ItemCommand"
                                                                                        AutoGenerateColumns="False" AllowFilteringByColumn="true" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdHourClass4DDL_NeedDataSource"
                                                                                        Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                        <GroupingSettings CaseSensitive="false" />
                                                                                        <ClientSettings>
                                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                        </ClientSettings>

                                                                                        <MasterTableView DataKeyNames="hrtidd,hrtcod,hourtypedescription"
                                                                                            ClientDataKeyNames="hrtidd,hrtcod,hourtypedescription">
                                                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                                            </RowIndicatorColumn>
                                                                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                                            </ExpandCollapseColumn>
                                                                                            <Columns>
                                                                                                <telerik:GridBoundColumn DataField="hrtidd" Visible="false" FilterControlAltText="Filter hrtidd column"
                                                                                                    HeaderText="ID" UniqueName="hrtidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                </telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn DataField="hrtcod" FilterControlAltText="Filter hrtcod column"
                                                                                                    HeaderText="Code" UniqueName="hrtcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                </telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn DataField="hourtypedescription" FilterControlAltText="Filter hourtypedescription column"
                                                                                                    HeaderText="Description" UniqueName="hourtypedescription" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                </telerik:GridBoundColumn>
                                                                                            </Columns>
                                                                                            <EditFormSettings>
                                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                </EditColumn>
                                                                                            </EditFormSettings>
                                                                                        </MasterTableView>
                                                                                        <ClientSettings>
                                                                                            <ClientEvents OnRowClick="OnHourClassRowClicked"></ClientEvents>
                                                                                        </ClientSettings>
                                                                                        <FilterMenu EnableImageSprites="False">
                                                                                        </FilterMenu>
                                                                                    </telerik:RadGrid>
                                                                                        </div>
                                                                                </ItemTemplate>
                                                                                <Items>
                                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                                </Items>
                                                                            </telerik:RadComboBox>
                                                                        </span>
                                                                        
                                                                    </td>
                                                                    <td style="border-bottom: 0px;padding-left: 0px;">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVal1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlHourClass"></asp:RequiredFieldValidator>

                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="hours" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="hours" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Hour Value" UniqueName="hours">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblHours" runat="server" Text='<%# Eval("hours") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadNumericTextBox ID="txtHours" ClientIDMode="Static"
                                                                            MaxLength="4"
                                                                             runat="server" Text='<%# Eval("hours") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldV2" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtHours"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="htdesc" FilterControlWidth="130px" SortExpression="htdesc" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter htdesc column"
                                                        HeaderText="Description" UniqueName="htdesc">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblhtdesc" runat="server" Text='<%# Eval("htdesc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 180px; border-bottom: 0px">
                                                                        <telerik:RadTextBox runat="server" ID="txthtdesc" MaxLength="50" Text='<%# Eval("htdesc") %>'></telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <%--<asp:RequiredFieldValidator ID="RFVtxthtdesc" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txthtdesc"></asp:RequiredFieldValidator>--%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="Edit" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                                        ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="Delete" >
                                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>

                                            <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="EditForms" Name="PremiumType" CommandItemDisplay="Top" DataKeyNames="recidd,prtidd,prtcod">

                                                <CommandItemTemplate>
                                                    <%--<div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Premium Type Detail</h6>
                                                    </div>--%>
                                                    <tr class="rgCommandRow">

                                                        <td colspan="8" class="rgCommandCell">

                                                            <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                                <caption>

                                                                    <span style="display: none">Command item</span>
                                                                </caption>
                                                                <thead>
                                                                    <tr>
                                                                        <th scope="col"></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <td align="left">
                                                                        <asp:Button ID="btnAdd"  runat="server" CssClass="rgAdd"  style="float:left" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        <h6 class="heading">Premium Type Detail</h6>
                                                                    </td>
                                                                    <td align="right">
                                                                        <%--<asp:Button runat="server" ID="btnLdpExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnLdpExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnLdpExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />--%>
                                                                        <asp:Button runat="server" ID="btnLdpPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <%--<asp:Button ID="btnLdpRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />--%>
                                                                    </td>

                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </CommandItemTemplate>
                                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </RowIndicatorColumn>
                                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                    <HeaderStyle Width="20px" />
                                                </ExpandCollapseColumn>
                                                <DetailTables>
                                                </DetailTables>
                                                <Columns>
                                                    <telerik:GridTemplateColumn DataField="prtcod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="prtcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Prem. Type" UniqueName="prtcod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPrTCod" runat="server" Text='<%# Eval("prtcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" id="prem" style="border-bottom: 0px; padding-left: 0px">
                                                                        <span class="combo180">
                                                                            <asp:Button ID="btnHidden4" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                            <telerik:RadComboBox ID="ddlPremType" runat="server"
                                                                                Width="180px" DropDownWidth="180px" OnPreRender="ddlPremType_PreRender"
                                                                                EmptyMessage="Please select..." OnSelectedIndexChanged="ddlPremType_SelectedIndexChanged">
                                                                                <ItemTemplate>
                                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                                        <telerik:RadGrid ID="rGrdPremType4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True"
                                                                                            AutoGenerateColumns="False" ClientSettings-ClientEvents-OnRowSelected="closeddl" OnItemCommand="rGrdPremType4DDL_ItemCommand"
                                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPremType4DDL_NeedDataSource" AllowFilteringByColumn="true"
                                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                            <GroupingSettings CaseSensitive="false" />
                                                                                            <ClientSettings>
                                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                            </ClientSettings>
                                                                                            <MasterTableView DataKeyNames="recidd,premtype,premtypedescription" ClientDataKeyNames="recidd,premtype,premtypedescription">
                                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </RowIndicatorColumn>
                                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </ExpandCollapseColumn>
                                                                                                <Columns>
                                                                                                    <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter recidd column"
                                                                                                        HeaderText="Id" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="premtype" FilterControlAltText="Filter premtype column"
                                                                                                        HeaderText="Code" UniqueName="premtype" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="premtypedescription" FilterControlAltText="Filter premtypedescription column"
                                                                                                        HeaderText="Description" UniqueName="premtypedescription" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>

                                                                                                </Columns>
                                                                                                <EditFormSettings>
                                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                    </EditColumn>
                                                                                                </EditFormSettings>
                                                                                            </MasterTableView>
                                                                                            <ClientSettings>
                                                                                                <ClientEvents OnRowClick="OnPremTypeRowClicked"></ClientEvents>
                                                                                            </ClientSettings>
                                                                                            <FilterMenu EnableImageSprites="False">
                                                                                            </FilterMenu>
                                                                                        </telerik:RadGrid>

                                                                                    </div>
                                                                                </ItemTemplate>
                                                                                <Items>
                                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                                </Items>
                                                                            </telerik:RadComboBox>
                                                                        </span>
                                                                        
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px;">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVal123" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlpremtype"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="prtval" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="prtval" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Prem. Value" UniqueName="prtval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPrTVal" runat="server" Text='<%# Eval("prtval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadNumericTextBox ID="txtPremium"
                                                                            ClientIDMode="Static"
                                                                            MaxLength="4" runat="server" Text='<%# Eval("prtval") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldV212" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtPremium"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="ptdesc" FilterControlWidth="130px" SortExpression="ptdesc" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter ptdesc column"
                                                        HeaderText="Description" UniqueName="ptdesc">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblptdesc" runat="server" Text='<%# Eval("ptdesc") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 180px; border-bottom: 0px">
                                                                        <telerik:RadTextBox runat="server" ID="txtptdesc" MaxLength="50" Text='<%# Eval("ptdesc") %>'></telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <%--<asp:RequiredFieldValidator ID="RFVtxtptdesc" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtptdesc"></asp:RequiredFieldValidator>--%>
                                                                    </td>
                                                                </tr>
                                                            </table>

                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="Edit" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                                        ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="Delete" >
                                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                    </telerik:GridButtonColumn>

                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>
                        <%--////////////////////////////////////////////////////////////////////////////////////////////////////////--%>
                                    </DetailTables>
                                    <CommandItemTemplate>
                                        <div class="title tabLabelVisible" >
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                            <h6>Attendance List</h6>
                                        </div>
                                        <tr class="rgCommandRow">

                                            <td colspan="17" class="rgCommandCell">

                                                <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                    <caption>

                                                        <span style="display: none">Command item</span>
                                                    </caption>
                                                    <thead>
                                                        <tr>
                                                            <th scope="col"></th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>

                                                            <td align="left">
                                                                <asp:Button ID="btnAdd" Visible="true" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                            <asp:Button ID="btnNewEntries" ClientIDMode="Static" runat="server" OnClick="btnNewEntries_Click" Text="New Group" class="button greenB" ></asp:Button>
                                                                 </td>
                                                            <td align="left" >
                                                                <asp:Button runat="server" ID="btnUpdateNH" Visible="false" OnClientClick="if (! UpdateAllConfirmation()) return false;"
                                                                    CausesValidation="false" CommandName="UpdateAll" AlternateText="Update All" ToolTip="Update All" Text="Update All" />
                                                                <div style="float: right">
                                                                    <asp:Button runat="server" Visible="false" ID="btnFilesExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" Visible="false" ID="btnFilesCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" Visible="false" ID="btnFilesPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <%--<span>
                                                                        <telerik:RadComboBox ID="ddlPrintOptions" CssClass="ddlVisible" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                                    </span>--%>
                                                                    <asp:Button runat="server" ID="btnFilesPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnFilesRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />

                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </CommandItemTemplate>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>

                                    <Columns>
                                        <telerik:GridTemplateColumn DataField="prmtrx" Visible="true" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="prmtrx" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Trx No." UniqueName="prmtrx">
                                            <ItemTemplate>
                                                <asp:Label ID="lblprmtrx" runat="server" Text='<%# Eval("prmtrx") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" style="border-bottom: 0px;padding-bottom: 0px; padding-left: 0px">
                                                            <asp:Label ID="lblprmtrx1" runat="server" Text='<%# Eval("prmtrx") %>'></asp:Label>
                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px"></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="empidd" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="empidd" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="EmpId" UniqueName="empidd">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpId" runat="server" Text='<%# Eval("empidd") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="empcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Emp. Code" UniqueName="empcod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpCod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" id="emp" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                 <asp:Button ID="btnHidden" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                 <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                                                    Width="180px" DropDownWidth="180px" OnPreRender="ddlEmployee_PreRender"
                                                                    EmptyMessage="Please select..." OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdEmployee4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" 
                                                                                AutoGenerateColumns="False" OnItemCommand="rGrdEmployee4DDL_ItemCommand" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource"  AllowFilteringByColumn="true" Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <GroupingSettings CaseSensitive="false" />
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="recidd,EmployeeID,EmployeeFullNameWithID" ClientDataKeyNames="recidd,EmployeeID,EmployeeFullNameWithID">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>

                                                                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="ID" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="EmployeeID" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="EmployeeID" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="EmployeeFullNameWithID" FilterControlAltText="filter column3 column"
                                                                                            HeaderText="Name" UniqueName="EmployeeFullNameWithID" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowClick="OnEmployeeRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>

                                                        </td>

                                                        <td style="border-bottom: 0px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="rfvddlEmployee" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlEmployee"></asp:RequiredFieldValidator>
                                                        </td>                                                  
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="name" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="name" CurrentFilterFunction="Contains" FilterControlAltText="Filter name column"
                                            HeaderText="Name" UniqueName="name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="Date" FilterControlWidth="80px" meta:resourcekey="LabelResource22" AutoPostBackOnFilter="true" SortExpression="Date"
                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Date" UniqueName="Date">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDate" ClientIDMode="Static" runat="server"
                                                    Text='<%# DateTime.Parse((Eval("Date").ToString())).ToString("dd/MMM/yyyy", System.Globalization.CultureInfo.InvariantCulture) %>'></asp:Label>
                                            </ItemTemplate>
                                            
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="DayName" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="DayName" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Day" UniqueName="DayName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                             <telerik:RadDatePicker ID="dtpDate" runat="server" DbSelectedDate='<%# Bind("Date", "{0:d}") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="rfvdtpDate" Style="float: left" runat="server"
                                                                ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="dtpDate"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="prjidd" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="prjidd" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="ProjectId" UniqueName="prjidd">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectId" runat="server" Text='<%# Eval("prjidd") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="prjcod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="prjcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Project" UniqueName="prjcod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblProjectCode" runat="server" Text='<%# Eval("prjcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" id="prj" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <asp:Button ID="btnHidden3" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                <telerik:RadComboBox ID="ddlProject" runat="server"  OnPreRender="ddlProject_PreRender"
                                                                    Width="180px" DropDownWidth="180px" OnSelectedIndexChanged="ddlProject_SelectedIndexChanged"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdProject4DDL" runat="server" AllowSorting="True" OnItemCommand="rGrdProject4DDL_ItemCommand"
                                                                            AutoGenerateColumns="False" AllowFilteringByColumn="true" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdProject4DDL_NeedDataSource"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <GroupingSettings CaseSensitive="false" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="prjidd,prjcod,prjds1"
                                                                                ClientDataKeyNames="prjidd,prjcod,prjds1" TableLayout="Fixed">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator  column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="prjidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="prjidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="prjcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="prjcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="100px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="prjds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="prjds1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="110px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnProjectRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                            </div>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>


                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="rfvddlProject" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlProject"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="subprjcod" Visible="true" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="subprjcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Sub Project" UniqueName="subprjcod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSubProjectCode" runat="server" Text='<%# Eval("subprjcod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" id="subprj" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlSubProject" runat="server"
                                                                    Width="180px" DropDownWidth="180px" OnPreRender="ddlSubProject_PreRender"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdSubProject4DDL" runat="server" AllowSorting="True" OnItemCommand="rGrdSubProject4DDL_ItemCommand"
                                                                            AutoGenerateColumns="False" AllowFilteringByColumn="true" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdSubProject4DDL_NeedDataSource"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <GroupingSettings CaseSensitive="false" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="subprjidd,subprjcod,subprjds1"
                                                                                ClientDataKeyNames="subprjidd,subprjcod,subprjds1" TableLayout="Fixed">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator  column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="subprjidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="subprjidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="subprjcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="subprjcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="100px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="subprjds1" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Description" UniqueName="subprjds1" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="110px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnSubProjectRowClicked"></ClientEvents>
                                                                            </ClientSettings>
                                                                            <FilterMenu EnableImageSprites="False">
                                                                            </FilterMenu>
                                                                        </telerik:RadGrid>
                                                                            </div>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>


                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px">
                                                            <%--<asp:RequiredFieldValidator ID="rfvddlSubProject" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlProject"></asp:RequiredFieldValidator>--%>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="poscod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="poscod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Position" UniqueName="poscod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpPos" runat="server" Text='<%# Eval("poscod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" id="empPos" style="border-bottom: 0px; padding-left: 0px">
                                                             <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlEmpPos" runat="server"
                                                                    Width="180px" DropDownWidth="180px" OnPreRender="ddlEmpPos_PreRender"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdEmpPos4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" 
                                                                                AutoGenerateColumns="False" AllowFilteringByColumn="true" ClientSettings-ClientEvents-OnRowSelected="closeddl"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmpPos4DDL_NeedDataSource" OnItemCommand="rGrdEmpPos4DDL_ItemCommand"
                                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <GroupingSettings CaseSensitive="false" />
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="posidd,poscod" ClientDataKeyNames="posidd,poscod">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="2px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>

                                                                                        <telerik:GridBoundColumn DataField="posidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="PosID" UniqueName="posidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="poscod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="PosCode" UniqueName="poscod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>

                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowClick="OnEmpPosRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                        </div>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                            </span>
                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px">
                                                            <asp:RequiredFieldValidator ID="rfvddlEmpPos" Style="float: left" runat="server"
                                                                ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlEmpPos"></asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>


                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn UniqueName="IsPublicHoliday" DataField="IsPublicHoliday" ItemStyle-Width="0px" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn UniqueName="IsWeekend" DataField="IsWeekend" ItemStyle-Width="0px" Display="false">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridTemplateColumn DataField="attcmt" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="attcmt" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Comments" UniqueName="attcmt">
                                            <ItemTemplate>
                                                <asp:Label ID="lblattcmt" runat="server" Text='<%# Eval("attcmt") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <%--<telerik:RadTextBox ID="txtattcmt" MaxLength="50" TextMode="MultiLine" runat="server" Text='<%# Eval("attcmt") %>'>
                                                            </telerik:RadTextBox>--%>
                                                            <asp:TextBox ID="txtattcmt" runat="server" MaxLength="250" TextMode="MultiLine" style="resize:none;height: 37px;width: 175px;"  Text='<%# Eval("attcmt") %>'></asp:TextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px"></td>
                                                    </tr>
                                                </table>
                                            </EditItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="False" FilterControlAltText="Filter CopyToToday column" UniqueName="CopyToToday">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnCopyToToday" ImageUrl="~/Images/CopyToday.png" runat="server" CommandArgument='<%# Eval("recidd") %>' CommandName="CopyToToday" ToolTip="Copy to today"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="False" FilterControlAltText="Filter CopyToTomorrow column" UniqueName="CopyToTomorrow">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnCopyToTomorrow" ImageUrl="~/Images/CopyTomorrow.png" runat="server" CommandArgument='<%# Eval("recidd") %>' CommandName="CopyToTomorrow" ToolTip="Copy to tomorrow"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="False" FilterControlAltText="Filter CopyToN column" UniqueName="CopyToN">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnCopyToN" ImageUrl="~/Images/CopyTomorrow.png" runat="server" CommandArgument='<%# Eval("recidd") %>' CommandName="CopyToN" ToolTip="Copy to N"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditFiles"
                                            ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" />
                                        </telerik:GridEditCommandColumn>

                                        
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                            ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteAtt">
                                            <ItemStyle HorizontalAlign="Center" Width="0px" />
                                        </telerik:GridButtonColumn>


                                    </Columns>
                                    <EditFormSettings CaptionFormatString='Edit detail of attendance id : "{0}"' CaptionDataField="recidd">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>

                            </telerik:RadGrid>
                            <div class="clear"> </div>

                            <div class="wizButtons">
                                <span class="wNavButtons">

                                    <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save" Visible ="false"
                                        ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"></asp:Button>


                                    <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click" OnClientClick="if ( ! ConfirmSubmit()) return false;"
                                        Text="Save and Submit" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="true"></asp:Button>
                                </span>
                            </div>
                        </div>


                        <asp:Panel ID="ApprovalPanel" runat="server">
                                <div class="widget" >
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                        <h6>Decision Remarks</h6>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Remarks:</label>
                                            <div class="formRight">
                                                <telerik:RadTextBox ID="txtremarks" runat="server" MaxLength="50">
                                                </telerik:RadTextBox>
                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                </div>

                                <div class="widget">
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                        <h6>Select User to Revise/Review</h6>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>User:</label>
                                            <div class="formRight">
                                                <span class="combo180">
                                                <telerik:RadComboBox ID="rCmbLevels" runat="server" Width="180px" DropDownWidth="180px" EmptyMessage="Please select...">
                                                    <ItemTemplate>
                                                        <telerik:RadGrid ID="rGrdLevels4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="ID" ClientDataKeyNames="ID">

                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                                        HeaderText="ID" UniqueName="column">
                                                                    </telerik:GridBoundColumn>

                                                                    <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                                        HeaderText="Level" UniqueName="column">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="ApprovedByUserID" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="User" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="RequestStatusID" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="RequestStatusID" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="RowClickedRevise"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                        
                                                    </ItemTemplate>
                                                    <Items>
                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                    </Items>
                                                </telerik:RadComboBox>
                                                    </span>
                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                </div>
                                <%--end--%>

                                <div class="wizButtons">
                                    <span class="wNavButtons">

                                        <asp:Button ID="rBtnApprove" runat="server"  Text="Approve"
                                            ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="True" OnClick="rBtnApprove_Click"></asp:Button>

                                        <asp:Button ID="rBtnReject" runat="server" 
                                            Text="Reject" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True" OnClick="rBtnReject_Click"></asp:Button>

                                        <asp:Button ID="rBtnRevise" runat="server" 
                                            Text="Revise" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True" OnClick="rBtnRevise_Click"></asp:Button>
                                    </span>
                                </div>
                                <div class="clear"></div>
                                <%--start--%>
                            <div class="widget">
                                <div class="formRight">
                                    <telerik:RadGrid ID="gvHistory" runat="server" AllowPaging="True" AllowSorting="True"
                                        AllowFilteringByColumn="false" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                        OnNeedDataSource="gvHistory_NeedDataSource" PageSize="20"
                                        ShowStatusBar="false" OnItemCommand="gvHistory_ItemCommand"
                                        OnItemDataBound="gvHistory_ItemDataBound">
                                        <FilterMenu EnableImageSprites="False">
                                        </FilterMenu>
                                        <ClientSettings>
                                            <Selecting CellSelectionMode="None"></Selecting>
                                        </ClientSettings>
                                        <ExportSettings
                                            HideStructureColumns="true"
                                            ExportOnlyData="true"
                                            IgnorePaging="true"
                                            OpenInNewWindow="true">
                                            <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                                            <Pdf PaperSize="A4">
                                            </Pdf>
                                        </ExportSettings>
                                        <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="ID"
                                            InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                            <DetailTables>
                                            </DetailTables>
                                            <CommandItemTemplate>
                                                <tr class="rgCommandRow">
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/users.png" alt="" class="titleIcon" /><h6>Request History</h6>
                                                        <div class="num">
                                                            <a class="blueNum">
                                                                <asp:Literal ID="ltNotiCount" runat="server"></asp:Literal></a>
                                                        </div>
                                                    </div>
                                                    <td colspan="10" class="rgCommandCell">

                                                        <table style="width: 100%;" summary="Command item for additional functionalities for the grid like adding a new record and exporting." class="rgCommandTable">
                                                            <caption>

                                                                <span style="display: none">Command item</span>
                                                            </caption>
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col"></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr>
                                                                    <td align="left"></td>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnNotificationRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteracteText="Refresh" ToolTip="Refresh" />
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </CommandItemTemplate>
                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                            </ExpandCollapseColumn>
                                            <Columns>
                                                <telerik:GridBoundColumn DataField="ID" Visible="false" SortExpression="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="ID" ReadOnly="True" DataType="System.Int32">
                                                    <ColumnValidationSettings>
                                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                                    </ColumnValidationSettings>
                                                    <FilterTemplate>
                                                        <strong>Search</strong>
                                                    </FilterTemplate>
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="ApprovedByUserID" FilterControlWidth="130px" SortExpression="ApprovedByUserID"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Approved By User" UniqueName="ApprovedByUserID">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblApprovedByUserID" runat="server" Text='<%# Eval("ApprovedByUserID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="UpdateDate" FilterControlWidth="130px" SortExpression="UpdateDate"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Update Date" UniqueName="UpdateDate">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUpdateDate" runat="server" Text='<%# Eval("UpdateDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Remarks" FilterControlWidth="130px" SortExpression="Remarks"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Remarks" UniqueName="Remarks">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRemarks" runat="server" Text='<%# Eval("Remarks") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="Transremarks" FilterControlWidth="130px" SortExpression="Transremarks"
                                                    AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Trans Remarks" UniqueName="Transremarks">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTransremarks" runat="server" Text='<%# Eval("Transremarks") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            </Columns>
                                            <EditFormSettings CaptionFormatString='Edit Details for Notification "{0}":' CaptionDataField="ID">
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                                <EditColumn ButtonType="ImageButton" />
                                            </EditFormSettings>
                                        </MasterTableView>
                                    </telerik:RadGrid>
                                </div>
                            </div>
                                <%--end--%>

                            </asp:Panel>
                    </fieldset>
                    
                </div>
                <div id="tab2" class="tab_content">

                    <fieldset>
                        <%--<div class="widget12">--%>
                        <div class="wEmployeePreview">
                            <div class="title2">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>Saved requests by current user</h6i>
                            </div>
                            <telerik:RadGrid ID="gvSavedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSavedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" 
                                OnItemCreated="gvSavedRequests_ItemCreated" OnItemCommand="gvSavedRequests_ItemCommand" OnDetailTableDataBind="gvSavedRequests_DetailTableDataBind" 
                                OnItemDataBound="gvSavedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None" AllowRowSelect="true"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="recidd" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">
                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="RequestStatusDesc" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>
                                    </DetailTables>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TransactionNumber" SortExpression="TransactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="TRX. NO." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="DATE" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" FilterControlAltText="Filter column3 column"
                                            HeaderText="EMPLOYEE" UniqueName="column3" Visible ="false" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="submittedbyuser" SortExpression="submittedbyuser" FilterControlAltText="Filter column4 column"
                                            HeaderText="SUBMITTED BY" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="ViewEdit" CommandArgument='<%# Eval("recidd") + ";" +Eval("TransactionNumber")%>' ImageUrl="~/Images/16x16_pencil.png"
                                                    ToolTip="Edit this request." /><%--Visible='<%# isEditVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'--%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnSubmit" runat="server" CommandName="Submit" ImageUrl="~/Images/16x16_tick2.png"
                                                    
                                                    ToolTip="Submit Now!" CommandArgument='<%# Eval("recidd") %>' /><%--Visible='<%# isSubmitVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'--%>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnDelete" runat="server" ImageUrl="~/Images/Delete.png"
                                                    AlternateText="Delete" ToolTip="Delete Request" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="Delete" OnClientClick="javascript:if(!confirm('Are you sure to delete the selected transaction?')){return false;}" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("recidd") + ";" +Eval("TransactionNumber")%>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px"/>
                                            <ItemStyle HorizontalAlign="Center"/>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="recidd">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>

                        </div>
                    </fieldset>
                </div>
                <div id="tab3" class="tab_content">

                    <fieldset>
                        <div class="widget13">
                            <div class="title3">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>Requests submitted for decision by current user</h6i>
                            </div>

                            <telerik:RadGrid ID="gvSubmittedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSubmittedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSubmittedRequests_DetailTableDataBind"
                                OnItemCreated="gvSubmittedRequests_ItemCreated" OnItemCommand="gvSubmittedRequests_ItemCommand"
                                OnItemDataBound="gvSubmittedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                </ClientSettings>
                                <MasterTableView Name="entryview" AutoGenerateColumns="False" DataKeyNames="recidd" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">
                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>

                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="RequestStatusDesc" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>
                                    </DetailTables>
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>

                                    <Columns>
                                        <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TransactionNumber" SortExpression="TransactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="TRX. NO." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="DATE" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" visible ="false" FilterControlAltText="Filter column3 column"
                                            HeaderText="EMPLOYEE" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="submittedbyuser" SortExpression="submittedbyuser" FilterControlAltText="Filter column4 column"
                                            HeaderText="SUBMITTED BY" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnRecall" runat="server" CommandName="Recall" CommandArgument='<%# Eval("recidd") %>' ImageUrl="~/Images/16x16_recall.png"
                                                    ToolTip="Recall request." /><%--Visible='<%# isRecallVisible(Convert.ToString(Eval("Last_Status_ID")),int.Parse(Convert.ToString(Eval("EmployeeUserID")))) %>'--%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("recidd") + ";" +Eval("TransactionNumber")%>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px"/>
                                            <ItemStyle HorizontalAlign="Center"/>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="recidd">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                <div id="tab4" class="tab_content">
                    <fieldset>
                        <div class="widget14">
                            <div class="title4">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>Requests pending for deicision by current user</h6i>
                            </div>

                            <telerik:RadGrid ID="gvPendingAppRequests" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                OnNeedDataSource="gvPendingAppRequests_NeedDataSource" PageSize="20" ShowStatusBar="True"
                                OnItemCreated="gvPendingAppRequests_ItemCreated" OnItemCommand="gvPendingAppRequests_ItemCommand"
                                OnItemDataBound="gvPendingAppRequests_ItemDataBound" OnDetailTableDataBind="gvPendingAppRequests_DetailTableDataBind">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID,RequestStatusID"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" AllowMultiColumnSorting="true"
                                    EditMode="EditForms">

                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="RequestStatusDesc" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>
                                    </DetailTables>

                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="RequestID" SortExpression="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TransactionNumber" SortExpression="TransactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="TRX. NO." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="DATE" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" Visible="false" FilterControlAltText="Filter column3 column"
                                            HeaderText="EMPLOYEE" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="submittedbyuser" SortExpression="submittedbyuser" FilterControlAltText="Filter column4 column"
                                            HeaderText="SUBMITTED BY" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnApprove" runat="server" CommandName="Approve" CommandArgument='<%#  Eval("RequestID")+ ";" +Eval("RequestStatusID") %>' ImageUrl="~/Images/16x16_Check.png"
                                                    ToolTip="Approve/Reject this request."  />  <%-- Visible='<%# int.Parse(Eval("Priority").ToString()) == 1 %>'--%>
                                                <%--<asp:Image ID="imgApproved" runat="server" ImageUrl="~/Images/16x16_approved.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 2 %>'
                                                    ToolTip="This Request is Approved." />
                                                <asp:Image ID="imgReject" runat="server" ImageUrl="~/Images/16x16_rejected.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 3 %>'
                                                    ToolTip="This Request is Rejected." />--%>

                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") + ";" +Eval("TransactionNumber")%>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px"/>
                                            <ItemStyle HorizontalAlign="Center"/>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <EditFormSettings CaptionFormatString='Edit Details for this Suggestion "{0}":' CaptionDataField="RequestID">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
                <div id="tab5" class="tab_content">

                    <fieldset>
                        <div class="widget15">
                            <div class="title5">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>Requests with decisions by current user</h6i>
                            </div>


                            <telerik:RadToolTipManager ID="RadToolTipManager3" runat="server" Position="BottomCenter"
                                Animation="Fade" RelativeTo="Element" Style="font-size: 18px; text-align: center; font-family: Arial;"
                                RenderInPageRoot="true" OnClientShow="OnClientShow" OnClientHide="OnClientHide" Width="900" Height="500">
                            </telerik:RadToolTipManager>

                            <telerik:RadGrid ID="gvApprovedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                PageSize="20" ShowStatusBar="True"
                                OnNeedDataSource="gvApprovedRequests_NeedDataSource"
                                OnDetailTableDataBind="gvApprovedRequests_DetailTableDataBind"
                                OnItemCreated="gvApprovedRequests_ItemCreated"
                                OnItemCommand="gvApprovedRequests_ItemCommand"
                                OnItemDataBound="gvApprovedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms">

                                    <DetailTables>
                                        <telerik:GridTableView runat="server" Name="RequestStatuses" AllowMultiColumnSorting="true">
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </RowIndicatorColumn>
                                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                                <HeaderStyle Width="20px" />
                                            </ExpandCollapseColumn>
                                            <Columns>

                                                <telerik:GridBoundColumn DataField="ID" FilterControlAltText="Filter column column"
                                                    HeaderText="ID" UniqueName="column6" ReadOnly="True" Visible="false">
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="UserLevel" FilterControlAltText="Filter column column"
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="RequestStatusDesc" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
                                            <SortExpressions>
                                                <telerik:GridSortExpression FieldName="UpdateDate" SortOrder="Descending" />
                                                <telerik:GridSortExpression FieldName="ID" SortOrder="Descending" />
                                            </SortExpressions>
                                            <EditFormSettings>
                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                </EditColumn>
                                            </EditFormSettings>
                                        </telerik:GridTableView>
                                    </DetailTables>

                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>
                                    <Columns>
                                        <telerik:GridBoundColumn DataField="RequestID" SortExpression="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TransactionNumber" SortExpression="TransactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="TRX. NO." UniqueName="TransactionNumber" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="DATE" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" Visible ="false" FilterControlAltText="Filter column3 column"
                                            HeaderText="EMPLOYEE" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="submittedbyuser" SortExpression="submittedbyuser" FilterControlAltText="Filter column4 column"
                                            HeaderText="SUBMITTED BY" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>


                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumnsdf1" HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Image ID="imgCompletsdfed" runat="server" ImageUrl='<%# getImagePathForTrue((Eval("status").ToString())) %>'
                                                    ToolTip="Request Status" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request"  CommandArgument='<%# Eval("RequestID") + ";" +Eval("TransactionNumber")%>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px"/>
                                            <ItemStyle HorizontalAlign="Center"/>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="RequestID">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>
            </asp:Panel>
        </div>
        <div class="clear"></div>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 10000;">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Modal="true"
                Width="1000px" Height="580px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="580px" MaxHeight="580px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow2" runat="server" Modal="true" Title="Approve or reject request"
                Width="1000px" Height="580px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="480px" MaxHeight="580px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindowOrgChart" runat="server" Modal="true" Title="Workflow Details"
                Width="800px" Height="500px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="false" MinHeight="480px" MaxHeight="500px"
                MinWidth="800px" MaxWidth="800px">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" IsSticky="true" />
</asp:Content>
