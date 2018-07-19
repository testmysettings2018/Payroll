<%@ Page Title="Duty Resumption Form" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="DutyResumption.aspx.cs" Inherits="Payroll_Transaction_DutyResumption" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/Controls/ucEmployeeCard.ascx" TagPrefix="uc1" TagName="ucEmployeeCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

        <script type="text/javascript">

            function ShowReport(RequestId, Reportname) {
                window.open("../Reports/LaunchReport.aspx?RequestId=" + RequestId + "&Reportname=" + Reportname);
                return false;
            }

            function showSuccessMessage(msg) {
                showSuccess(msg, null, 10000);
            }

            function RowClickedRecords(sender, args) {
                var cellValues = args.getDataKeyValue("transactionNumber");
                var UserID = args.getDataKeyValue("RequestID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdRecords4DDL', ''));
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
            }

            function RowClickedArchivedRecords(sender, args) {
                var cellValues = args.getDataKeyValue("transactionNumber");
                var UserID = args.getDataKeyValue("RequestID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdRecordsArchived4DDL', ''));
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
            }

            function RowClickedPostedRecords(sender, args) {
                var cellValues = args.getDataKeyValue("transactionNumber");
                var UserID = args.getDataKeyValue("RequestID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdRecordsPosted4DDL', ''));
                combo.trackChanges();
                combo.set_text(cellValues);
                combo.get_items().getItem(0).set_value(UserID);
                combo.get_items().getItem(0).set_text(cellValues);
                combo.commitChanges();
            }

            function ShowTab(tab) {

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

            function RowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
                var UserID = args.getDataKeyValue("UserID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedEmployee(sender, args) {
                var cellValues = args.getDataKeyValue("EmployeeFullNameWithID");
                var UserID = args.getDataKeyValue("UserID");

                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployees4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedLoanType(sender, args) {
                var cellValues = args.getDataKeyValue("loncod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLoanTypes4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedLoanClass(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var RecID = args.getDataKeyValue("Value");

                var combo = $find(sender.ClientID.replace('_i0_rGrdLoanClasses4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(RecID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedDestination(sender, args) {
                var cellValues = args.getDataKeyValue("ctrnam");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdDestinations4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedPayCode(sender, args) {
                var cellValues = args.getDataKeyValue("paycod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCodes4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedInstallmentDeduction(sender, args) {
                var cellValues = args.getDataKeyValue("dedcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdInstallmentDeductions4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedInterestDeduction(sender, args) {
                var cellValues = args.getDataKeyValue("dedcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdInterestDeductions4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);
                    combo.commitChanges();
                }, 50);
            }

            function RowClickedBatch(sender, args) {
                var cellValues = args.getDataKeyValue("bchcod");
                var UserID = args.getDataKeyValue("recidd");

                var combo = $find(sender.ClientID.replace('_i0_rGrdBatches4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(UserID);
                    combo.get_items().getItem(0).set_text(cellValues);

                    combo.commitChanges();
                }, 50);
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

            function CalulateConfirm() {
                if (confirm('Old entry will be deleted, do you still want to Generate ?'))
                    return true;
                else
                    return false;
            }

            function ConfirmDeleteButton(button) {
                function aspButtonCallbackFn(arg) {
                    if (arg) {
                        __doPostBack(button.name, "");
                    }
                }
                radconfirm("Are you sure you want to delete this record?", aspButtonCallbackFn, 330, 180, null, "Delete Record");
            }

            function ConfirmPostButton(button) {
                function aspButtonCallbackFn(arg) {
                    if (arg) {
                        __doPostBack(button.name, "");
                    }
                }
                radconfirm("Are you sure you want to post this record?", aspButtonCallbackFn, 330, 180, null, "Confirm Post");
            }


            function ConfirmVoidButton(button) {
                function aspButtonCallbackFn(arg) {
                    if (arg) {
                        __doPostBack(button.name, "");
                    }
                }
                radconfirm("Are you sure you want to void/cancel this record?", aspButtonCallbackFn, 330, 180, null, "Confirm Void/Cancel");
            }

            function ConfirmGenerateButton(button) {
                function aspButtonCallbackFn(arg) {
                    if (arg) {
                        __doPostBack(button.name, "");
                    }
                }
                radconfirm("This will delete old entry, Are you sure you want to Generate lines?", aspButtonCallbackFn, 330, 180, null, "Confirm Generate Lines");
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

        function ValidateLoanInstallment(txtInstallmentValueId, txtResumptionDateId, rCmbInstallmentDeductionId) {
            var str = '';
            if ($('#' + txtInstallmentValueId).val() == undefined || $('#' + txtInstallmentValueId).val() == "") {
                str += 'Amount Required.<br/>';
            }
            if ($('#' + txtResumptionDateId).val() == undefined || $('#' + txtResumptionDateId).val() == "") {
                str += 'Due Date Required.<br/>';
            }
            if ($('#' + rCmbInstallmentDeductionId).val() == undefined || $('#' + rCmbInstallmentDeductionId).val() == "") {
                str += 'Deduction Required.<br/>';
            }
            if (str != '') {
                showError(str, null, 10000);
            }
        }

    </script>

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="rGrdRecords4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                    <telerik:AjaxUpdatedControl ControlID="txtResumptionDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtEntryDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator10" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator4" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator5" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevcode" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevtype" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevstartdate" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevenddate" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevrejoiningdate" />
                     <telerik:AjaxUpdatedControl ControlID="ltrlevnoofdays" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnPost">  
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbRecords" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdRecords4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="txtEntryDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtResumptionDate" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescription" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator10" />
                     <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator4" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator5" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnDelete">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbRecords" />
                    <telerik:AjaxUpdatedControl ControlID="rGrdRecords4DDL" />
                    <telerik:AjaxUpdatedControl ControlID="txtResumptionDate" />
                    <telerik:AjaxUpdatedControl ControlID="rCmbPayCode" />
                    <telerik:AjaxUpdatedControl ControlID="ruDocument" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator10" />
                     <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator4" />
                    <telerik:AjaxUpdatedControl ControlID="RequiredFieldValidator5" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnPrint">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnPrintArchived">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnPrintPosted">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnVoidCancel">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="hfTrxId" />
                    <telerik:AjaxUpdatedControl ControlID="btnVoidCancel" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rGrdRecordsPosted4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpEntryDatePosted" />
                    <telerik:AjaxUpdatedControl ControlID="txtResumptionDatePosted" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescriptionPosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevcodPosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevtypPosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevstartdatePosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevenddatePosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevrejoiningdatePosted" />
                    <telerik:AjaxUpdatedControl ControlID="ltrnoofdaysPosted" />
                    <telerik:AjaxUpdatedControl ControlID="btnVoidCancel" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="rGrdRecordsArchived4DDL">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="rdpEntryDateArchived" />
                    <telerik:AjaxUpdatedControl ControlID="txtResumptionDateArchived" />
                    <telerik:AjaxUpdatedControl ControlID="txtDescriptionArchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevcodarchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevtyparchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevstartdatearchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevenddatearchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrlevrejoiningdatearchived" />
                    <telerik:AjaxUpdatedControl ControlID="ltrnoofdaysarchived" />
                    <telerik:AjaxUpdatedControl ControlID="ucEmployeeCard2" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnRequestStart="RequestStart" OnResponseEnd="ResponseEnd" />
    </telerik:RadAjaxManager>

    <!-- Fullscreen tabs -->
    <div class="widget">
        <ul class="tabs">
            <li class="Tab1">
                <a href="#tab1">New Requests</a>
            </li>
            <li class="Tab2">
                <a href="#tab2">Posted Requests </a>
            </li>
            <li class="Tab3">
                <a href="#tab3">Archived Requests </a>
            </li>
        </ul>

        <div class="tab_container">
            <asp:Panel ID="pnlAjaxForm" runat="server" CssClass="fluid">
                <div id="tab1" class="tab_content">
                    <asp:HiddenField ID="hfTrxId" runat="server" />
                    <div class="fluid">
                        <div class="span8">
                            <div class="widget11">
                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                    <h6>Personal Details</h6>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Leave Transaction Number</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>

                                                        <telerik:RadComboBox ID="rCmbRecords" runat="server" Width="254px" DropDownWidth="400px" EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 300px;">
                                                                    <telerik:RadGrid ID="rGrdRecords4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" Width="400px" ClientSettings-EnableRowHoverStyle="True"
                                                                        OnSelectedIndexChanged="rGrdRecords4DDL_SelectedIndexChanged"
                                                                        OnNeedDataSource="rGrdRecords4DDL_NeedDataSource">
                                                                        <MasterTableView DataKeyNames="RequestID,transactionNumber,EmployeeUserID" ClientDataKeyNames="RequestID,transactionNumber,EmployeeUserID">
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="ID" UniqueName="RequestID">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Transaction Number" UniqueName="transactionNumber">
                                                                                </telerik:GridBoundColumn>
                                                                                 <telerik:GridBoundColumn DataField="EmployeeUserID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Employee" UniqueName="EmployeeUserID">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                        </MasterTableView>
                                                                        <ClientSettings EnablePostBackOnRowClick="true">
                                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                                            <ClientEvents OnRowClick="RowClickedRecords"></ClientEvents>
                                                                        </ClientSettings>
                                                                    </telerik:RadGrid>
                                                                </div>
                                                            </ItemTemplate>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                    </td>

                                                    <td>
                                                        <asp:Button ID="btnAddNew" Style="margin-left: 20px;display:none" runat="server" Text="Add New" OnClick="btnAddNew_Click" class="button greenB"></asp:Button>
                                                    </td>
                                                </tr>
                                            </table>



                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Resumption Date</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="txtResumptionDate" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator10"
                                                            ControlToValidate="txtResumptionDate"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                 <div class="formRow">
                                    <div class="formCol">
                                        <label>Entry Date</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="txtEntryDate" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator4"
                                                            ControlToValidate="txtEntryDate"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Description</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtDescription" runat="server" ></telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator5"
                                                            ControlToValidate="txtDescription"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                          
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>

                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Attachments</label>
                                        <div class="formRight">
                                            <telerik:RadAsyncUpload runat="server" ID="ruDocument" overwriteexistingfiles="true"
                                                AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                MultipleFileSelection="Automatic" MaxFileSize="524288"
                                                MaxFileInputsCount="3"
                                                OnClientFileUploaded="onClientFileUploaded"
                                                TemporaryFolder="~\App_Data\RadUploadTemp\">
                                            </telerik:RadAsyncUpload>

                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label></label>
                                        <div class="formRight">
                                            <asp:Button ID="btnPost" OnClientClick="ConfirmPostButton(this); return false;" OnClick="btnPost_Click" runat="server" Text="Post" class="button greenB"></asp:Button>
                                             <asp:Button ID="btnDelete" Visible="false" runat="server" OnClientClick="ConfirmDeleteButton(this); return false;" OnClick="btnDelete_Click" Text="Delete" class="button greenB"></asp:Button>
                                              <asp:Button ID="btnPrint" OnClick="btnPrint_Click" runat="server" Text="Print" class="button greenB"></asp:Button>

                                        </div>
                                    </div>

                                    <div class="clear"></div>
                                </div>
                            </div>
                        </div>
                        <div class="span4">
                            <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard" />
                            <div class="widget">

    <div class="title" style="background-color:#D1A7BF;">
        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6B>Employee Leave Detail</h6B>
    </div>

                                 <div class="formRow">
        <div class="formCol">
            <label style="width:200px">
               
                                        <asp:Literal runat="server" ID="ltrlevcode"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevtype"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
   
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevstartdate"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
     <div class="formRow">
        <div class="formCol">
            <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevenddate"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>  
                                  <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevrejoiningdate"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
                
                                        <asp:Literal runat="server" ID="ltrlevnoofdays"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label></label>
        </div>
        <div class="clear"></div>
    </div>

                        </div>
                        <div class="clear"></div>
                    </div>
                    </div>
                    </div>
                <div id="tab2" class="tab_content">
                    <fieldset>
                        <div class="fluid">
                            <div class="span8">
                                <div class="widget11">
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                        <h6>Personal Details</h6>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Posted Records</label>
                                            <div class="formRight">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadComboBox ID="rCmbRecordsPosted" runat="server" Width="254px" DropDownWidth="500px" EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <div style="overflow: auto; max-height: 300px;">
                                                                        <telerik:RadGrid ID="rGrdRecordsPosted4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" Width="500px" ClientSettings-EnableRowHoverStyle="True"
                                                                            OnSelectedIndexChanged="rGrdRecordsPosted4DDL_SelectedIndexChanged"
                                                                            OnNeedDataSource="rGrdRecordsPosted4DDL_NeedDataSource">
                                                                          <MasterTableView DataKeyNames="RequestID,transactionNumber,EmployeeUserID" ClientDataKeyNames="RequestID,transactionNumber,EmployeeUserID">
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="ID" UniqueName="RequestID">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Transaction Number" UniqueName="transactionNumber">
                                                                                </telerik:GridBoundColumn>
                                                                                 <telerik:GridBoundColumn DataField="EmployeeUserID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Employee" UniqueName="EmployeeUserID">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                        </MasterTableView>
                                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                                <ClientEvents OnRowClick="RowClickedPostedRecords"></ClientEvents>
                                                                            </ClientSettings>
                                                                        </telerik:RadGrid>
                                                                    </div>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Resumption Date</label>
                                            <div class="formRight">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadDatePicker ID="txtResumptionDatePosted" Enabled="false" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                     <div class="formRow">
                                    <div class="formCol">
                                        <label>Entry Date</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="rdpEntryDatePosted" Enabled="false" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator3"
                                                            ControlToValidate="rdpEntryDatePosted"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Description</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtDescriptionPosted" Enabled="false" runat="server" ></telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator6"
                                                            ControlToValidate="txtDescriptionPosted"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                          
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Attachments</label>
                                            <div class="formRight">
                                                <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload1" Enabled="false" overwriteexistingfiles="true"
                                                    AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                    MultipleFileSelection="Automatic" MaxFileSize="524288"
                                                    MaxFileInputsCount="3"
                                                    OnClientFileUploaded="onClientFileUploaded"
                                                    TemporaryFolder="~\App_Data\RadUploadTemp\">
                                                </telerik:RadAsyncUpload>

                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>

                                    <div class="formRow">
                                        <div class="formCol">
                                            <label></label>
                                            <div class="formRight">
                                                <asp:Button ID="btnVoidCancel" Style="float: left; margin-right: 5px;" OnClientClick="ConfirmVoidButton(this); return false;" OnClick="btnVoidCancel_Click" runat="server" Text="Void/Cancel" class="button greenB"></asp:Button>
                                                <asp:Button ID="btnPrintPosted" Style="float: left" OnClick="btnPrintPosted_Click" runat="server" Text="Print" class="button greenB"></asp:Button>

                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="span4">
                                <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard1" />
                                                                                            <div class="widget">

    <div class="title" style="background-color:#D1A7BF;">
        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6B>Employee Leave Detail</h6B>
    </div>

                                 <div class="formRow">
        <div class="formCol">
            <label style="width:200px">
               
                                        <asp:Literal runat="server" ID="ltrlevcodposted"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevtypposted"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
   
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevstartdateposted"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
     <div class="formRow">
        <div class="formCol">
            <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevenddateposted"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>  
                                  <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevrejoiningdateposted"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
                
                                        <asp:Literal runat="server" ID="ltrnoofdaysposted"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label></label>
        </div>
        <div class="clear"></div>
    </div>

                        </div>

                            </div>
                            <div class="clear"></div>

                          

                        </div>

                    </fieldset>
                </div>

                <div id="tab3" class="tab_content">
                    <fieldset>
                        <div class="fluid">
                            <div class="span8">
                                <div class="widget11">
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                        <h6>Personal Details</h6>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Archived Records</label>
                                            <div class="formRight">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadComboBox ID="rCmbRecordsArchived" runat="server" Width="254px" DropDownWidth="500px" EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <div style="overflow: auto; max-height: 300px;">
                                                                        <telerik:RadGrid ID="rGrdRecordsArchived4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" Width="500px" ClientSettings-EnableRowHoverStyle="True"
                                                                            OnSelectedIndexChanged="rGrdRecordsArchived4DDL_SelectedIndexChanged"
                                                                            OnNeedDataSource="rGrdRecordsArchived4DDL_NeedDataSource">
                                                                            <MasterTableView DataKeyNames="RequestID,transactionNumber,EmployeeUserID" ClientDataKeyNames="RequestID,transactionNumber,EmployeeUserID">
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="RequestID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="ID" UniqueName="RequestID">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="transactionNumber" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Transaction Number" UniqueName="transactionNumber">
                                                                                </telerik:GridBoundColumn>
                                                                                 <telerik:GridBoundColumn DataField="EmployeeUserID" FilterControlAltText="Filter column column"
                                                                                    HeaderText="Employee" UniqueName="EmployeeUserID">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                        </MasterTableView>
                                                                            <ClientSettings EnablePostBackOnRowClick="true">
                                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                                                <ClientEvents OnRowClick="RowClickedArchivedRecords"></ClientEvents>
                                                                            </ClientSettings>
                                                                        </telerik:RadGrid>
                                                                    </div>
                                                                </ItemTemplate>
                                                                <Items>
                                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                </Items>
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Resumption Date</label>
                                            <div class="formRight">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <telerik:RadDatePicker ID="txtResumptionDateArchived" Enabled="false" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>
                                     <div class="formRow">
                                    <div class="formCol">
                                        <label>Entry Date</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadDatePicker ID="rdpEntryDateArchived" Enabled="false" runat="server" DateInput-DateFormat="MM/dd/yyyy"></telerik:RadDatePicker>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator1"
                                                            ControlToValidate="rdpEntryDateArchived"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="formRow">
                                    <div class="formCol">
                                        <label>Description</label>
                                        <div class="formRight">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <telerik:RadTextBox ID="txtDescriptionArchived" Enabled="false" runat="server" ></telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator
                                                            ID="RequiredFieldValidator2"
                                                            ControlToValidate="txtDescriptionArchived"
                                                            ErrorMessage="*"
                                                            Display="Dynamic"
                                                            CssClass="requiredvalidators"
                                                            ValidationGroup="FrmSubmit"
                                                            SetFocusOnError="False"
                                                            runat="server"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                          
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                    <div class="formRow">
                                        <div class="formCol">
                                            <label>Attachments</label>
                                            <div class="formRight">
                                                <telerik:RadAsyncUpload runat="server" ID="RadAsyncUpload2" Enabled="false" overwriteexistingfiles="true"
                                                    AllowedFileExtensions="txt,pdf,doc,jpg,png,gif,bmp,docx,xlsx"
                                                    MultipleFileSelection="Automatic" MaxFileSize="524288"
                                                    MaxFileInputsCount="3"
                                                    OnClientFileUploaded="onClientFileUploaded"
                                                    TemporaryFolder="~\App_Data\RadUploadTemp\">
                                                </telerik:RadAsyncUpload>

                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                    </div>

                                    <div class="formRow">
                                        <div class="formCol">
                                            <label></label>
                                            <div class="formRight">
                                                <asp:Button ID="btnPrintArchived" Style="float: left" OnClick="btnPrintArchived_Click" runat="server" Text="Print" class="button greenB"></asp:Button>

                                            </div>
                                        </div>

                                        <div class="clear"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="span4">
                                <uc1:ucEmployeeCard runat="server" ID="ucEmployeeCard2" />
                                                            <div class="widget">

    <div class="title" style="background-color:#D1A7BF;">
        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
        <h6B>Employee Leave Detail</h6B>
    </div>

                                 <div class="formRow">
        <div class="formCol">
            <label style="width:200px">
               
                                        <asp:Literal runat="server" ID="ltrlevcodarchived"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevtyparchived"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
   
    <div class="formRow">
        <div class="formCol">
           <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevstartdatearchived"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
     <div class="formRow">
        <div class="formCol">
            <label style="width:200px !important">
               
                                        <asp:Literal runat="server" ID="ltrlevenddatearchived"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>  
                                  <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
              
                                        <asp:Literal runat="server" ID="ltrlevrejoiningdatearchived"></asp:Literal></label>
        </div>
      
        <div class="clear"></div>
    </div>
    <div class="formRow">
        <div class="formCol">
          <label style="width:200px !important">
                
                                        <asp:Literal runat="server" ID="ltrnoofdaysarchived"></asp:Literal></label>
        </div>
        <div class="formCol">
            <label></label>
        </div>
        <div class="clear"></div>
    </div>

                        </div>

                            </div>
                            <div class="clear"></div>
                        </div>
                    </fieldset>
                </div>
            </asp:Panel>
        </div>
        <div class="clear"></div>
    </div>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Style="z-index: 10000;">
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
</asp:Content>


