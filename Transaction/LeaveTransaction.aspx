<%@ Page Title="Leave Transaction Form" MetaDescription="You can enter leave transaction here." Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="LeaveTransaction.aspx.cs" Inherits="LeaveTransaction" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>
<%@ Register Src="~/Controls/ucEmployeeLeaveBalance.ascx" TagPrefix="uc1" TagName="ucEmployeeLeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">

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
                        if (tab != "#tab1") {
                            wd.find("ul.tabs li:first").removeClass("activeTab").show(); //Activate first tab
                            wd.find(".tab_content:first").hide(); //Show first tab content

                            wd.find('a[href="' + tab + '"]').parent().addClass("activeTab"); //Add "active" class to selected tab
                            $(tab).show(); //Fade in the active content
                        }
                    }
                }
            };

            function refreshGrid2() {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
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

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadScriptBlock ID="radblocks" runat="server">
        <script type="text/javascript">

            function conditionalPostback(sender, eventArgs) {
                var theRegexp = new RegExp("\.EditColumn|\.AddNewRecordButton|\.InitInsertButton|\.UpdateButton|\.PerformInsertButton", "ig");

                if (eventArgs.get_eventTarget().match(theRegexp)) {
                    var upload = $find(window['UploadId']);
                    //AJAX is disabled only if file is selected for upload
                    if (upload.getFileInputs()[0].value != "") {
                        eventArgs.set_enableAjax(false);
                    }
                }
            }

        </script>
    </telerik:RadScriptBlock>

    <!-- this for dropdown grid common functions-->
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            var isSorted = false;
            var ctrlId = "";

            function setSorted(senderID) {
                isSorted = true;
                ctrlId = senderID;
            }

            function OnClientDropDownClosing(sender, eventArgs) {
                if (sender.get_id() == ctrlId && isSorted) {
                    eventArgs.set_cancel(true);
                }
                else {
                    eventArgs.set_cancel(false);
                }
                isSorted = false;
                ctrlId = "";
                if (sender.get_value() == "")
                    sender.set_text("");
            }

            function RowSelect(row, senderID) {
                var combo = $find(senderID);
                setTimeout(function () {
                    combo.set_text($(row).find('td.text').text().trim());
                    combo.set_value($(row).find('td.value').text().trim());
                }, 50);
            }

            function OnClientLoad(editor, args) {
                editor.add_modeChange(function (editor, args) {
                    var mode = editor.get_mode();
                    if (mode == 2) {
                        var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                        htmlMode.disabled = "true";
                    }
                });
            }

            function RowClickedBatch(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdBatches4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
            }

            function RowClickedEntryType(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var UserID = args.getDataKeyValue("Value");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEntryTypes4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
            }

            function RowClickedLeaveType(sender, args) {
                var cellValues = args.getDataKeyValue("levtypcod");
                var RecID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveTypes4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(RecID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
            }

            function RowClickedLeaveCode(sender, args) {
                var cellValues = args.getDataKeyValue("levcod");
                var rcidd = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveCodes4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(rcidd);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
            }

            function RowClickedEmployee(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
                var UserID = args.getDataKeyValue("UserID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
            }

            function RowClickedCalander(sender, args) {
                var cellValues = args.getDataKeyValue("grdclc");
                var UserID = args.getDataKeyValue("grdcli");

                var combo = $find(sender.ClientID.replace('_i0_rGrdCalanders4DDL', ''));
                //setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                //}, 50);
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

                    input.style.width = "150px";


                    return input;
                }

                function createLabel(forArrt) {
                    var label = document.createElement("label");

                    label.setAttribute("for", forArrt);
                    label.innerHTML = "File info: ";
                    label.style.width = "150px";

                    return label;
                }

            })();

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
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="gvPendingAppRequests">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests"   />
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
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmployees4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL"/>
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard"   />
                    
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode"   />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
           <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSaveAndSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL"/>
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard"   />
                    
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode"   />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
         <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL"/>
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard"   />
                    
                    <telerik:AjaxUpdatedControl ControlID="rCmbEntryType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode"   />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtFromDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtToDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
        <ul class="tabs">
            <li class="Tab1 col-2 col-m-20">
                <a href="#tab1">New Requests</a>
            </li>
            <li class="Tab2 col-2 col-m-20">
                <a href="#tab2">Saved Requests </a>
            </li>
            <li class="Tab3 col-2 col-m-20">
                <a href="#tab3">Submitted Requests </a>
            </li>
            <li class="Tab4 col-2 col-m-20">
                <a href="#tab4">Pending Approvals </a>
            </li>
            <li class="Tab5 col-2 col-m-20">
                <a href="#tab5">Approved Requests </a>
            </li>

        </ul>

        <div class="tab_container">
           <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                <div id="tab1" class="tab_content">
                    <div class="fluid">
                        <div class="span8 col-7 col-m-6" >
                            <div class="widget11">

                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6b>Personal Details</h6b>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Employee</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbEmployee"
                                                runat="server"
                                                Width="254px"
                                                DropDownWidth="255px"
                                                EmptyMessage="Please select..." OnSelectedIndexChanged="rCmbEmployee_SelectedIndexChanged">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">

                                                        <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True"
                                                            AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdEmployees4DDL_ItemCommand"
                                                            OnNeedDataSource="rGrdEmployees4DDL_NeedDataSource" OnDataBound="rGrdEmployees4DDL_DataBound" >
                                                            <MasterTableView DataKeyNames="UserID,EmployeeID"
                                                                ClientDataKeyNames="UserID,EmployeeID,EmployeeFullNameWithID">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="UserID" FilterControlAltText="Filter column column"
                                                                        HeaderText="User ID" UniqueName="column">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="EmployeeID" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="Employee ID" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="EmployeeFullNameWithID" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="Name" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <ClientEvents OnRowClick="RowClickedEmployee"></ClientEvents>


                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator2"
                                                ControlToValidate="rCmbEmployee"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Entry Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbEntryType" runat="server" Width="254px" DropDownWidth="255px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdEntryTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdEntryTypes4DDL_ItemCommand" OnNeedDataSource="rGrdEntryTypes4DDL_NeedDataSource">
                                                            <MasterTableView DataKeyNames="Value" ClientDataKeyNames="Value,Text">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="Value" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column1 column" HeaderText="Entry Type" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                <ClientEvents OnRowClick="RowClickedEntryType"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>


                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator3"
                                                ControlToValidate="rCmbEntryType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>


                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Leave Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbLeaveType" runat="server" Width="254px" DropDownWidth="255px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveTypes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnItemCommand="rGrdLeaveTypes4DDL_ItemCommand" OnNeedDataSource="rGrdLeaveTypes4DDL_NeedDataSource">
                                                            <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,levtypcod">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levtypcod" FilterControlAltText="Filter column1 column" HeaderText="Leave Type" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column1 column" HeaderText="Description" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                <ClientEvents OnRowClick="RowClickedLeaveType"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator4"
                                                ControlToValidate="rCmbLeaveType"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>


                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Leave Code</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbLeaveCode" runat="server" Width="254px" DropDownWidth="255px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveCodes4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" Width="255px" ClientSettings-EnableRowHoverStyle="True"
                                                            OnNeedDataSource="rGrdLeaveCodes4DDL_NeedDataSource"
                                                            OnItemCommand="rGrdLeaveCodes4DDL_ItemCommand" >
                                                            <MasterTableView DataKeyNames="recidd,levcod" ClientDataKeyNames="recidd,levcod">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" HeaderText="ID" UniqueName="column">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levcod" FilterControlAltText="Filter column1 column" HeaderText="Code" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column1 column" HeaderText="Description" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                <ClientEvents OnRowClick="RowClickedLeaveCode"></ClientEvents>
                                                            </ClientSettings>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>

                                            <asp:RequiredFieldValidator
                                                ID="RequiredFieldValidator5"
                                                ControlToValidate="rCmbLeaveCode"
                                                ErrorMessage="*"
                                                Display="Dynamic"
                                                CssClass="requiredvalidators"
                                                ValidationGroup="FrmSubmit"
                                                SetFocusOnError="False"
                                                runat="server"></asp:RequiredFieldValidator>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>From Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtFromDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                 OnSelectedDateChanged="txtFromDate_SelectedDateChanged"></telerik:RadDatePicker>


                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>To Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtToDate" runat="server" DateInput-DateFormat="MM/dd/yyyy" AutoPostBack="true"
                                                 OnSelectedDateChanged="txtToDate_SelectedDateChanged"></telerik:RadDatePicker>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Rejoining Date</label>
                                        <div class="formRight">
                                            <telerik:RadDatePicker ID="txtRejoiningDate" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Air Ticket Requested</label>
                                        <div class="formRight">
                                            <asp:CheckBox ID="checkAirTicket" runat="server" Text=""></asp:CheckBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Number of Days</label>
                                        <div class="formRight" style="width: 50px;">
                                            <telerik:RadTextBox ID="txtNumberOfDays" runat="server" MaxLength="3" Height="25px" AutoPostBack="true">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Remarks 1</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtRemarks1" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Remarks 2</label>
                                        <div class="formRight">
                                            <telerik:RadTextBox ID="txtRemarks2" runat="server" MaxLength="30" Height="25px">
                                            </telerik:RadTextBox>
                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Attachments</label>
                                        <div class="formRight">
                                            <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true" Width="296px" inputsize="150"
                                                AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                MultipleFileSelection="Disabled" MaxFileSize="524288"
                                                MaxFileInputsCount="3"
                                                OnClientFileUploaded="onClientFileUploaded"
                                                TemporaryFolder="~\App_Data\RadUploadTemp\" >
                                            </telerik:RadAsyncUpload>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                        <div class="clear"></div>

                            </div>
                        <div class="clear"></div>

                        </div>
                        <div class="span4 col-5 col-m-6">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                            <uc1:ucEmployeeLeaveBalance runat="server" ID="ucEmployeeLeaveBalance" />
                        </div>
                        <div class="clear"></div>


                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="true"></asp:Button>

                                <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
                                    Text="Save and Submit" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="true"></asp:Button>
                            </span>
                        </div>

                        <div class="clear"></div>
                    </div>
                </div>
                <div id="tab2" class="tab_content">

                    <fieldset>
						<%--<div class="widget12">--%>
                        <div class="wEmployeePreview">
                            <div class="title2">
                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the saved requests by the current user.</h6i>
                            </div>
                            <telerik:RadGrid ID="gvSavedRequests" runat="server"    AllowPaging ="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSavedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSavedRequests_DetailTableDataBind"
                                OnItemCreated="gvSavedRequests_ItemCreated" OnItemCommand="gvSavedRequests_ItemCommand">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None" AllowRowSelect="true"></Selecting>
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
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
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
                                        <telerik:GridBoundColumn DataField="transactionNumber" SortExpression="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" SortExpression="RequestDate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Entry Date" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="employeeCode" SortExpression="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" SortExpression="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="Edit" ImageUrl="~/Images/16x16_pencil.png"
                                                    Visible='<%# isEditVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Edit this request." />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                            
                                                <asp:ImageButton ID="imgBtnSubmit" runat="server" CommandName="Submit" ImageUrl="~/Images/16x16_tick2.png"
                                                    Visible='<%# isSubmitVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Submit Now!" CommandArgument='<%# Eval("RequestID") %>' />

                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnDelete" runat="server" ImageUrl="~/Images/Delete.png"
                                                    AlternateText="Delete" ToolTip="Delete Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Delete" ConfirmText="Are you sure to delete selected request?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete Request" ConfirmTextFormatString='Are you sure to delete Suggestion Request "{0}"?' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
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
                                <h6i>This Grid is showing all the requests submitted for approval by the current user.</h6i>
                            </div>

                            <telerik:RadGrid ID="gvSubmittedRequests" runat="server"   AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSubmittedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSubmittedRequests_DetailTableDataBind"
                                OnItemCreated="gvSubmittedRequests_ItemCreated" OnItemCommand="gvSubmittedRequests_ItemCommand"
                                OnItemDataBound="gvSubmittedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                </ClientSettings>
                                <MasterTableView Name="entryview" AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
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
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
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
                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column6 column"
                                            HeaderText="Entry Date/Time" UniqueName="column6" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>

                                                <asp:ImageButton ID="imgBtnRecall" runat="server" CommandName="Recall" ImageUrl="~/Images/16x16_recall.png"
                                                    Visible='<%# isRecallVisible(Convert.ToString(Eval("Last_Status_ID")),int.Parse(Convert.ToString(Eval("EmployeeUserID")))) %>'
                                                    ToolTip="Recall request." />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>

                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
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
                                <h6i>This Grid is showing all the requests pending for approval by the current user.</h6i>
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
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
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

                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column5 column"
                                            HeaderText="Entry Date/Time" UniqueName="column5" ReadOnly="True">
                                            <ItemStyle Width="180px" />

                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="SubmittedByUserCode" FilterControlAltText="Filter column column"
                                            HeaderText="Emp. Code" UniqueName="column6" ReadOnly="True" Visible="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn1">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnApprove" runat="server" CommandName="Approve" ImageUrl="~/Images/16x16_Check.png"
                                                    ToolTip="Approve/Reject this request." Visible='<%# int.Parse(Eval("Priority").ToString()) == 1 %>' />
                                                <asp:Image ID="imgApproved" runat="server" ImageUrl="~/Images/16x16_approved.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 2 %>'
                                                    ToolTip="This Request is Approved." />
                                                <asp:Image ID="imgReject" runat="server" ImageUrl="~/Images/16x16_rejected.png" Visible='<%# int.Parse(Eval("Priority").ToString()) == 3 %>'
                                                    ToolTip="This Request is Rejected." />

                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                    </Columns>
                                    <EditFormSettings CaptionFormatString='Edit Details for this Suggestion "{0}":' CaptionDataField="transactionNumber">
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
                                <h6i>This Grid is showing all the approved requests by the current user.</h6i>
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
                                                <telerik:GridBoundColumn DataField="Remarks" FilterControlAltText="Filter column5 column"
                                                    HeaderText="Status Description" UniqueName="column5">
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="levelcolor" FilterControlAltText="Filter column5 column"
                                                    HeaderText="levelcolor" UniqueName="collevelcolor" Display="true" Visible="false">
                                                </telerik:GridBoundColumn>
                                            </Columns>
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
                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True">
                                            <ItemStyle Width="150px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="RequestDate" FilterControlAltText="Filter column5 column"
                                            HeaderText="Entry Date/Time" UniqueName="column5" ReadOnly="True">
                                            <ItemStyle Width="180px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="employeeCode" FilterControlAltText="Filter column3 column"
                                            HeaderText="Emp. Code" UniqueName="column3" ReadOnly="True">
                                            <ItemStyle Width="80px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="FullName" FilterControlAltText="Filter column4 column"
                                            HeaderText="Submitted for" UniqueName="column4" ReadOnly="True">
                                            <ItemStyle Width="160px" />
                                        </telerik:GridBoundColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumnsdf1" HeaderText="Status">
                                            <ItemTemplate>

                                                <asp:Image ID="imgCompletsdfed" runat="server" ImageUrl='<%# getImagePathForTrue((Eval("status").ToString())) %>'
                                                    ToolTip="Request Status" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" CssClass="additionalColumn" />
                                            <ItemStyle CssClass="additionalColumn" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="transactionNumber">
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

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" />
</asp:Content>
