<%@ Page Title="Reimbursement Form" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master"
    AutoEventWireup="true" CodeFile="Reimbursment.aspx.cs" Inherits="Reimbursment" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>
<%@ Register Src="~/Controls/Diagram.ascx" TagPrefix="uc1" TagName="Diagram" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .filename {
            display: none !important;
        }

        .fluid:before, .fluid:after {
            content: "";
            display: table;
            line-height: 0;
        }

        .fluid:after {
            clear: both;
        }

        .fluid:before, .fluid:after {
            content: "";
            display: table;
            line-height: 0;
        }

        /************************************************/

        .fluid [class*="span"]:first-child {
            margin-left: 0;
        }

        .fluid .span8 {
            width: 60%;
        }

        .fluid .span4 {
            width: 40%;
        }

        .fluid .span8 .formCol {
            width: 90% !important;
        }

        .fluid [class*="span"] {
            box-sizing: border-box;
            display: block;
            float: left;
            /*margin-left: 2.12766%;
        width: 100%;*/
        }


        .emp-data {
            float: left;
        }

            .emp-data label {
                float: left;
                /*width: 30px;*/
            }

        .emp-picture {
            float: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            function ShowReport(RequestId, Reportname) {
                window.open("../Reports/LaunchReport.aspx?RequestId=" + RequestId + "&Reportname=" + Reportname);
                return false;
            }

            function ShowEditForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditReimbursment.aspx?ReimbursmentID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            };

            function ShowRecallForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("EditForms/EditReimbursment.aspx?ReimbursmentID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            };

            function ShowApproveForm(id, rowIndex, RequestStatusID, FormType) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ApproveForms/ApproveReimbursment.aspx?RequestID=" + id + "&RequestStatusID=" + RequestStatusID + "&FormType=" + FormType, "RadWindow2");
                return false;
            };

            function refreshGrid2() {
                var ajaxManager = $find("<%= RadAjaxManager1.ClientID %>");
                ajaxManager.ajaxRequest("Rebind");
            }

            function showSuccessMessage(msg) {
                showSuccess(msg, null, 10000);
            }

            function ShowOrgChart(id, rowIndex) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("FlowChart.aspx?ReimbursmentID=" + id, "RadWindowOrgChart");
                return false;
            };

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

            function ShowSavedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSavedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewReimbursemet.aspx?ReimbursementID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowSubmittedViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvSubmittedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewReimbursemet.aspx?ReimbursementID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowPendingViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvPendingAppRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewReimbursemet.aspx?ReimbursementID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }

            function ShowApprovalViewForm(id, rowIndex, FormTypeID, isRecalled) {
                var grid = $find("<%= gvApprovedRequests.ClientID %>");

                var rowControl = grid.get_masterTableView().get_dataItems()[rowIndex].get_element();
                grid.get_masterTableView().selectItem(rowControl, true);

                window.radopen("ViewForms/ViewReimbursemet.aspx?ReimbursementID=" + id + "&FormType=" + FormTypeID + "&isRecalled=" + isRecalled, "RadWindow1");
                return false;
            }


            function ValidateTransaction(batchcodeid, transactiontypeid, entrydate, departmentcodeid, paycodeid, positioncodeid, deductioncodeid, benefitcodeid, amount, transactionnumber) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Batch Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlOrigionId).val() == undefined || $('#' + ddlOrigionId).val() == "") {
                    str += 'Origion Required.<br/>';
                }
                if ($('#' + ddlFrequencyId).val() == undefined || $('#' + ddlFrequencyId).val() == "") {
                    str += 'Frequency Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            };
        </script>
    </telerik:RadCodeBlock>

    <%--    <telerik:RadScriptBlock ID="radblocks" runat="server">
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
    </telerik:RadScriptBlock>--%>

    <!-- this for dropdown grid common functions-->
    <telerik:RadCodeBlock ID="RadCodeBlock2" runat="server">
        <script type="text/javascript">
            var isSorted = false;
            var ctrlId = "";
            function setSorted(senderID) {
                isSorted = true;
                ctrlId = senderID;
            };
            function OnClientDropDownClosing(sender, eventArgs) {
                if (sender.get_id() == ctrlId && isSorted) {
                    eventArgs.set_cancel(true);
                } else {
                    eventArgs.set_cancel(false);
                }
                isSorted = false;
                ctrlId = "";
                if (sender.get_value() == "") {
                    sender.set_text("");
                }
            };

            function RowSelect(row, senderID) {
                var combo = $find(senderID);
                setTimeout(function () {
                    combo.set_text($(row).find('td.text').text().trim());
                    combo.set_value($(row).find('td.value').text().trim());
                }, 50);
            };
            function OnClientLoad(editor, args) {
                editor.add_modeChange(function (editor, args) {
                    var mode = editor.get_mode();
                    if (mode == 2) {
                        var htmlMode = editor.get_textArea();  //get a reference to the Html mode textarea
                        htmlMode.disabled = "true";
                    }
                });
            };

            function RowClickedEmployee(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
                var UserID = args.getDataKeyValue("UserID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            };

            function RowClickedReimbursment(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdReimbursments4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.commitChanges();
                }, 50);
            };

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

                    input.style.width = "300px";


                    return input;
                }

                function createLabel(forArrt) {
                    var label = document.createElement("label");

                    label.setAttribute("for", forArrt);
                    label.innerHTML = "File info: ";
                    label.style.width = "335px";

                    return label;
                }

            })();

        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxManager ID="RadAjaxManager1" OnAjaxRequest="RadAjaxPanel1_AjaxRequest" runat="server">
                <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rBtnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rBtnSave" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtAmount" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="txtSub1" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="txtSub2" LoadingPanelID="RadAjaxLoadingPanel1" />
                     <telerik:AjaxUpdatedControl ControlID="txtSub3" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" LoadingPanelID="RadAjaxLoadingPanel1" />                                        <telerik:AjaxUpdatedControl ControlID="txtDescription1" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription2" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription3" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbReimbursment" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="gvSavedRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="gvSubmittedRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="gvPendingAppRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="gvApprovedRequests" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdEmployees4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdEmployees4DDL" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>

        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdReimbursments4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rGrdReimbursments4DDL" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div class="widget">
        <ul class="tabs">
            <li class="Tab1">
                <a href="#tab1">New Requests</a>
            </li>
            <li class="Tab2">
                <a href="#tab2">Saved Requests </a>
            </li>
            <li class="Tab3">
                <a href="#tab3">Submitted Requests </a>
            </li>
            <li class="Tab4">
                <a href="#tab4">Pending Approvals </a>
            </li>
            <li class="Tab5">
                <a href="#tab5">Approved Requests </a>
            </li>

        </ul>

        <div class="tab_container">

            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server"
                LoadingPanelID="RadAjaxLoadingPanel1">

                <div id="tab1" class="tab_content">

                    <div class="fluid">
                        <div class="span8">
                            <div class="widget11">

                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6b>Personal Details</h6b>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Employee</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbEmployee" runat="server" Width="254px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdEmployees4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False" OnNeedDataSource="rGrdEmployees4DDL_NeedDataSource" OnDataBound="rGrdEmployees4DDL_DataBound"
                                                            CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True" OnItemCommand="rGrdEmployees4DDL_ItemCommand">
                                                            <ClientSettings EnableRowHoverStyle="true">
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="UserID,EmployeeID" ClientDataKeyNames="UserID,EmployeeID,EmployeeFullNameWithID">
                                                                <Columns>
                                                                    <telerik:GridBoundColumn
                                                                        DataField = "UserID"
                                                                        FilterControlAltText = "Filter column column"
                                                                        HeaderText = "User ID"
                                                                        UniqueName = "column">
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
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Reimbursement Type</label>
                                        <div class="formRight">
                                            <telerik:RadComboBox ID="rCmbReimbursment" runat="server" Width="254px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadGrid ID="rGrdReimbursments4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False" OnNeedDataSource="rGrdReimbursments4DDL_NeedDataSource"
                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True">
                                                        <ClientSettings EnableRowHoverStyle="true">
                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                        </ClientSettings>
                                                        <MasterTableView DataKeyNames="recidd" ClientDataKeyNames="recidd,bchcod,bchdsc">
                                                            <Columns>
                                                                <telerik:GridBoundColumn
                                                                    DataField = "recidd"
                                                                    FilterControlAltText = "Filter column column"
                                                                    HeaderText = "ID"
                                                                    UniqueName = "column">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn
                                                                    DataField = "bchcod"
                                                                    FilterControlAltText = "Filter column1 column"
                                                                    HeaderText = "Batch"
                                                                    UniqueName = "column1">
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn
                                                                    DataField = "bchdsc"
                                                                    FilterControlAltText = "Filter column2 column"
                                                                    HeaderText = "Description"
                                                                    UniqueName = "column2">
                                                                </telerik:GridBoundColumn>
                                                            </Columns>
                                                        </MasterTableView>
                                                        <ClientSettings EnableRowHoverStyle="true">
                                                            <ClientEvents OnRowClick="RowClickedReimbursment"></ClientEvents>
                                                        </ClientSettings>
                                                    </telerik:RadGrid>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Amount </label>
                                    <div
                                        class = "formRight"
                                        style = "width: 100px;">
                                        <telerik:RadNumericTextBox
                                            Height = "25px"
                                            ID = "txtAmount"
                                            MaxLength = "10"
                                            runat = "server">
                                        </telerik:RadNumericTextBox>

                                        <asp:RequiredFieldValidator
                                            ControlToValidate = "txtAmount"
                                            CssClass = "requiredvalidators"
                                            Display = "Dynamic"
                                            ErrorMessage = "*"
                                            ID = "RequiredFieldValidator3"
                                            runat = "server"
                                            SetFocusOnError = "False"
                                            ValidationGroup = "FrmSubmit">
                                        </asp:RequiredFieldValidator>

                                        </div>

                                </div>

                                <div
                                    class = "clear">
                                </div>
                            </div>
                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Sub Amount 1</label>
                                    <div
                                        class = "formRight"
                                        style = "width: 100px;">
                                        <telerik:RadNumericTextBox
                                            Height = "25px"
                                            ID = "txtSub1"
                                            MaxLength = "10"
                                            runat = "server">
                                        </telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div
                                    class = "clear">
                                </div>
                            </div>
                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Sub Amount 2</label>
                                    <div
                                        class = "formRight"
                                        style = "width: 100px;">
                                        <telerik:RadNumericTextBox
                                            Height = "25px"
                                            ID = "txtSub2"
                                            MaxLength = "10"
                                            runat = "server">
                                        </telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div
                                    class = "clear">
                                </div>
                            </div>
                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Sub Amount 3</label>
                                    <div
                                        class = "formRight"
                                        style = "width: 100px;">
                                        <telerik:RadNumericTextBox
                                            Height = "25px"
                                            ID = "txtSub3"
                                            MaxLength = "10"
                                            runat = "server">
                                        </telerik:RadNumericTextBox>

                                    </div>

                                </div>

                                <div
                                    class = "clear">
                                </div>
                            </div>
                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Description</label>
                                    <div
                                        class = "formRight">
                                        <telerik:RadTextBox
                                            Height = "25px"
                                            ID = "txtDescription"
                                            MaxLength = "200"
                                            runat = "server">
                                        </telerik:RadTextBox>

                                        <asp:RequiredFieldValidator
                                            ControlToValidate = "txtDescription"
                                            CssClass = "requiredvalidators"
                                            Display = "Dynamic"
                                            ErrorMessage = "*"
                                            ID = "Required_txtDescription"
                                            runat = "server"
                                            SetFocusOnError = "False"
                                            ValidationGroup = "FrmSubmit">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div
                                    class = "clear">
                                </div>
                            </div>

                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Description 1</label>
                                    <div
                                        class = "formRight">
                                        <telerik:RadTextBox
                                            Height = "25px"
                                            ID = "txtDescription1"
                                            MaxLength = "200"
                                            runat = "server">
                                        </telerik:RadTextBox>

                                    </div>
                                </div>
                                <div
                                    class = "clear">
                                </div>
                            </div>
                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Description 2</label>
                                    <div
                                        class = "formRight">
                                        <telerik:RadTextBox
                                            Height = "25px"
                                            ID = "txtDescription2"
                                            MaxLength = "200"
                                            runat = "server">
                                        </telerik:RadTextBox>

                                    </div>
                                </div>
                                <div
                                    class = "clear">
                                </div>
                            </div>

                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Description 3</label>
                                    <div
                                        class = "formRight">
                                        <telerik:RadTextBox
                                            Height = "25px"
                                            ID = "txtDescription3"
                                            MaxLength = "200"
                                            runat = "server">
                                        </telerik:RadTextBox>
                                    </div>
                                </div>
                                <div
                                    class = "clear">
                                </div>
                            </div>

                            <div
                                class = "formRow">
                                <div
                                    class = "formCol">
                                    <label>Attachments</label>
                                    <div
                                        class = "formRight">
                                        <telerik:RadAsyncUpload
                                            AllowedFileExtensions = "txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                            ID = "ruDocument"
                                            MaxFileInputsCount = "3"
                                            MaxFileSize = "524288"
                                            MultipleFileSelection = "Automatic"
                                            OnClientFileUploaded = "onClientFileUploaded"
                                            overwriteexistingfiles = "true"
                                            runat = "server"
                                            TemporaryFolder = "~\App_Data\RadUploadTemp\">
                                            </telerik:RadAsyncUpload>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                            </div>
                        </div>
                        <div class="span4">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                        </div>
                        <div class="clear"></div>

                        <div class="wizButtons">
                            <span class="wNavButtons">

                                <asp:Button ID="rBtnSave" runat="server" OnClick="rBtnSave_Click" Text="Save"
                                    ValidationGroup="FrmSubmit" class="button greenB" CausesValidation="True"></asp:Button>
                                <asp:Button ID="rBtnSaveAndSubmit" runat="server" OnClick="rBtnSaveAndSubmit_Click"
                                    Text="Save and Submit" class="button blueB" ValidationGroup="FrmSubmit" CausesValidation="True"></asp:Button>
                            </span>
                        </div>

                        <div class="clear"></div>
                    </div>
                </div>
                <div id="tab2" class="tab_content">

                    <fieldset>
                        <div class="widget12">
                            <div class="title2">
                                <img src="../../images/icons/dark/listw.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the saved requests by the current user.</h6i>
                            </div>


                            <telerik:RadGrid ID="gvSavedRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvSavedRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvSavedRequests_DetailTableDataBind"
                                OnItemCreated="gvSavedRequests_ItemCreated" OnItemDataBound="gvSavedRequests_ItemDataBound" OnItemCommand="gvSavedRequests_ItemCommand">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
                                    AllowMultiColumnSorting="true" EditMode="EditForms" AllowFilteringByColumn="true">
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
                                        <telerik:GridBoundColumn DataField="Trxno" FilterControlAltText="Filter column2 column"
                                            HeaderText="Transaction No." UniqueName="column2" ReadOnly="True"
                                            FilterControlWidth="50px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
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
                                                <asp:ImageButton ID="imgBtnEdit" runat="server" CommandName="Edit" ImageUrl="~/Images/16x16_pencil.png"
                                                    Visible='<%# isEditVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Edit this request." />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn1 column"
                                            UniqueName="TemplateColumn2">
                                            <ItemTemplate>

                                                <asp:ImageButton ID="imgBtnSubmit" runat="server" CommandName="Submit" ImageUrl="~/Images/16x16_tick2.png"
                                                    Visible='<%# isSubmitVisible(Eval("Last_Status_ID").ToString(),int.Parse(Eval("EmployeeUserID").ToString())) %>'
                                                    ToolTip="Submit Now!" CommandArgument='<%# Eval("RequestID") %>' />

                                            </ItemTemplate>

                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn UniqueName="TemplateColumn3">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnDelete"
                                                    runat="server"
                                                    ImageUrl="~/Images/Delete.png"
                                                    AlternateText="Delete" ToolTip="Delete Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Delete" ConfirmText="Are you sure to delete selected request?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete Request" ConfirmTextFormatString='Are you sure to delete Suggestion Request "{0}"?' />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>




                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn14">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnView" runat="server" ImageUrl="~/Images/view.png"
                                                    AlternateText="View" ToolTip="View Request" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="View" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>






                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn2 column"
                                            UniqueName="TemplateColumn15">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="~/Images/16x16_print.png"
                                                    AlternateText="Print" ToolTip="Print Preview" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="Print" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" runat="server" ImageUrl="~/Images/chart.png"
                                                    AlternateText="Workflow" ToolTip="Workflow Chart" CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" CssClass="CommandColumnCSS" />
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="Trxno">
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

                                <img src="../../images/icons/dark/listw.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the requests submitted for approval by the current user.</h6i>

                            </div>
                            <telerik:RadGrid ID="gvSubmittedRequests" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                OnNeedDataSource="gvSubmittedRequests_NeedDataSource" PageSize="20" ShowStatusBar="True"
                                OnItemCreated="gvSubmittedRequests_ItemCreated" OnItemCommand="gvSubmittedRequests_ItemCommand"
                                OnDetailTableDataBind="gvSubmittedRequests_DetailTableDataBind"
                                OnItemDataBound="gvSubmittedRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" AllowMultiColumnSorting="true"
                                    EditMode="EditForms">
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                    </RowIndicatorColumn>
                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                    </ExpandCollapseColumn>
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

                                    <Columns>
                                        <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column1 column"
                                            HeaderText="ID" UniqueName="column1" ReadOnly="True" DataType="System.Int32"
                                            HeaderStyle-HorizontalAlign="Center">
                                            <ItemStyle Width="30px" />
                                        </telerik:GridBoundColumn>
                                        <telerik:GridBoundColumn DataField="Trxno" FilterControlAltText="Filter column2 column"
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
                                            <HeaderStyle Width="25px" />
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
                                    <%--                                <SortExpressions>
                                <telerik:GridSortExpression FieldName="Priority" SortOrder="Ascending" />
                                <telerik:GridSortExpression FieldName="RequestDate" SortOrder="Descending" />
                                </SortExpressions>
                                    --%>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="Trxno">
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
                                <img src="../../images/icons/dark/listw.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the requests pending for approval by the current user.</h6i>

                            </div>

                            <telerik:RadGrid ID="gvPendingAppRequests" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnNeedDataSource="gvPendingAppRequests_NeedDataSource"
                                PageSize="20" ShowStatusBar="True" OnDetailTableDataBind="gvPendingAppRequests_DetailTableDataBind"
                                OnItemCreated="gvPendingAppRequests_ItemCreated" OnItemCommand="gvPendingAppRequests_ItemCommand"
                                OnItemDataBound="gvPendingAppRequests_ItemDataBound">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID,RequestStatusID" InsertItemPageIndexAction="ShowItemOnCurrentPage"
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
                                        <telerik:GridBoundColumn DataField="Trxno" FilterControlAltText="Filter column2 column"
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
                                            <HeaderStyle Width="25px" />
                                        </telerik:GridTemplateColumn>

                                        <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumnOrgChart column" UniqueName="TemplateColumnOrgChart">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgBtnOrgChart" 
                                                                 runat="server" 
                                                                 ImageUrl="~/Images/chart.png"
                                                                 AlternateText ="Workflow" 
                                                                 ToolTip="Workflow Chart" 
                                                                 CommandArgument='<%# Eval("RequestID") %>'
                                                    CommandName="OrgChart" />
                                            </ItemTemplate>
                                            <HeaderStyle Width="25px" />

                                        </telerik:GridTemplateColumn>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="RequestID" SortOrder="Descending" />
                                    </SortExpressions>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="Trxno">
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
                                <img src="../../images/icons/dark/listw.png" alt="" class="titleIcon" />
                                <h6i>This Grid is showing all the approved requests by the current user.</h6i>

                            </div>

                            <telerik:RadGrid ID="gvApprovedRequests" runat="server" AllowPaging="True"
                                AllowSorting="True" AutoGenerateColumns="False" CellSpacing="0" GridLines="None"
                                OnNeedDataSource="gvApprovedRequests_NeedDataSource" PageSize="20" ShowStatusBar="True"
                                OnItemCreated="gvApprovedRequests_ItemCreated"    OnItemDataBound="gvApprovedRequests_ItemDataBound"
                                OnDetailTableDataBind="gvApprovedRequests_DetailTableDataBind"
                                OnItemCommand="gvApprovedRequests_ItemCommand">
                                <FilterMenu EnableImageSprites="False">
                                </FilterMenu>
                                <ClientSettings EnableRowHoverStyle="true">
                                    <Selecting CellSelectionMode="None"></Selecting>
                                </ClientSettings>
                                <MasterTableView AutoGenerateColumns="False" DataKeyNames="RequestID"
                                    InsertItemPageIndexAction="ShowItemOnCurrentPage" AllowMultiColumnSorting="true"
                                    EditMode="EditForms">
                                    <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                                                    <ItemStyle Width="100px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridBoundColumn DataField="UpdateDate" FilterControlAltText="Filter column1 column"
                                                    HeaderText="Status Update Date/Time" UniqueName="column1" DataType="System.DateTime" DataFormatString="{0:d/M/yyyy hh:mm tt}">
                                                    <ItemStyle Width="150px" />
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
                                        <telerik:GridBoundColumn DataField="Trxno" FilterControlAltText="Filter column2 column"
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
                                            <HeaderStyle Width="25px" />
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
                                    <%--                                <SortExpressions>
                                <telerik:GridSortExpression FieldName="Priority" SortOrder="Ascending" />
                                <telerik:GridSortExpression FieldName="RequestDate" SortOrder="Descending" />
                                </SortExpressions>
                                    --%>
                                    <EditFormSettings CaptionFormatString='Edit Details for this transaction "{0}":' CaptionDataField="Trxno">
                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                        <EditColumn ButtonType="ImageButton" />
                                    </EditFormSettings>
                                </MasterTableView>
                            </telerik:RadGrid>
                        </div>
                    </fieldset>
                </div>

            </telerik:RadAjaxPanel>
        </div>
        <div class="clear"></div>
    </div>

    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 10000;">
        <Windows>
            <telerik:RadWindow ID="RadWindow1" runat="server" Modal="true" Title="Edit Request"
                Width="1000px" Height="550px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="550px" MaxHeight="1000px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindow2" runat="server" Modal="true" Title="Approve or reject request"
                Width="1000px" Height="550px" ReloadOnShow="true" ShowContentDuringLoad="false"
                VisibleStatusbar="false" EnableShadow="true" MinHeight="520px" MaxHeight="1000px"
                MinWidth="1000px" MaxWidth="1000px">
            </telerik:RadWindow>
            <telerik:RadWindow ID="RadWindowOrgChart" runat="server" Modal="true" Title="Flow Chart for the Selected Request"
                ReloadOnShow="true" ShowContentDuringLoad="false"
                               VisibleStatusbar = "false"
                               EnableShadow = "True"
                               MinHeight = "500"
                               MaxHeight = "900"
                MinWidth="500" MaxWidth="1200" Width="1900" Height="700">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
</asp:Content>

