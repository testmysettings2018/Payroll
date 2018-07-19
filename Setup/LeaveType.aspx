<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="LeaveType.aspx.cs" Inherits="Payroll_LeaveType" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnLeaveTypeExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveTypeCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveTypePdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveTypePrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveTypeRefresh") >= 0 ||

                        args.get_eventTarget().indexOf("btnLeaveExportExcel") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveExportCsv") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveExportPdf") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeavePrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnLeaveRefresh") >= 0 ||

                        args.get_eventTarget().indexOf("btnLdExportExcel") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdExportCsv") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdExportPdf") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdRefresh") >= 0 ||

                        args.get_eventTarget().indexOf("btnLdpExportExcel") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdpExportCsv") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdpExportPdf") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdpPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnLdpRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }

            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }

            function OnLeaveBasedRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveBasedon4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnSalaryBasedRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdSalaryBasedon4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnLeaveProvisionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveProvision4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnFrequencyRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdFrequency4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnPayCodeRowClicked(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "paycod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }

                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCode4DDL', ''));
                combo.trackChanges();
                combo.set_text(headerValues);
                combo.get_items().getItem(0).set_value(headerValues);
                combo.commitChanges();
            }

            function OnDeductionCodeRowClicked(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "dedcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }

                var combo = $find(sender.ClientID.replace('_i0_rGrdDeductionCode4DDL', ''));
                combo.trackChanges();
                combo.set_text(headerValues);
                combo.get_items().getItem(0).set_value(headerValues);
                combo.commitChanges();
            }

            function OnBenefitCodeRowClicked(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "paycod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }

                var combo = $find(sender.ClientID.replace('_i0_rGrdBenefitCode4DDL', ''));
                combo.trackChanges();
                combo.set_text(headerValues);
                combo.get_items().getItem(0).set_value(headerValues);
                combo.commitChanges();
            }

            function OnNewEmoloyeeAnualLeaveRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdNewEmoloyeeAnualLeave4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function ValidateLeaveType(txtbxCodeId, txtDescriptionId, ddlLeaveBasedonId, ddlSalaryBasedOnId, ddlLeaveProvisionId, ddlFrequencyId, txtbxDaysId, ddlNewEmployeeAnualLeaveId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Leave Type Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlLeaveBasedonId).val() == undefined || $('#' + ddlLeaveBasedonId).val() == "") {
                    str += 'Leave Based On Required.<br/>';
                }
                if ($('#' + ddlSalaryBasedOnId).val() == undefined || $('#' + ddlSalaryBasedOnId).val() == "") {
                    str += 'Salary Based On Required.<br/>';
                }
                if ($('#' + ddlLeaveProvisionId).val() == undefined || $('#' + ddlLeaveProvisionId).val() == "") {
                    str += 'Leave Provision Required.<br/>';
                }
                if ($('#' + ddlFrequencyId).val() == undefined || $('#' + ddlFrequencyId).val() == "") {
                    str += 'Frequency Required.<br/>';
                }
                if ($('#' + txtbxDaysId).val() == undefined || $('#' + txtbxDaysId).val() == "") {
                    str += 'Days Required.<br/>';
                }
                if ($('#' + ddlNewEmployeeAnualLeaveId).val() == undefined || $('#' + ddlNewEmployeeAnualLeaveId).val() == "") {
                    str += 'New Employee Anual Leave Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateLeave(txtlevcodId, txtLeaveDescriptionId, ddlPayCodeId, ddlDeductionCodeId, ddlBenefitCodeId, txtMaximumBalanceId) {
                var str = '';
                if ($('#' + txtlevcodId).val() == undefined || $('#' + txtlevcodId).val() == "") {
                    str = 'Leave Code Required.<br/>';
                }
                if ($('#' + txtLeaveDescriptionId).val() == undefined || $('#' + txtLeaveDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlPayCodeId).val() == undefined || $('#' + ddlPayCodeId).val() == "") {
                    str += 'Pay Code Required.<br/>';
                }
                if ($('#' + ddlDeductionCodeId).val() == undefined || $('#' + ddlDeductionCodeId).val() == "") {
                    str += 'Deduction Code Required.<br/>';
                }
                if ($('#' + ddlBenefitCodeId).val() == undefined || $('#' + ddlBenefitCodeId).val() == "") {
                    str += 'Provision Code Required.<br/>';
                }
                if ($('#' + txtMaximumBalanceId).val() == undefined || $('#' + txtMaximumBalanceId).val() == "") {
                    str += 'Maximum Balance Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateLeavePattren(txtBxFromYearId, txtBxToYearId, txtBxlevnodId) {
                var str = '';
                var needCamparison = true;
                //if ($('#' + txtBxlevseqId).val() == undefined || $('#' + txtBxlevseqId).val() == "") {
                //    str = 'Sequence No. Required.<br/>';
                //}
                if ($('#' + txtBxFromYearId).val() == undefined || $('#' + txtBxFromYearId).val() == "") {
                    str = 'From Year Required.<br/>';
                    needCamparison = false;
                }
                if ($('#' + txtBxToYearId).val() == undefined || $('#' + txtBxToYearId).val() == "") {
                    str += 'To Year Required.<br/>';
                    needCamparison = false;
                }
                if (needCamparison) {
                    if (parseInt($('#' + txtBxFromYearId).val()) > parseInt($('#' + txtBxToYearId).val())) {
                        str += 'Greater To Year Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxlevnodId).val() == undefined || $('#' + txtBxlevnodId).val() == "") {
                    str += 'No. of Days Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateLeaveDeductionPattren(txtFromDayId, txtToDayId, txtSalaryPercentageId) {
                var str = '';
                var needCamparison = true;
                //if ($('#' + txtlevseqId).val() == undefined || $('#' + txtlevseqId).val() == "") {
                //    str = 'Sequence No. Required.<br/>';
                //}
                if ($('#' + txtFromDayId).val() == undefined || $('#' + txtFromDayId).val() == "") {
                    str = 'From Day Required.<br/>';
                    needCamparison = false;
                }
                if ($('#' + txtToDayId).val() == undefined || $('#' + txtToDayId).val() == "") {
                    str += 'To Day Required.<br/>';
                    needCamparison = false;
                }
                if (needCamparison) {
                    if (parseInt($('#' + txtFromDayId).val()) > parseInt($('#' + txtToDayId).val())) {
                        str += 'Greater To Day Value Required.<br/>';
                    }
                }
                if ($('#' + txtSalaryPercentageId).val() == undefined || $('#' + txtSalaryPercentageId).val() == "") {
                    str += 'Salary Percentage Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }
        </script>
    </telerik:RadCodeBlock>
    <div class="widget" style="overflow:auto">

        <fieldset>
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">


                    <div class="formRight">
                        <telerik:RadGrid ID="gvLeaveType" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvLeaveType_InsertCommand"
                            OnNeedDataSource="gvLeaveType_NeedDataSource" PageSize="20" OnDeleteCommand="gvLeaveType_DeleteCommand"
                            OnUpdateCommand="gvLeaveType_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvLeaveType_ItemDataBound"
                            OnItemCommand="gvLeaveType_ItemCommand" OnDetailTableDataBind="gvLeaveType_DetailTableDataBind"
                            OnItemCreated="gvLeaveType_ItemCreated">
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="recidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="Leaves" CommandItemDisplay="Top" DataKeyNames="recidd">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Setup</h6>
                                            </div>
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
                                                                    <asp:Button ID="Button2" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnLeaveExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnLeaveExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnLeaveExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnLeavePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnLeaveRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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

                                            <telerik:GridTableView runat="server" AllowFilteringByColumn="false" EditMode="InPlace" Name="LeavePattren" CommandItemDisplay="Top" DataKeyNames="recidd">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Pattren</h6>
                                                    </div>
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
                                                                            <asp:Button ID="btnLdAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Button runat="server" ID="btnLdExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnLdExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnLdExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <asp:Button runat="server" ID="btnLdPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnLdRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                                        HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="levfrm" SortExpression="levfrm" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                        HeaderText="From Year" UniqueName="TemplateColumn2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFromYear" runat="server" Text='<%# Eval("levfrm") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">
                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" Enabled="false" DbValue='<%# Eval("levfrm") %>'
                                                                            MaxValue="99"
                                                                            ID="txtBxFromYear" MaxLength="2"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtBxFromYear"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="levtoo" SortExpression="levtoo" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                        HeaderText="To Year" UniqueName="TemplateColumn3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblToYear" runat="server" Text='<%# Eval("levtoo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">

                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" DbValue='<%# Eval("levtoo") %>'
                                                                            MaxValue="99"
                                                                            ID="txtBxToYear" MaxLength="2"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtBxToYear"></asp:RequiredFieldValidator>
                                                                        <asp:CompareValidator ID="comparefieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtBxToYear" Operator="GreaterThanEqual" Type="Integer" ControlToCompare="txtBxFromYear"></asp:CompareValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="levnod" SortExpression="levnod" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                        HeaderText="No. of Days" UniqueName="TemplateColumn4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbllevnod" runat="server" Text='<%# Eval("levnod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">


                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" DbValue='<%# Eval("levnod") %>'
                                                                            MaxValue="999999999"
                                                                            ID="txtBxlevnod" MaxLength="8"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtBxlevnod"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="EditLeavePattren" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Leave Pattren record?"
                                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteLeavePattren" ConfirmTextFormatString='Are you sure to delete Leave Pattren record # {0}?'>
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
                                            <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="LeaveDeductionPattren" CommandItemDisplay="Top" DataKeyNames="recidd">

                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Deduction Pattren</h6>
                                                    </div>
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
                                                                        <asp:Button ID="btnLdpAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnLdpExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnLdpExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnLdpExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnLdpPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnLdpRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                                        HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="levfrm" AllowFiltering="false" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" SortExpression="levfrm" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="From Day" UniqueName="TemplateColumn2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblFromDay" runat="server" Text='<%# Eval("levfrm") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">

                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" Enabled="false" DbValue='<%# Eval("levfrm") %>'
                                                                            MaxValue="999"
                                                                            ID="txtFromDay" MaxLength="3"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>

                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtFromDay"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="levtod" SortExpression="levtod" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn3 column"
                                                        HeaderText="To Day" UniqueName="TemplateColumn3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblToDay" runat="server" Text='<%# Eval("levtod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">
                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" DbValue='<%# Eval("levtod") %>'
                                                                            MaxValue="999"
                                                                            ID="txtToDay" MaxLength="3"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>

                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtToDay"></asp:RequiredFieldValidator>
                                                                        <asp:CompareValidator ID="comparefieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtToDay" Operator="GreaterThanEqual" Type="Integer" ControlToCompare="txtFromDay"></asp:CompareValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="levslp" SortExpression="levslp" FilterControlWidth="90px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                        HeaderText="Salary Percentage" UniqueName="TemplateColumn4">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblSalaryPercentage" runat="server" Text='<%# Eval("levslp") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">
                                                                        <telerik:RadNumericTextBox
                                                                            MinValue="0" Width="50px" DbValue='<%# Eval("levslp") %>'
                                                                            MaxValue="999999999"
                                                                            ID="txtSalaryPercentage" MaxLength="8"
                                                                            runat="server">
                                                                            <NumberFormat GroupSeparator="" DecimalDigits="0" AllowRounding="true" KeepNotRoundedValue="false" />
                                                                            <ClientEvents OnKeyPress="KeyPress" />
                                                                        </telerik:RadNumericTextBox>

                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtSalaryPercentage"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="EditLeaveDeduction" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Leave Deduction Pattren record?"
                                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteLeaveDeduction" ConfirmTextFormatString='Are you sure to delete Leave Deduction Pattren record # {0}?'>
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
                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="levcod" FilterControlWidth="90px" SortExpression="levcod" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Leave Code" UniqueName="TemplateColumn0">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllevcod" runat="server" Text='<%# Eval("levcod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <telerik:RadTextBox ID="txtlevcod" MaxLength="15" runat="server" Text='<%# Eval("levcod") %>'>
                                                                </telerik:RadTextBox>

                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                    ControlToValidate="txtlevcod"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblpaycode"  class="labelWidth" Style="padding-left: 10px" runat="server" Text="Pay Code:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:HiddenField ID="hflevidd" runat="server" Value='<%# Eval("recidd") %>' />
                                                                <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                                    Width="254px" DropDownWidth="254px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 300px;">
                                                                           <telerik:RadGrid ID="rGrdPayCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCode4DDL_NeedDataSource"
                                                                                Width="254px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="recidd,paycod,payds1" ClientDataKeyNames="recidd,paycod,payds1">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                        <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>
                                                                                        <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="ID" UniqueName="recidd">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="paycod">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Description" UniqueName="payds1">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowSelected="OnPayCodeRowClicked" OnRowDeselected="OnPayCodeRowClicked"></ClientEvents>
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
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator66" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlPayCode"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levdsc" FilterControlWidth="90px" SortExpression="levdsc" AllowFiltering="false" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description" UniqueName="TemplateColumn2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveDescription" runat="server" Text='<%# Eval("levdsc") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <telerik:RadTextBox ID="txtLeaveDescription" runat="server" Text='<%# Eval("levdsc") %>' MaxLength="200">
                                                                </telerik:RadTextBox>

                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator106" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                    ControlToValidate="txtLeaveDescription"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblDeductioncode" class="labelWidth"  Style="padding-left: 10px"  runat="server" Text="Deduction Code:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadComboBox ID="ddlDeductionCode" runat="server"
                                                                    Width="254px" DropDownWidth="254px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 300px;">
                                                                            <telerik:RadGrid ID="rGrdDeductionCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDeductionCode4DDL_NeedDataSource"
                                                                                Width="254px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="recidd,dedcod,dedds1" ClientDataKeyNames="recidd,dedcod,dedds1">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                         <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>
                                                                                        <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="ID" UniqueName="recidd">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="dedcod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="dedcod">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="dedds1" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Description" UniqueName="dedds1">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowSelected="OnDeductionCodeRowClicked" OnRowDeselected="OnDeductionCodeRowClicked"></ClientEvents>
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
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator61" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlDeductionCode"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levsld" FilterControlWidth="90px" SortExpression="levsld" AllowFiltering="false" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn3 column"
                                                HeaderText="Description 2" UniqueName="TemplateColumn3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveArabicDescription" runat="server" Text='<%# Eval("levsld") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <telerik:RadTextBox ID="txtLeaveArabicDescription" runat="server" Text='<%# Eval("levsld") %>' MaxLength="200">
                                                                </telerik:RadTextBox>

                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblBenefitcode" class="labelWidth" Style="padding-left: 15px" runat="server" Text="Provision Code:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadComboBox ID="ddlBenefitCode" runat="server"
                                                                    Width="254px" DropDownWidth="254px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <div style="overflow: auto; max-height: 300px;">
                                                                            <telerik:RadGrid ID="rGrdBenefitCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBenefitCode4DDL_NeedDataSource"
                                                                                Width="254px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true"></Selecting>
                                                                                </ClientSettings>
                                                                                <MasterTableView DataKeyNames="recidd,paycod,payds1" ClientDataKeyNames="recidd,paycod,payds1">
                                                                                    <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </RowIndicatorColumn>
                                                                                    <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                        <HeaderStyle Width="20px"></HeaderStyle>
                                                                                    </ExpandCollapseColumn>
                                                                                    <Columns>
                                                                                        <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>
                                                                                        <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                            HeaderText="ID" UniqueName="recidd">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="paycod">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Description" UniqueName="payds1">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowSelected="OnBenefitCodeRowClicked" OnRowDeselected="OnBenefitCodeRowClicked"></ClientEvents>
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
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlBenefitCode"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="IsDefaultCode" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn44 column"
                                                HeaderText="Default Code" UniqueName="LeaveIsDefault">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgIsDefaultCode" runat="server" ImageUrl='<%# getImagePathForTrue(bool.Parse(Eval("levdft").ToString())) %>'
                                                        Visible='<%# Eval("levdft") %>' />
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:CheckBox runat="server" ID="chkbxlevdft" Text="" Checked='<%# CheckBoxValue( Eval("levdft")) %>' />
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblMaximumBalance" class="labelWidth" Style="padding-left: 15px" runat="server" Text="Maximum Balance:"></asp:Label>
                                                            </td>
                                                            <td class="textboxwidth">

                                                                <telerik:RadNumericTextBox cssclass="textboxwidth" runat="server" ID="txtMaximumBalance"  MaxLength="8" MaxValue="999999"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("levsal") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator69" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtMaximumBalance"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="IsWeekendExcluded" Visible="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                HeaderText="Weekend Excluded" UniqueName="TemplateColumn4">
                                                <ItemTemplate>
                                                    <asp:Label ID="levbso" runat="server" Text="Weekend Excluded"></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:CheckBox runat="server" ID="chkbxWeekendExcluded" Text="" Checked='<%# CheckBoxValue( Eval("levbso")) %>' />
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levsbo" Visible="false" FilterControlAltText="Filter TemplateColumn6 column"
                                                HeaderText="Rest Days Excluded" UniqueName="TemplateColumn6">

                                                <EditItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxRestDaysExcluded" Text="" Checked='<%# CheckBoxValue( Eval("levsbo")) %>' />
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levfba" Visible="false" FilterControlAltText="Filter TemplateColumn7 column"
                                                HeaderText="Public Holiday Excluded" UniqueName="TemplateColumn7">

                                                <EditItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkbxPublicHolidayExcluded" Text="" Checked='<%# CheckBoxValue( Eval("levfba")) %>' />
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditLeave">
                                                <ItemStyle HorizontalAlign="Center" Width="25px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Leave record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteLeave" ConfirmTextFormatString='Are you sure to delete Leave record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="25px" />
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
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Type</h6>
                                    </div>
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
                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnLeaveTypeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnLeaveTypeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnLeaveTypePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />

                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                            <asp:Button runat="server" ID="btnLeaveTypePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnLeaveTypeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="LeaveTypeId" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="levtypcod" FilterControlWidth="90px" SortExpression="levtypcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Leave Type" UniqueName="TemplateColumn0">
                                        <ItemTemplate>
                                            <asp:Label ID="lbltypcod" runat="server" Text='<%# Eval("levtypcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <telerik:RadTextBox ID="txttypcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("levtypcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txttypcod"></asp:RequiredFieldValidator></td>
                                                    <td></td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levdsc" FilterControlWidth="90px" AutoPostBackOnFilter="true" SortExpression="levdsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="TemplateColumn2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("levdsc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width:154px">
                                            <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("levdsc") %>' MaxLength="200">
                                            </telerik:RadTextBox>
                                                        </td>
                                                    <td>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="txtDescription"></asp:RequiredFieldValidator>

                                                    </td>
                                                </tr>
                                                
                                            </table>
                                            
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="levsld" FilterControlWidth="90px" AutoPostBackOnFilter="true" SortExpression="levsld" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn133 column"
                                        HeaderText="Description 2" UniqueName="TemplateColumn133">
                                        <ItemTemplate>
                                            <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("levsld") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width:154px">
                                                        <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("levsld") %>' MaxLength="200">
                                            </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                            

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="false" DataField="levdft" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Default Code" UniqueName="LeaveTypeIsDefault">
                                        <ItemTemplate>
                                            <asp:Image ID="imgIsAbsent" runat="server" ImageUrl='<%# getImagePathForTrue(bool.Parse(Eval("levdft").ToString())) %>'
                                                Visible='<%# Eval("levdft") %>' />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkbxIsDefault" Text="" Checked='<%# CheckBoxValue( Eval("levdft")) %>' />
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn20 column"
                                        HeaderText="Leave Based on" UniqueName="TemplateColumn20">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="hfleavebasedlID" runat="server" Value='<%# Eval("levbso") %>' />
                                            <asp:HiddenField ID="hfleavebaseddlText" runat="server" Value='<%# Eval("levbsotext") %>' />
                                            <asp:HiddenField ID="hfleavebaseddlValue" runat="server" Value='<%# Eval("levbsovalue") %>' />
                                            <span>
                                            <telerik:RadComboBox ID="ddlLeaveBasedon" runat="server"
                                                Width="154px" DropDownWidth="154px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveBasedon4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeaveBasedon4DDL_NeedDataSource"
                                                            Width="154px" ClientSettings-EnableRowHoverStyle="True">
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="ID" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="Text" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                        HeaderText="Value" UniqueName="column3">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                                <EditFormSettings>
                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                    </EditColumn>
                                                                </EditFormSettings>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="OnLeaveBasedRowClicked"></ClientEvents>
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator51" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="ddlLeaveBasedon"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn21 column"
                                        HeaderText="Salary Based on" UniqueName="TemplateColumn21">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="hfSalaryBasedddlID" runat="server" Value='<%# Eval("levsbo") %>' />
                                            <asp:HiddenField ID="hfSalaryBasedddlText" runat="server" Value='<%# Eval("levsbotext") %>' />
                                            <asp:HiddenField ID="hfSalaryBasedddlValue" runat="server" Value='<%# Eval("levsbovalue") %>' />
                                            <span>
                                            <telerik:RadComboBox ID="ddlSalaryBasedOn" runat="server"
                                                Width="154px" DropDownWidth="154px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdSalaryBasedon4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdSalaryBasedon4DDL_NeedDataSource"
                                                            Width="154px"   ClientSettings-EnableRowHoverStyle="True">
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="ID" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="Text" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                        HeaderText="Value" UniqueName="column3">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                                <EditFormSettings>
                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                    </EditColumn>
                                                                </EditFormSettings>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="OnSalaryBasedRowClicked"></ClientEvents>
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator511" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="ddlSalaryBasedOn"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>

                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn18 column"
                                        HeaderText="Calculate Leave Provision" UniqueName="TemplateColumn18">
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="hflevprvId" runat="server" Value='<%# Eval("levprv") %>' />
                                            <asp:HiddenField ID="hflevprvtext" runat="server" Value='<%# Eval("levprvtext") %>' />
                                            <asp:HiddenField ID="hflevprvvalue" runat="server" Value='<%# Eval("levprvvalue") %>' />
                                            <span>
                                            <telerik:RadComboBox ID="ddlLeaveProvision" runat="server"
                                                Width="154px" DropDownWidth="154px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdLeaveProvision4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeaveProvision4DDL_NeedDataSource"
                                                            Width="154px" ClientSettings-EnableRowHoverStyle="True">
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="ID" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="Text" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                        HeaderText="Value" UniqueName="column3">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                                <EditFormSettings>
                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                    </EditColumn>
                                                                </EditFormSettings>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="OnLeaveProvisionRowClicked"></ClientEvents>
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator41" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="ddlLeaveProvision"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="levfba" Visible="false" FilterControlAltText="Filter TemplateColumn5 column"
                                        HeaderText="Accure Leave" UniqueName="TemplateColumn5">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px; ">
                                                        <asp:CheckBox runat="server" ID="chkbxAccureLeave" Text="" Checked='<%# CheckBoxValue( Eval("levfba")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblfrequency" class="labelWidth2" runat="server" Text="Frequency:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:HiddenField ID="hffrequencyddlID" runat="server" Value='<%# Eval("levfrq") %>' />
                                                        <asp:HiddenField ID="hffrequencyddlText" runat="server" Value='<%# Eval("levfrqtext") %>' />
                                                        <asp:HiddenField ID="hffrequencyddlValue" runat="server" Value='<%# Eval("levfrqvalue") %>' />
                                                        <span>
                                                        <telerik:RadComboBox ID="ddlFrequency" runat="server"
                                                            Width="154px" DropDownWidth="154px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 300px;">
                                                                    <telerik:RadGrid ID="rGrdFrequency4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdFrequency4DDL_NeedDataSource"
                                                                        Width="154px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                                        </ClientSettings>
                                                                        <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                                            </RowIndicatorColumn>
                                                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                                            </ExpandCollapseColumn>
                                                                            <Columns>
                                                                                <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                                    HeaderText="ID" UniqueName="column1">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                                    HeaderText="Text" UniqueName="column2">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                                    HeaderText="Value" UniqueName="column3">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                            <EditFormSettings>
                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                </EditColumn>
                                                                            </EditFormSettings>
                                                                        </MasterTableView>
                                                                        <ClientSettings>
                                                                            <ClientEvents OnRowClick="OnFrequencyRowClicked"></ClientEvents>
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
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator31" runat="server" Display="Dynamic" ErrorMessage="*" ForeColor="Red"
                                                            ControlToValidate="ddlFrequency"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levsal" Visible="false" FilterControlAltText="Filter TemplateColumn6 column"
                                        HeaderText="Leave Salary" UniqueName="TemplateColumn6">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <asp:CheckBox runat="server" ID="chkbxLeaveSalary" Text="" Checked='<%# CheckBoxValue( Eval("levsal")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lbldays" class="labelWidth2" runat="server" Text="Days:"></asp:Label>
                                                    </td>
                                                    <td style="width:154px">
                                                        <telerik:RadNumericTextBox runat="server" ID="txtbxDays" Width="154" MaxLength="8" MaxValue="999999"
                                                            AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("levday") %>'
                                                            EnableSingleInputRendering="True">
                                                            <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                KeepTrailingZerosOnFocus="True" />
                                                        </telerik:RadNumericTextBox>

                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator611" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtbxDays"></asp:RequiredFieldValidator></td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levfrw" Visible="false" FilterControlAltText="Filter TemplateColumn7 column"
                                        HeaderText="Balance Forward" UniqueName="TemplateColumn7">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <asp:CheckBox runat="server" ID="chkbxForwardBalance" Text="" Checked='<%# CheckBoxValue( Eval("levfrw")) %>' />

                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblIs_EnCashable" class="labelWidth2" runat="server" Text="Is_EnCashable:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="chkbxEncashable" Text="" Checked='<%# CheckBoxValue( Eval("levenc")) %>' />

                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="levneg" Visible="false" FilterControlAltText="Filter TemplateColumn9 column"
                                        HeaderText="Action on Negative Balance" UniqueName="TemplateColumn9">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <asp:CheckBox runat="server" ID="chkbxAllowAdvanceLeave" Text="" Checked='<%# CheckBoxValue( Eval("levneg")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblIs_Check_For_Expiry_Document" class="labelWidth2" runat="server" Text="Action on expiring document during leave:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="chkbxCheck_For_Expiry_Document" Text="" Checked='<%# CheckBoxValue( Eval("levexp")) %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levexp" Visible="false" FilterControlAltText="Filter TemplateColumn11 column"
                                        HeaderText="Warn when vacation available falls below zero" UniqueName="TemplateColumn11">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <asp:CheckBox runat="server" ID="chkbxwarnvacationbelowzero" Text="" Checked='<%# CheckBoxValue( Eval("levexp")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblIs_checkleaveforsamedepartment" class="labelWidth2" runat="server" Text="Action on leave in same department exists:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="chkbxcheckleaveforsamedepartment" Text="" Checked='<%# CheckBoxValue( Eval("levsdp")) %>' />
                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="levspo" Visible="false" FilterControlAltText="Filter TemplateColumn13 column"
                                        HeaderText="Action on leave in same position exists" UniqueName="TemplateColumn13">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px">
                                                        <asp:CheckBox runat="server" ID="chkbxcheckleaveforsameposition" Text="" Checked='<%# CheckBoxValue( Eval("levspo")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblIs_putemployeeonholduntilleavereturn" class="labelWidth2" runat="server" Text="Put Salary on hold until leave return:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:CheckBox runat="server" ID="chkbxputemployeeonholduntilleavereturn" Text="" Checked='<%# CheckBoxValue( Eval("leveho")) %>' />
                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levall" Visible="false" FilterControlAltText="Filter TemplateColumn15 column"
                                        HeaderText="Use special allowances for replacement ID" UniqueName="TemplateColumn15">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 154px; display:block" >
                                                        <asp:CheckBox runat="server" ID="chkbxusespecialallowancereplacement" Text="" Checked='<%# CheckBoxValue( Eval("levall")) %>' />
                                                    </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblcutt_of_date" class="labelWidth2" runat="server" Text="Cutt of date:"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="cutt_of_date" DbSelectedDate='<%# Bind("levcut") %>' runat="server" Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                        </telerik:RadDatePicker>

                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn17 column"
                                        HeaderText="Action on New joiner leave" UniqueName="TemplateColumn17">

                                        <EditItemTemplate>
                                            <table>

    <tr>
                                                    <td style="width: 154px">                                            
													<asp:HiddenField ID="hfNewEmoloyeeAnualId" runat="server" Value='<%# Eval("levnew") %>' />
                                            <asp:HiddenField ID="hfNewEmoloyeeAnualText" runat="server" Value='<%# Eval("levnewtext") %>' />
                                            <asp:HiddenField ID="hfNewEmoloyeeAnualValue" runat="server" Value='<%# Eval("levnewvalue") %>' />
                                            <span>
                                            <telerik:RadComboBox ID="ddlNewEmoloyeeAnualLeave" runat="server"
                                                Width="154px" DropDownWidth="154px"
                                                EmptyMessage="Please select...">

                                                <ItemTemplate>
                                                    <div style="overflow: auto; max-height: 300px;">
                                                        <telerik:RadGrid ID="rGrdNewEmoloyeeAnualLeave4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdNewEmoloyeeAnualLeave4DDL_NeedDataSource"
                                                            Width="154px" ClientSettings-EnableRowHoverStyle="True">
                                                            <ClientSettings>
                                                                <Selecting AllowRowSelect="true"></Selecting>
                                                            </ClientSettings>
                                                            <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </RowIndicatorColumn>
                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                    <HeaderStyle Width="20px"></HeaderStyle>
                                                                </ExpandCollapseColumn>
                                                                <Columns>
                                                                    <telerik:GridBoundColumn DataField="ValueSetID" Visible="false" FilterControlAltText="Filter column1 column"
                                                                        HeaderText="ID" UniqueName="column1">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Text" FilterControlAltText="Filter column2 column"
                                                                        HeaderText="Text" UniqueName="column2">
                                                                    </telerik:GridBoundColumn>
                                                                    <telerik:GridBoundColumn DataField="Value" Visible="false" FilterControlAltText="Filter column3 column"
                                                                        HeaderText="Value" UniqueName="column3">
                                                                    </telerik:GridBoundColumn>
                                                                </Columns>
                                                                <EditFormSettings>
                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                    </EditColumn>
                                                                </EditFormSettings>
                                                            </MasterTableView>
                                                            <ClientSettings>
                                                                <ClientEvents OnRowClick="OnNewEmoloyeeAnualLeaveRowClicked"></ClientEvents>
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
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="ddlNewEmoloyeeAnualLeave"></asp:RequiredFieldValidator>
                                                        </td>
                                                    <td style="padding:0 10px;">
                                                        <asp:Label ID="lblRecalculateLeaveBalanceforEOS" class="labelWidth2" runat="server" Text="Recalculate Leave Balance for EOS:"></asp:Label>
                                                    </td>
                                                 <td>
                                                    <asp:CheckBox ID="CheckBox1" Text="" runat="server" AutoPostBack="true" />
                                                    </td>
                                                </tr>
                                                </table>
                                        </EditItemTemplate>

                                    </telerik:GridTemplateColumn>
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditLeaveType"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this LeaveType?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteLeaveType" ConfirmTextFormatString='Are you sure to delete Leave Type record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Leave Type record # "{0}":' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>

                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>

