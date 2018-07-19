<%@ Page Title="Reimbursement Request" MetaDescription="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="ReimbursmentT2.aspx.cs" Inherits="ReimbursmentT2" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>
<%@ Register Src="~/Controls/ucEmployeeLeaveBalance.ascx" TagPrefix="uc1" TagName="ucEmployeeLeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <style type="text/css">
        .rgEditForm > table tr
         {
             height: 0px!important;
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
        .ruFileWrap > input
        {
            width: 167px!important;
        }
        .RadUpload .ruRemove
        {
            display: inline;
        }
        .RadUpload_Silk .ruUploadProgress
        {
            padding-right: 1px;
            font-size: 12px;
            width: 84px;
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
            .rgEditForm > table tr td:first-child
            {
                min-width: 50px;
            }
        }
    </style>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

            //$(document).ready(function () {
            //    $telerik.$('.ruFileInput').attr('accept', 'image/*');
            //});

            //function pageLoad() {
            //    $telerik.$('.ruFileInput').attr('accept', 'image/*');
            //}
           
            function togleDisplay() {
                $('#panel').toggle();
            }

            function OnValueChanged(sender, args) {
                
                var txteval = $("#txtExpenseValue").val();
                var txtrate = $("#txtRate").val();
                var eval = parseFloat($("#txtExpenseValue").val());
                var rate = parseFloat($("#txtRate").val());
                var txttx1 = $("#txttx1").val();
                var tx1val = parseFloat($("#txttx1").val());
                var txttx2 = $("#txttx2").val();
                var tx2val = parseFloat($("#txttx2").val());
                var txttx3 = $("#txttx3").val();
                var tx3val = parseFloat($("#txttx3").val());

                if (txttx1 == '') {
                    $("#txttx1").val('0')
                }
                if (txttx2 == '') {
                    $("#txttx2").val('0')
                }
                if (txttx3 == '') {
                    $("#txttx3").val('0')
                }
                var tax1 = 0, tax2 = 0, tax3 = 0;
                
                if ($("#txtRate").is(':Visible')) {
                    if (txteval != '' && txteval != null && txtrate != '' && txtrate != null) {
                        var subtotal = eval * rate;
                        $("#txtSubTotal").val(subtotal);

                        if (txttx1 != '' && txttx1 != null) {
                            tax1 = subtotal * tx1val / 100.0;
                        }
                        if (txttx2 != '' && txttx2 != null) {
                            tax2 = subtotal * tx2val / 100.0;
                        }
                        if (txttx3 != '' && txttx3 != null) {
                            tax3 = subtotal * tx3val / 100.0;
                        }
                        
                        var total = subtotal + tax1 + tax2 + tax3;
                        $("#txtTotalValue").val(total);
                    }

                    else {
                        $("#txtSubTotal").val('');
                        $("#txtTotalValue").val('');
                    }
                }
                else {
                    if (txteval != '' && txteval != null ) {

                        if (txttx1 != '' && txttx1 != null) {
                            tax1 = eval * tx1val / 100.0;
                        }
                        if (txttx2 != '' && txttx2 != null) {
                            tax2 = eval * tx2val / 100.0;
                        }
                        if (txttx3 != '' && txttx3 != null) {
                            tax3 = eval * tx3val / 100.0;
                        }
                        
                        var total = eval + tax1 + tax2 + tax3;
                    $("#txtTotalValue").val(total);
                }
                
                else {
                    $("#txtTotalValue").val('');
                }
            }
            }

            function ValidateReimb(ddlEmployeeID, ddlEmpPosID, ddlProjectID, dtpDateID,ddlCountryID,ddlProvinceID, txtreimcmtID) {
                var str = '';
                if ($('#' + ddlEmployeeID).val() == undefined || $('#' + ddlEmployeeID).val() == "") {
                    str += 'Employee Code Required.<br/>';
                }

                if ($('#' + dtpDateID).val() == undefined || $('#' + dtpDateID).val() == "") {
                    str += 'Date Required.<br/>';
                }

                if (($('#' + ddlProjectID).val() == undefined || $('#' + ddlProjectID).val() == "") && $('#' + ddlProjectID).is(':visible')) {
                    str += 'Project Required.<br/>';
                }

                if ($('#' + ddlEmpPosID).val() == undefined || $('#' + ddlEmpPosID).val() == "") {
                    str += 'Employee Position Required.<br/>';
                }
                
                if ($('#' + ddlCountryID).val() == undefined || $('#' + ddlCountryID).val() == "") {
                    str += 'Country Required.<br/>';
                }
                if ($('#' + ddlProvinceID).val() == undefined || $('#' + ddlProvinceID).val() == "") {
                    str += 'Province Required.<br/>';
                }
                
                //if ($('#' + txtreimcmtID).val() == undefined || $('#' + txtreimcmtID).val() == "") {
                //    str += 'Comments Required.<br/>';
                //}
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpenseType(ddlExpenseTypeID,ddlExpSubTypeID, txtExpenseValueID, txtTotalValueID) {
                var str = '';
                if ($('#' + ddlExpenseTypeID).val() == undefined || $('#' + ddlExpenseTypeID).val() == "") {
                    str += 'Expense Type Required.<br/>';
                }
                if (($('#' + ddlExpSubTypeID).val() == undefined || $('#' + ddlExpSubTypeID).val() == "") && $('#' + ddlExpSubTypeID).is(':visible')) {
                    str += 'Expense Sub Type Required.<br/>';
                }
                if ($('#' + txtExpenseValueID).val() == undefined || $('#' + txtExpenseValueID).val() == "") {
                    str += 'Expense Value Required.<br/>';
                }
                
                if ($('#' + txtTotalValueID).val() == undefined || $('#' + txtTotalValueID).val() == "") {
                    str += 'Total Value Required.<br/>';
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
                }, 50);
            }
            function OnExpenseTypeOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("exptcod");
                var id = args.getDataKeyValue("exptidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpenseTypeOuter4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden1').click();
                }, 50);
            }

            function OnExpenseTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("exptcod");
                var id = args.getDataKeyValue("exptidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpenseType4DDL', ''));
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
            
            function UpdateAllConfirmation() {
                return confirm("Are you sure you want to update all normal hours?");
            }

            function OnEmployeeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                //setTimeout(function () {
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(id);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
                $('#btnHidden').click();
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
                $('#btnHidden3').click();
                // $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_btnHidden').click();
                // }, 50);
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

            function OnCountryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ctrcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCountry4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden').click();
                }, 50);
            }
            function OnProvinceRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("prvcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdProvince4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function OnExpSubTypeOuterRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("expsubtcod");
                var id = args.getDataKeyValue("expsubtidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpSubTypeOuter4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }
            function OnExpSubTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("expsubtcod");
                var id = args.getDataKeyValue("expsubtidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpSubType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                    $('#btnHidden2').click();
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
                if (
                    args.get_eventTarget().indexOf("btnFilesExcelExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnFilesCsvExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnFilesPdfExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnFilesPrint") >= 0 ||
                    args.get_eventTarget().indexOf("btnFilesRefresh") >= 0 ||
                    args.get_eventTarget().indexOf("btnAttendanceDetailExcelExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnAttendanceDetailCsvExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnAttendanceDetailPdfExport") >= 0 ||
                    args.get_eventTarget().indexOf("btnAttendanceDetailPrint") >= 0 ||
                    args.get_eventTarget().indexOf("btnAttendanceDetailRefresh") >= 0 ||
                    args.get_eventTarget().indexOf("lbtnDownload") >= 0 ||
                    args.get_eventTarget().indexOf("lbtnView") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
                else {
                    currentLoadingPanel = $find("<%= RadAjaxLoadingPanel1.ClientID %>");
                    currentUpdatedControl = "<%= pnlAjaxForm.ClientID %>";
                    currentLoadingPanel.show(currentUpdatedControl);
                }
            }
            function SetTarget() {
                document.forms[0].target = "_blank";
            }

            function ResponseEnd() {
                //hide the loading panel and clean up the global variables
                if (currentLoadingPanel != null)
                    currentLoadingPanel.hide(currentUpdatedControl);
                currentUpdatedControl = null;
                currentLoadingPanel = null;
            }

            (function () {

                window.onClientFileUploaded = function (radAsyncUpload, args) {
                    var row = args.get_row(),
                        inputName = radAsyncUpload.getAdditionalFieldID("TextBox"),
                        inputType = "text",
                        inputID = inputName,
                        input = createInput(inputType, inputID, inputName),
                        label = createLabel(inputID),
                        br = document.createElement("br");

                    row.appendChild(br);
                    row.appendChild(label);
                    row.appendChild(input);
                }

                function createInput(inputType, inputID, inputName) {
                    var input = document.createElement("input");

                    input.setAttribute("type", inputType);
                    input.setAttribute("id", inputID);
                    input.setAttribute("name", inputName);

                    input.style.width = "120px";


                    return input;
                }

                function createLabel(forArrt) {
                    var label = document.createElement("label");

                    label.setAttribute("for", forArrt);
                    label.innerHTML = "File info: ";
                    label.style.width = "150px";
                    label.style.paddingRight = "5px";
                    return label;
                }

            })();

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
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"   />
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
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
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
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"   />
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"   />
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvReimbursment">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSaveAndSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        
        
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnNewEntries">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSaveAndSubmit"/>
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnApprove">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
                     <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnReject"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnRevise"/>
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnReject">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvReimbursment"/>
                     <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnApprove"/>
                    <telerik:AjaxUpdatedControl ControlID="rBtnRevise"/>
                    <telerik:AjaxUpdatedControl ControlID="TopPanel"   />
                    <telerik:AjaxUpdatedControl ControlID="ApprovalPanel"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ddlEmployee">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ddlEmpPos"/>
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
            <telerik:AjaxSetting AjaxControlID="rcbExpenseType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbExpenseType"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rcbExpSubType">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rcbExpSubType"/>
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
            <telerik:AjaxSetting AjaxControlID="rGrdProjectOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdProjectOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdExpenseTypeOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdExpenseTypeOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdExpSubTypeOuter4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdExpSubTypeOuter4DDL"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
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
            <telerik:AjaxSetting AjaxControlID="rGrdExpenseType4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdExpenseType4DDL"/>
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
                    <telerik:AjaxUpdatedControl ControlID="ddlEmployeeOuter"/>
                    <telerik:AjaxUpdatedControl ControlID="ddlExpenseTypeOuter"/>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
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
                    <label class="tabLabelVisible">Decisions Made</label>
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
                                        <h6 style="padding-top:10px">Default Values</h6>
                                    </div>
                                </button>
                                <div id="panel">
                                    <table style="margin-top: 20px">
                                        <tr>
                                            <td>
                                                <div class="OuterddlsDiv">
                                                    <asp:Label ID="Label2" runat="server" Text="Employee:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                    <span class="combo180" style="float: left;">
                                                        <asp:Button ID="btnHidden3" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                        <telerik:RadComboBox ID="ddlEmployeeOuter" runat="server"
                                                            Width="180px" DropDownWidth="180px"
                                                            EmptyMessage="Please select..." OnSelectedIndexChanged="ddlEmployeeOuter_SelectedIndexChanged">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 200px;">
                                                                    <telerik:RadGrid ID="rGrdEmployeeOuter4DDL" AllowMultiRowSelection="false" runat="server" AllowFilteringByColumn="true" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployeeOuter4DDL_NeedDataSource" Width="180px" ClientSettings-EnableRowHoverStyle="True">
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
                                                    <telerik:RadCheckBox ID="rcbEmployeeddl" runat="server" Text="" Style="margin-left: 10px;"></telerik:RadCheckBox>
                                                </div>
                                                <div class="OuterddlsDiv">
                                                    <asp:Label ID="Label1" runat="server" Text="Project:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                    <span class="combo180" style="float: left;">
                                                        <telerik:RadComboBox ID="ddlProjectOuter" runat="server"
                                                            Width="180px" DropDownWidth="180px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 200px;">
                                                                    <telerik:RadGrid ID="rGrdProjectOuter4DDL" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                        AutoGenerateColumns="False"
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
                                                    <telerik:RadCheckBox ID="rcbProject" runat="server" Text="" Style="margin-left: 10px;"></telerik:RadCheckBox>
                                                </div>

                                                <div class="OuterddlsDiv">
                                                    <asp:Label ID="Label3" runat="server" Text="Expense Type:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                    <span class="combo180" style="float: left;">
                                                        <asp:Button ID="btnHidden1" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                        <telerik:RadComboBox ID="ddlExpenseTypeOuter" runat="server"
                                                            Width="180px" DropDownWidth="180px"
                                                            EmptyMessage="Please select..." OnSelectedIndexChanged="ddlExpenseTypeOuter_SelectedIndexChanged">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 200px;">
                                                                    <telerik:RadGrid ID="rGrdExpenseTypeOuter4DDL" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                        AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpenseTypeOuter4DDL_NeedDataSource"
                                                                        Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <GroupingSettings CaseSensitive="false" />
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        </ClientSettings>

                                                                        <MasterTableView DataKeyNames="exptidd,exptcod,expttitle"
                                                                            ClientDataKeyNames="exptidd,exptcod,expttitle">
                                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                            </RowIndicatorColumn>
                                                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                            </ExpandCollapseColumn>
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="exptidd" Visible="false" FilterControlAltText="Filter exptidd column"
                                                                                    HeaderText="ID" UniqueName="exptidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="exptcod" FilterControlAltText="Filter exptcod column"
                                                                                    HeaderText="Code" UniqueName="exptcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="expttitle" FilterControlAltText="Filter expttitle column"
                                                                                    HeaderText="Title" UniqueName="expttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                            <EditFormSettings>
                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                </EditColumn>
                                                                            </EditFormSettings>
                                                                        </MasterTableView>
                                                                        <ClientSettings>
                                                                            <ClientEvents OnRowClick="OnExpenseTypeOuterRowClicked"></ClientEvents>
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
                                                    <telerik:RadCheckBox ID="rcbExpenseType" runat="server" Text="" Style="margin-left: 10px;"></telerik:RadCheckBox>
                                                </div>

                                                <div class="OuterddlsDiv">
                                                    <asp:Label ID="Label4" runat="server" Text="Expense Sub Type:" meta:resourcekey="Label" class="ddlLabel"></asp:Label>
                                                    <span class="combo180" style="float: left;">
                                                        <telerik:RadComboBox ID="ddlExpSubTypeOuter" runat="server"
                                                            Width="180px" DropDownWidth="180px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 200px;">
                                                                    <telerik:RadGrid ID="rGrdExpSubTypeOuter4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpSubTypeOuter4DDL_NeedDataSource"
                                                                        Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <GroupingSettings CaseSensitive="false" />
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        </ClientSettings>
                                                                        <MasterTableView DataKeyNames="expsubtidd,expsubtcod,expsubttitle" ClientDataKeyNames="expsubtidd,expsubtcod,expsubttitle">
                                                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                            </RowIndicatorColumn>
                                                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                <HeaderStyle Width="2px"></HeaderStyle>
                                                                            </ExpandCollapseColumn>
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="expsubtidd" Visible="false" FilterControlAltText="Filter expsubtidd column"
                                                                                    HeaderText="Id" UniqueName="expsubtidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="expsubtcod" FilterControlAltText="Filter expsubtcod column"
                                                                                    HeaderText="Code" UniqueName="expsubtcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="expsubttitle" FilterControlAltText="Filter expsubttitle column"
                                                                                    HeaderText="Title" UniqueName="expsubttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                </telerik:GridBoundColumn>

                                                                            </Columns>
                                                                            <EditFormSettings>
                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                </EditColumn>
                                                                            </EditFormSettings>
                                                                        </MasterTableView>
                                                                        <ClientSettings>
                                                                            <ClientEvents OnRowClick="OnExpSubTypeOuterRowClicked"></ClientEvents>
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
                                                    <telerik:RadCheckBox ID="rcbExpSubType" runat="server" Text="" Style="margin-left: 10px;"></telerik:RadCheckBox>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                            </asp:Panel>
                          
                            <telerik:RadGrid ID="gvReimbursment" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvReimbursment_InsertCommand"
                                OnNeedDataSource="gvReimbursment_NeedDataSource" PageSize="31" OnDeleteCommand="gvReimbursment_DeleteCommand"
                                OnUpdateCommand="gvReimbursment_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvReimbursment_ItemDataBound"
                                OnItemCommand="gvReimbursment_ItemCommand" OnDetailTableDataBind="gvReimbursment_DetailTableDataBind"
                                OnItemCreated="gvReimbursment_ItemCreated" OnPreRender="gvReimbursment_PreRender">
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
                                    DataKeyNames="prmidd,recidd,empidd,Date,empcod,prjcod,prjidd,posidd,poscod,reimcmt,prvidd"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                    <DetailTables>
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="EditForms" 
                                            Name="ExpenseType" CommandItemDisplay="Top" DataKeyNames="recidd,exptidd,exptcod,expsubtidd,expsubtcod,expval">   
                                                <CommandItemTemplate>
                                                    <%--<div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense List</h6>
                                                    </div>--%>
                                                    <tr class="rgCommandRow">

                                                        <td colspan="15" class="rgCommandCell">

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
                                                                            <asp:Button ID="btnLdAdd" runat="server" CssClass="rgAdd" style="float:left" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                            <h6 class="heading">Expense List</h6>
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

                                                <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="EditForms"
                                                    Name="Attachments" CommandItemDisplay="Top" DataKeyNames="idd">
                                                    <CommandItemTemplate>
                                                        <%--<div class="title">
                                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Attachments</h6>
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
                                                                                <asp:Button ID="btnLddAdd" Visible="false" runat="server" CssClass="rgAdd" Style="float:left" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                                <h6 class="heading">Attachments</h6>
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
                                                    </DetailTables>
                                                    <Columns>
                                                        <telerik:GridTemplateColumn DataField="documentname" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="documentname"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter documentname column"
                                                            HeaderText="Document Name" UniqueName="documentname">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDocName" runat="server" Text='<%# Eval("documentname") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="documenttype" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="documenttype"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter documenttype column"
                                                            HeaderText="Document Type" UniqueName="documenttype">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDocType" runat="server" Text='<%# Eval("documenttype") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn DataField="description" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="description"
                                                            CurrentFilterFunction="Contains" FilterControlAltText="Filter description column"
                                                            HeaderText="Description" UniqueName="description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("description") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnDownload" runat="server" Text="Download" CommandName="Download" ToolTip="Download">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridTemplateColumn>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnView" runat="server" Text="View" CommandName="View" ToolTip="View" OnClientClick = "SetTarget();">
                                                                </asp:LinkButton>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>

                                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                                            ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                            UniqueName="DeleteAttachment">
                                                            <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                        </telerik:GridButtonColumn>
                                                    
                                                    </Columns>
                                                    <SortExpressions>
                                                        <telerik:GridSortExpression FieldName="idd" SortOrder="Ascending" />
                                                    </SortExpressions>
                                                    <EditFormSettings>
                                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                        </EditColumn>
                                                    </EditFormSettings>
                                                </telerik:GridTableView>



                                            </DetailTables>
                                                <Columns>
                                                    <telerik:GridTemplateColumn DataField="exptcod" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="exptcod"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter exptcod column"
                                                        HeaderText="Expense Type" UniqueName="exptcod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblExpenseCode" runat="server" Text='<%# Eval("exptcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="expsubtcod" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="expsubtcod"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubtcod column"
                                                        HeaderText="Expense Sub Type" UniqueName="expsubtcod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblExpSubCode" runat="server" Text='<%# Eval("expsubtcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="expval" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="expval" CurrentFilterFunction="Contains" FilterControlAltText="Filter expval column"
                                                        HeaderText="Expense Value" UniqueName="expval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblExpenseValue" runat="server" Text='<%# Eval("expval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="unitval" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="unitval" CurrentFilterFunction="Contains" FilterControlAltText="Filter unitval column"
                                                        HeaderText="Rate" UniqueName="unitval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblunitval" runat="server" Text='<%# Eval("unitval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="subtotal" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="subtotal" CurrentFilterFunction="Contains" FilterControlAltText="Filter subtotal column"
                                                        HeaderText="Sub Total" UniqueName="subtotal">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsubtotal" runat="server" Text='<%# Eval("subtotal") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="tx1val" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="tx1val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx1val column"
                                                        HeaderText="Tax1 (%)" UniqueName="tx1val">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbltx1val" runat="server" Text='<%# Eval("tx1val") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="tx2val" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="tx2val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx2val column"
                                                        HeaderText="Tax2 (%)" UniqueName="tx2val">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbltx2val" runat="server" Text='<%# Eval("tx2val") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="tx3val" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="tx3val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx3val column"
                                                        HeaderText="Tax3 (%)" UniqueName="tx3val">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbltx3val" runat="server" Text='<%# Eval("tx3val") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="totalval" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="totalval" CurrentFilterFunction="Contains" FilterControlAltText="Filter totalval column"
                                                        HeaderText="Total" UniqueName="totalval">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalValue" runat="server" Text='<%# Eval("totalval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="expcmt" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="expcmt" CurrentFilterFunction="Contains" FilterControlAltText="Filter expcmt column"
                                                        HeaderText="Comments" UniqueName="expcmt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblreimcmt" runat="server" Text='<%# Eval("expcmt") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="expval" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="expval" CurrentFilterFunction="Contains" FilterControlAltText="Filter expval column"
                                                        HeaderText="Attachs" UniqueName="expv">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblExpense" runat="server" Text='<%# Eval("expval") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="EditExpenseDtl" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete the selected record?"
                                                        ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteExpenseDtl" >
                                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                    </telerik:GridButtonColumn>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings EditFormType="Template" >
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>

                                                    <FormTemplate>
                                                        <table style="empty-cells:hide;">
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblExpenseType" runat="server" Text="Expense Type:"></asp:Label>
                                                                </td>
                                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                        <span class="combo180" style="float: left;">
                                                                            <asp:Button ID="btnHidden2" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                            <telerik:RadComboBox ID="ddlExpenseType" runat="server"
                                                                                Width="180px" DropDownWidth="180px"
                                                                                EmptyMessage="Please select..." OnselectedIndexChanged="ddlExpenseType_SelectedIndexChanged">
                                                                                <ItemTemplate>
                                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                                        <telerik:RadGrid ID="rGrdExpenseType4DDL" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                                            AutoGenerateColumns="False"
                                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpenseType4DDL_NeedDataSource"
                                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                            <GroupingSettings CaseSensitive="false" />
                                                                                            <ClientSettings>
                                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                            </ClientSettings>

                                                                                            <MasterTableView DataKeyNames="exptidd,exptcod,expttitle"
                                                                                                ClientDataKeyNames="exptidd,exptcod,expttitle">
                                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </RowIndicatorColumn>
                                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </ExpandCollapseColumn>
                                                                                                <Columns>
                                                                                                    <telerik:GridBoundColumn DataField="exptidd" Visible="false" FilterControlAltText="Filter exptidd column"
                                                                                                        HeaderText="ID" UniqueName="exptidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="exptcod" FilterControlAltText="Filter exptcod column"
                                                                                                        HeaderText="Code" UniqueName="exptcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="expttitle" FilterControlAltText="Filter expttitle column"
                                                                                                        HeaderText="Title" UniqueName="expttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                </Columns>
                                                                                                <EditFormSettings>
                                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                    </EditColumn>
                                                                                                </EditFormSettings>
                                                                                            </MasterTableView>
                                                                                            <ClientSettings>
                                                                                                <ClientEvents OnRowClick="OnExpenseTypeRowClicked"></ClientEvents>
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
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlExpenseType"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    </tr>
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblExpSubType" runat="server" Text="Expense Sub Type:"></asp:Label>
                                                                </td>
                                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                        <span class="combo180" style="float: left;">
                                                                            <telerik:RadComboBox ID="ddlExpSubType" runat="server"
                                                                            Width="180px" DropDownWidth="180px" OnSelectedIndexChanged="ddlExpSubType_SelectedIndexChanged"
                                                                                EmptyMessage="Please select...">
                                                                                <ItemTemplate>
                                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                                        <telerik:RadGrid ID="rGrdExpSubType4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AllowFilteringByColumn="true"
                                                                                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpSubType4DDL_NeedDataSource"
                                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                            <GroupingSettings CaseSensitive="false" />
                                                                                            <ClientSettings>
                                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                            </ClientSettings>
                                                                                            <MasterTableView DataKeyNames="expsubtidd,expsubtcod,expsubttitle" ClientDataKeyNames="expsubtidd,expsubtcod,expsubttitle">
                                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </RowIndicatorColumn>
                                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                                </ExpandCollapseColumn>
                                                                                                <Columns>
                                                                                                    <telerik:GridBoundColumn DataField="expsubtidd" Visible="false" FilterControlAltText="Filter expsubtidd column"
                                                                                                        HeaderText="Id" UniqueName="expsubtidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="expsubtcod" FilterControlAltText="Filter expsubtcod column"
                                                                                                        HeaderText="Code" UniqueName="expsubtcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>
                                                                                                    <telerik:GridBoundColumn DataField="expsubttitle" FilterControlAltText="Filter expsubttitle column"
                                                                                                        HeaderText="Title" UniqueName="expsubttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                                    </telerik:GridBoundColumn>

                                                                                                </Columns>
                                                                                                <EditFormSettings>
                                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                    </EditColumn>
                                                                                                </EditFormSettings>
                                                                                            </MasterTableView>
                                                                                            <ClientSettings>
                                                                                                <ClientEvents OnRowClick="OnExpSubTypeRowClicked"></ClientEvents>
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
                                                                    <asp:RequiredFieldValidator ID="RFVExpSubType" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlExpSubType"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    </tr>
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblExpenseValue" runat="server" Text="Amount:"></asp:Label>
                                                                </td>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        
                                                                        <telerik:RadNumericTextBox ID="txtExpenseValue" ClientIDMode="Static" ClientEvents-OnValueChanged="OnValueChanged"
                                                                            runat="server" Text='<%# Eval("expval") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVExpenseValue" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtExpenseValue"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblRate" runat="server" Text="Rate:"></asp:Label>
                                                                </td>
                                                                <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadNumericTextBox ID="txtRate" ClientIDMode="Static" Enabled="false"
                                                                        runat="server" Text='<%# Eval("unitval") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblSubTotal" runat="server" Text="Sub Total:"></asp:Label>
                                                                </td>
                                                                <td style="width: 180px; border-bottom: 0px; padding-left: 0px">

                                                                    <telerik:RadNumericTextBox ID="txtSubTotal" ClientIDMode="Static" Enabled="false" 
                                                                        runat="server" Text='<%# Eval("subtotal") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>

                                                                <td style="border-bottom: 0px; padding-left: 0px">
                                                                    <%--<asp:RequiredFieldValidator ID="RFVSubTotal" Style="float: left" runat="server"
                                                                        ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtSubTotal"></asp:RequiredFieldValidator>--%>
                                                                </td>
                                                            </tr>

                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lbltx1" runat="server" Text='<%# Eval("tx1lbl") %>'></asp:Label>
                                                                </td>
                                                                <td style="width: 180px; border-bottom: 0px; padding-left: 0px">

                                                                    <telerik:RadNumericTextBox ID="txttx1"  ClientIDMode="Static" ClientEvents-OnValueChanged="OnValueChanged"
                                                                        runat="server" Text='<%# Eval("tx1val") %>'>   
                                                                    </telerik:RadNumericTextBox>
                                                                </td>

                                                                <td style="border-bottom: 0px; padding-left: 0px">
                                                                    <%--<asp:RequiredFieldValidator ID="RFVtx1" Style="float: left" runat="server"
                                                                        ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txttx1"></asp:RequiredFieldValidator>--%>
                                                                </td>
                                                            </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lbltx2" runat="server" Text='<%# Eval("tx2lbl") %>'></asp:Label>
                                                                </td>
                                                                <td style="width: 180px; border-bottom: 0px; padding-left: 0px">

                                                                    <telerik:RadNumericTextBox ID="txttx2"  ClientIDMode="Static" ClientEvents-OnValueChanged="OnValueChanged"
                                                                        runat="server" Text='<%# Eval("tx2val") %>'>  
                                                                    </telerik:RadNumericTextBox>
                                                                </td>

                                                                <td style="border-bottom: 0px; padding-left: 0px">
                                                                    <%--<asp:RequiredFieldValidator ID="RFVtx2" Style="float: left" runat="server"
                                                                        ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txttx2"></asp:RequiredFieldValidator>--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lbltx3" runat="server" Text='<%# Eval("tx3lbl") %>'></asp:Label>
                                                                </td>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        
                                                                    <telerik:RadNumericTextBox ID="txttx3"  ClientIDMode="Static" ClientEvents-OnValueChanged="OnValueChanged"
                                                                        runat="server" Text='<%# Eval("tx3val") %>'>  
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                    <%--<asp:RequiredFieldValidator ID="RFVtx3" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txttx3"></asp:RequiredFieldValidator>--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblTotalValue" runat="server" Text="Total:"></asp:Label>
                                                                </td>
                                                                    <td style="width:180px; border-bottom: 0px; padding-left: 0px">
                                                                        
                                                                        <telerik:RadNumericTextBox ID="txtTotalValue" ClientIDMode="Static" Enabled="false"
                                                                            runat="server" Text='<%# Eval("totalval") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldVTotalValue" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtTotalValue"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblexpcmt" runat="server" Text="Comments:"></asp:Label>
                                                                </td>
                                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:TextBox ID="txtexpcmt" runat="server" MaxLength="250" TextMode="MultiLine" Style="resize: none; height: 57px; width: 170px;" Text='<%# Eval("expcmt") %>'></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                <td>
                                                                    <asp:Label ID="lblAttachs" runat="server" Text="Attachments:"></asp:Label>
                                                                </td>
                                                                    <td style="border-bottom: 0px;padding-top: 7px; padding-left: 0px">
                                                                        <asp:Label ID="lblFiles" Visible="false" runat="server" Text="5 of 5 Files Attached."></asp:Label>
                                                                        <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true" Width="170px" InputSize="150"
                                                                            AllowedFileExtensions="txt,pdf,doc,jpg,png,jpeg,gif,tif,bmp,docx,xlsx"
                                                                            MultipleFileSelection="Disabled" MaxFileSize="2097152"
                                                                            MaxFileInputsCount="5"
                                                                            OnClientFileUploaded="onClientFileUploaded"
                                                                            UploadedFilesRendering="AboveFileInput"
                                                                            TemporaryFolder="~\App_Data\RadUploadTemp\">
                                                                            <FileFilters>
                                                                                <telerik:FileFilter Description="Images & Docs(jpeg;jpg;gif;png;tif;bmp;txt;pdf;doc;docx;xlsx)" Extensions="jpeg,jpg,gif,png,tif,bmp,txt,pdf,doc,docx,xlsx" />
                                                                            </FileFilters>
                                                                        </telerik:RadAsyncUpload>

                                                                    </td>
                                                                    
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldVExpenseValue1" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtExpenseValue1"></asp:RequiredFieldValidator>--%>
                                                                    </td>
                                                                </tr>

                                                            <tr>
                                                                <td>
                                                                    <asp:ImageButton ID="btnInsert" ImageUrl="~/Images/check.gif" AlternateText='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                                        runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />&nbsp;
                                                                    <asp:ImageButton ID="btnCancel" ImageUrl="~/Images/cancel.gif" AlternateText="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:ImageButton>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </FormTemplate>
                                                </EditFormSettings>
                                            </telerik:GridTableView>
                                    </DetailTables>
                                    <CommandItemTemplate>
                                        <div class="title tabLabelVisible">
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                            <h6>Reimbursement List</h6>
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
                                                                <asp:Button ID="Button1" Visible="true" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                            <asp:Button ID="btnNewEntries" runat="server" OnClick="btnNewEntries_Click" Text="New Entries" class="button greenB" ></asp:Button>
                                                                
                                                                 </td>
                                                            <td align="left">
                                                                <asp:Button runat="server" ID="btnUpdateNH" Visible="false" OnClientClick="if (! UpdateAllConfirmation()) return false;"
                                                                    CausesValidation="false" CommandName="UpdateAll" AlternateText="Update All" ToolTip="Update All" Text="Update All" />
                                                                <div style="float: right">
<%--                                                                    <asp:Button runat="server" ID="btnFilesExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnFilesCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnFilesPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />--%>
                                                                    <span>
                                                                        <telerik:RadComboBox ID="ddlPrintOptions" CssClass="ddlVisible" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                                    </span>
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

                                      <%--  <telerik:GridTemplateColumn DataField="DayName" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="DayName" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Day" UniqueName="DayName">
                                            <ItemTemplate>
                                                <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>--%>

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
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="vendor" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="vendor" CurrentFilterFunction="Contains" FilterControlAltText="Filter vendor column"
                                            HeaderText="Vendor" UniqueName="vendor">
                                            <ItemTemplate>
                                                <asp:Label ID="lblvendor" runat="server" Text='<%# Eval("vendor") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="poscod" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="poscod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                            HeaderText="Position" UniqueName="poscod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEmpPos" runat="server" Text='<%# Eval("poscod") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="ctrcod" visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="prjcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter ctrcod column"
                                            HeaderText="Coutry" UniqueName="ctrcod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblctrcod" runat="server" Text='<%# Eval("ctrcod") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn DataField="prvcod" visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                            SortExpression="prvcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter prvcod column"
                                            HeaderText="Province" UniqueName="prvcod">
                                            <ItemTemplate>
                                                <asp:Label ID="lblprvcod" runat="server" Text='<%# Eval("prvcod") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridBoundColumn UniqueName="IsPublicHoliday" DataField="IsPublicHoliday" ItemStyle-Width="0px" Display="false">
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn UniqueName="IsWeekend" DataField="IsWeekend" ItemStyle-Width="0px" Display="false">
                                        </telerik:GridBoundColumn>
                                        
                                        <telerik:GridTemplateColumn DataField="reimcmt" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="reimcmt" CurrentFilterFunction="Contains" FilterControlAltText="Filter reimcmt column"
                                            HeaderText="Comments" UniqueName="reimcmt">
                                            <ItemTemplate>
                                                <asp:Label ID="lblreimcmt" runat="server" Text='<%# Eval("reimcmt") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn AllowFiltering="False" FilterControlAltText="Filter PrintRecord column" UniqueName="PrintRecord">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnPrintRecord" ImageUrl="~/Images/printers.png" runat="server" CommandArgument='<%# Eval("recidd") %>' CommandName="PrintRecord" ToolTip="Print Record"></asp:ImageButton>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
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
                                    <EditFormSettings EditFormType="Template" CaptionFormatString='Edit detail of attendance id : "{0}"' CaptionDataField="recidd">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />

                                        <FormTemplate>
                                            <table style="empty-cells: hide;">
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblEmpCode" runat="server" Text="Emp Code:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                 <asp:Button ID="btnHidden" ClientIDMode="Static" runat="server" Style="display: none;" CausesValidation="false" />
                                                                 <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                                                    Width="180px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select..." OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdEmployee4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource"  AllowFilteringByColumn="true" Width="180px" ClientSettings-EnableRowHoverStyle="True">
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

                                                                                        <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="ID" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="empcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter column3 column"
                                                                                            HeaderText="Name" UniqueName="empfsn" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
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
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblDate" runat="server" Text="Date:"></asp:Label>
                                                    </td>
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
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblProject" runat="server" Text="Project:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlProject" runat="server"
                                                                    Width="180px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdProject4DDL" runat="server" AllowSorting="True"
                                                                            AutoGenerateColumns="False" AllowFilteringByColumn="true"
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
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblVendor" runat="server" Text="Vendor:"></asp:Label>
                                                    </td>
                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:TextBox ID="txtvendor" Style="height: 20px; width: 175px; margin-bottom: 4px;" runat="server" Text='<%# Eval("vendor") %>'></asp:TextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px"></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblPosition" runat="server" Text="Position:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlEmpPos" runat="server"
                                                                    Width="180px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdEmpPos4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AutoGenerateColumns="False" AllowFilteringByColumn="true"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmpPos4DDL_NeedDataSource"
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
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblCountry" runat="server" Text="Country:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlCountry" runat="server"
                                                                    Width="180px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select..." OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdCountry4DDL" runat="server" AllowSorting="True"
                                                                            AutoGenerateColumns="False" AllowFilteringByColumn="true"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdCountry4DDL_NeedDataSource"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <GroupingSettings CaseSensitive="false" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,ctrcod,ctrnam,defval"
                                                                                ClientDataKeyNames="recidd,ctrcod,ctrnam,defval" TableLayout="Fixed">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator  column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="ctrcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="100px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="ctrnam" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Name" UniqueName="ctrnam" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="110px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnCountryRowClicked"></ClientEvents>
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
                                                            <asp:RequiredFieldValidator ID="rfvddlCountry" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlCountry"></asp:RequiredFieldValidator>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblProvince" runat="server" Text="Province:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlProvince" runat="server"
                                                                    Width="180px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdProvince4DDL" runat="server" AllowSorting="True"
                                                                            AutoGenerateColumns="False" AllowFilteringByColumn="true"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdProvince4DDL_NeedDataSource"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <GroupingSettings CaseSensitive="false" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>

                                                                            <MasterTableView DataKeyNames="recidd,prvcod,prvnam,defval"
                                                                                ClientDataKeyNames="recidd,prvcod,prvnam,defval" TableLayout="Fixed">
                                                                                <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator  column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>

                                                                                    <telerik:GridBoundColumn DataField="recidd" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="recidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="prvcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="prvcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="100px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="prvnam" FilterControlAltText="Filter column3 column"
                                                                                        HeaderText="Name" UniqueName="prvnam" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                        <HeaderStyle Width="110px" />
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowClick="OnProvinceRowClicked"></ClientEvents>
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
                                                            <asp:RequiredFieldValidator ID="rfvddlProvince" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                ControlToValidate="ddlProvince"></asp:RequiredFieldValidator>
                                                        </td>
                                                        </tr>
                                                    <tr>
                                                    <td>
                                                        <asp:Label ID="lblreimcmt" runat="server" Text="Comments:"></asp:Label>
                                                    </td>
                                                        <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                            <%--<telerik:RadTextBox ID="txtreimcmt" MaxLength="50" TextMode="MultiLine" runat="server" Text='<%# Eval("reimcmt") %>'>
                                                            </telerik:RadTextBox>--%>
                                                            <asp:TextBox ID="txtreimcmt" runat="server" MaxLength="250" TextMode="MultiLine" style="resize:none;height: 37px;width: 175px;" Text='<%# Eval("reimcmt") %>'></asp:TextBox>
                                                        </td>
                                                        <td style="border-bottom: 0px; padding-left: 0px"></td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                        <asp:ImageButton ID="btnInsert" ImageUrl="~/Images/check.gif" AlternateText='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>'
                                                            runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>' />&nbsp;
                                                        <asp:ImageButton ID="btnCancel" ImageUrl="~/Images/cancel.gif" AlternateText="Cancel" runat="server" CausesValidation="False" CommandName="Cancel"></asp:ImageButton>
                                                    </td>
                                                </tr>
                                                </table>
                                        </FormTemplate>

                                    </EditFormSettings>
                                </MasterTableView>

                            </telerik:RadGrid>
                            <div class="clear"> </div>

                            <div class="wizButtons">
                                <span class="wNavButtons">

                                    <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                        ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"></asp:Button>

                                    <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
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
                                <h6i>Saved requests by the current user.</h6i>
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
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="recidd,TransactionNumber" InsertItemPageIndexAction="ShowItemOnCurrentPage"
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
                                                    HeaderText="Level" UniqueName="column2" ReadOnly="True" Visible="false">
                                                    <ItemStyle Width="20px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="MappingType" FilterControlAltText="Filter column column"
                                                    HeaderText="App. Type" UniqueName="column" Visible="false">
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="groupcode" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Group" UniqueName="column5" Visible="false">
                                                    <ItemStyle Width="30px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="MainApproverFullName" FilterControlAltText="Filter column3 column"
                                                    HeaderText="Approver" UniqueName="column3" Visible="false">
                                                    <ItemStyle Width="150px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="RequestStatus" FilterControlAltText="Filter column column"
                                                    HeaderText="Status" UniqueName="colRequestStatus" ReadOnly="True">
                                                     <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update ON" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="120px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridBoundColumn DataField="ApprovedByFullName" FilterControlAltText="Filter column4 column"
                                                    HeaderText="Decision by" UniqueName="column4"  Visible="false">
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
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32" Visible="false"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                             <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="TransactionNumber" SortExpression="TransactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Trx. No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Date" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" FilterControlAltText="Filter column3 column"
                                            HeaderText="Employee" UniqueName="column3" ReadOnly="True" Visible ="false">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                         

                                        <telerik:GridBoundColumn DataField="SubmittedbyEmployeeCode" SortExpression="SubmittedbyEmployeeCode" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted By" UniqueName="column4" ReadOnly="True"  Visible ="false">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SubmittedbyEmployeeFullName" SortExpression="SubmittedbyEmployeeFullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted By" UniqueName="column9" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="ViewEdit" CommandArgument='<%# Eval("TransactionNumber") %>' ImageUrl="~/Images/16x16_pencil.png"
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
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("TransactionNumber") %>'
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
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                              <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="TransactionNumber">
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
                                <h6i>Requests submitted for approval by the current user.</h6i>
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
                                                     <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
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
                                            HeaderStyle-HorizontalAlign="Center" Visible ="false">
                                            <ItemStyle Width="30px" />
                                             <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prmtrx" SortExpression="prmtrx" FilterControlAltText="Filter column2 column"
                                            HeaderText="Trx. No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Updated On" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeuserid" SortExpression="employeeuserid" FilterControlAltText="Filter column3 column"
                                            HeaderText="Employee" UniqueName="column3" ReadOnly="True" Visible="false">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="RequestedBy" SortExpression="RequestedBy" FilterControlAltText="Filter column4 column"
                                            HeaderText="Requested By" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                           <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnRecall" runat="server" CommandName="Recall" CommandArgument='<%# Eval("prmtrx") %>' ImageUrl="~/Images/16x16_recall.png"
                                                    ToolTip="Recall request." /><%--Visible='<%# isRecallVisible(Convert.ToString(Eval("Last_Status_ID")),int.Parse(Convert.ToString(Eval("EmployeeUserID")))) %>'--%>
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("prmtrx") %>'
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
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("recidd") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                             <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="prmtrx">
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
                                <h6i>Requests pending for approval.</h6i>
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
                                                     <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Updated On" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
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
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32" Visible="false"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                             <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prmtrx" SortExpression="prmtrx" FilterControlAltText="Filter column2 column"
                                            HeaderText="Trx. No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Date" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="UserLevel" SortExpression="UserLevel" FilterControlAltText="Filter column6 column"
                                            HeaderText="User Level" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="MappingType" SortExpression="MappingType" FilterControlAltText="Filter column6 column"
                                            HeaderText="Mapping Type" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="groupcode" SortExpression="groupcode" FilterControlAltText="Filter column6 column"
                                            HeaderText="Group Code" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>


                                        <telerik:GridBoundColumn DataField="FullName" SortExpression="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Requested By" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True" Visible="false">
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("prmtrx")+ ";" +Eval("RequestID")+ ";" +Eval("RequestStatusID") %>' ImageUrl="~/Images/16x16_Check.png"
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
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("prmtrx")+ ";" +Eval("RequestID") %>'
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
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
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
                                <h6i>Completed requests by the current user.</h6i>
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
                                                     <HeaderStyle CssClass="additionalColumn" />
                                                            <ItemStyle CssClass="additionalColumn" />
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
                                            HeaderStyle-HorizontalAlign="Center" Visible="false">
                                            <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="prmtrx" SortExpression="prmtrx" FilterControlAltText="Filter column2 column"
                                            HeaderText="Trx. No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="requestdate" SortExpression="requestdate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Date" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>

                                                                                <telerik:GridBoundColumn DataField="submittedbyuserid" SortExpression="submittedbyuserid" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted By" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="100px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="status" SortExpression="status" FilterControlAltText="Filter column7 column"
                                            HeaderText="Status" UniqueName="column7" ReadOnly="True">
                                           <HeaderStyle CssClass="additionalColumn" />
                                            <ItemStyle Width="100px" CssClass="additionalColumn" />

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
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("prmtrx")+ ";" +Eval("RequestID") %>'
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
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                           <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="additionalColumn" />
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
