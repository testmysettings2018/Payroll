<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="PositionSetup.aspx.cs" Inherits="Payroll_PositionSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style>
        .rgDetailTable .RadComboBox .rcbInputCellLeft {
            width: 118px !important;
            overflow: hidden;
        }

            .rgDetailTable .RadComboBox .rcbInputCellLeft inputs {
                width: 140px !important;
            }

        .rgDetailTable .RadComboBoxDropDown {
            min-width: 150px !important;
        }
    </style>

    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnPositionExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPositionCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPositionPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnPositionPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnPositionRefresh") >= 0 ||

                      args.get_eventTarget().indexOf("btnContributionRecordsExportExcel") >= 0 ||
                      args.get_eventTarget().indexOf("btnContributionRecordsExportCsv") >= 0 ||
                      args.get_eventTarget().indexOf("btnContributionRecordsExportPdf") >= 0 ||
                      args.get_eventTarget().indexOf("btnContributionRecordsPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnContributionRecordsRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnCitizensExportExcel") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensExportCsv") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensExportPdf") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnCitizensRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnExpatriateExportExcel") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateExportCsv") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateExportPdf") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriatePrint") >= 0 ||
                   args.get_eventTarget().indexOf("btnExpatriateRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnLoanExportExcel") >= 0 ||
                 args.get_eventTarget().indexOf("btnLoanExportCsv") >= 0 ||
                 args.get_eventTarget().indexOf("btnLoanExportPdf") >= 0 ||
                 args.get_eventTarget().indexOf("btnLoanPrint") >= 0 ||
                 args.get_eventTarget().indexOf("btnLoanRefresh") >= 0
                  ) {
                    args.set_enableAjax(false);
                }
            }

            function OnLoanCodeRowClick(sender, args) {
                var cellValues = args.getDataKeyValue("loncod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLoanCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnPayCodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("paycod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnDeductionCodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("dedcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDeductionCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnBenefitCodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("bftcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdBenefitCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnOvertimeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("ovtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposOvertime4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnNextPositionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("poscod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposNextPosition4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnTicketClassRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rposTicketClass4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnCalenderRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("calcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposCalender4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGraduityRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposGraduity4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGraduityProvRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("grtcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposGraduityProv4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function OnLeaveRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("levcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rposLeave4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }


            function ValidatePosition(txtPositionCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtPositionCodeId).val() == undefined || $('#' + txtPositionCodeId).val() == "") {
                    str = 'Position Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateLoan(txtbxMaxLoanAmountId, ddlLoanCodeId) {
                var str = '';
                if ($('#' + ddlLoanCodeId).val() == undefined || $('#' + ddlLoanCodeId).val() == "") {
                    str = 'Loan Code Required.<br/>';
                }
                if ($('#' + txtbxMaxLoanAmountId).val() == undefined || $('#' + txtbxMaxLoanAmountId).val() == "") {
                    str += 'Maximum Loan Amount Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidatePositionCiizensPayCodes(txtCPCsngfrmId, txtBxCPCsngtooId, txtBxCmarfrmId, txtBxCPCmartooId, ddlPayCodeId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlPayCodeId).val() == undefined || $('#' + ddlPayCodeId).val() == "") {
                    str += 'Pay Code Required.<br/>';
                }
                if ($('#' + txtCPCsngfrmId).val() == undefined || $('#' + txtCPCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxCPCsngtooId).val() == undefined || $('#' + txtBxCPCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtCPCsngfrmId).val()) > parseInt($('#' + txtBxCPCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxCmarfrmId).val() == undefined || $('#' + txtBxCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxCPCmartooId).val() == undefined || $('#' + txtBxCPCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxCmarfrmId).val()) > parseInt($('#' + txtBxCPCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidatePositionCiizensBenefitCodes(txtCBCsngfrmId, txtBxCBCsngtooId, txtBxCBCmarfrmId, txtBxCBCmartooId, ddlBenefitId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlBenefitId).val() == undefined || $('#' + ddlBenefitId).val() == "") {
                    str += 'Benefit Code Required.<br/>';
                }
                if ($('#' + txtCBCsngfrmId).val() == undefined || $('#' + txtCBCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxCBCsngtooId).val() == undefined || $('#' + txtBxCBCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtCBCsngfrmId).val()) > parseInt($('#' + txtBxCBCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxCBCmarfrmId).val() == undefined || $('#' + txtBxCBCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxCBCmartooId).val() == undefined || $('#' + txtBxCBCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxCBCmarfrmId).val()) > parseInt($('#' + txtBxCBCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidatePositionCiizensDeductionCodes(txtCDCsngfrmId, txtBxCDCsngtooId, txtBxCDCmarfrmId, txtBxCDCmartooId, ddlDeductionId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlDeductionId).val() == undefined || $('#' + ddlDeductionId).val() == "") {
                    str += 'Deduction Code Required.<br/>';
                }
                if ($('#' + txtCDCsngfrmId).val() == undefined || $('#' + txtCDCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxCDCsngtooId).val() == undefined || $('#' + txtBxCDCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtCDCsngfrmId).val()) > parseInt($('#' + txtBxCDCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxCDCmarfrmId).val() == undefined || $('#' + txtBxCDCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxCDCmartooId).val() == undefined || $('#' + txtBxCDCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxCDCmarfrmId).val()) > parseInt($('#' + txtBxCDCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidatePositionExpatriatePayCodes(txtEPCsngfrmId, txtBxEPCsngtooId, txtBxEPCmarfrmId, txtBxEPCmartooId, ddlPayCodeId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlPayCodeId).val() == undefined || $('#' + ddlPayCodeId).val() == "") {
                    str += 'Pay Code Required.<br/>';

                }
                if ($('#' + txtEPCsngfrmId).val() == undefined || $('#' + txtEPCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxEPCsngtooId).val() == undefined || $('#' + txtBxEPCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtEPCsngfrmId).val()) > parseInt($('#' + txtBxEPCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxEPCmarfrmId).val() == undefined || $('#' + txtBxEPCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxEPCmartooId).val() == undefined || $('#' + txtBxEPCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxEPCmarfrmId).val()) > parseInt($('#' + txtBxEPCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpatriateBenefitCodes(txtEBCsngfrmId, txtBxEBCsngtooId, txtBxEBCmarfrmId, txtBxEBCmartooId, ddlBenefitId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;
                if ($('#' + ddlBenefitId).val() == undefined || $('#' + ddlBenefitId).val() == "") {
                    str += 'Benefit Code Required.<br/>';
                }
                if ($('#' + txtEBCsngfrmId).val() == undefined || $('#' + txtEBCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }

                if ($('#' + txtBxEBCsngtooId).val() == undefined || $('#' + txtBxEBCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtEBCsngfrmId).val()) > parseInt($('#' + txtBxEBCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxEBCmarfrmId).val() == undefined || $('#' + txtBxEBCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxEBCmartooId).val() == undefined || $('#' + txtBxEBCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxEBCmarfrmId).val()) > parseInt($('#' + txtBxEBCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpatriateDeductionCodes(txtEDCsngfrmId, txtBxEDCsngtooId, txtBxEDCmarfrmId, txtBxEDCmartooId, ddlDeductionId) {
                var str = '';
                var needSingleCamparison = true;
                var needMarriedCamparison = true;

                if ($('#' + ddlDeductionId).val() == undefined || $('#' + ddlDeductionId).val() == "") {
                    str += 'Deduction Code Required.<br/>';
                }
                if ($('#' + txtEDCsngfrmId).val() == undefined || $('#' + txtEDCsngfrmId).val() == "") {
                    str += 'Single from Required.<br/>';
                    needSingleCamparison = false;
                }
                if ($('#' + txtBxEDCsngtooId).val() == undefined || $('#' + txtBxEDCsngtooId).val() == "") {
                    str += 'Single To Required.<br/>';
                    needSingleCamparison = false;
                }
                if (needSingleCamparison) {
                    if (parseInt($('#' + txtEDCsngfrmId).val()) > parseInt($('#' + txtBxEDCsngtooId).val())) {
                        str += 'Greater Single To Value Required.<br/>';
                    }
                }
                if ($('#' + txtBxEDCmarfrmId).val() == undefined || $('#' + txtBxEDCmarfrmId).val() == "") {
                    str += 'Married from Required.<br/>';
                    needMarriedCamparison = false;
                }
                if ($('#' + txtBxEDCmartooId).val() == undefined || $('#' + txtBxEDCmartooId).val() == "") {
                    str += 'Married to Required.<br/>';
                    needMarriedCamparison = false;
                }
                if (needMarriedCamparison) {
                    if (parseInt($('#' + txtBxEDCmarfrmId).val()) > parseInt($('#' + txtBxEDCmartooId).val())) {
                        str += 'Greater Married To Value Required.<br/>';
                    }
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function OnContributionCodeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "cntcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdContributionCode4DDL', ''));
                combo.set_text(headerValues);
            }

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }

        </script>
    </telerik:RadCodeBlock>
    <fieldset>
        <div class="widget">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                <div class="formRight">
                    <telerik:RadGrid ID="gvPosition" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvPosition_InsertCommand"
                        OnNeedDataSource="gvPosition_NeedDataSource" PageSize="20" OnDeleteCommand="gvPosition_DeleteCommand"
                        OnUpdateCommand="gvPosition_UpdateCommand" OnItemDataBound="gvPosition_ItemDataBound"
                        OnItemCommand="gvPosition_ItemCommand" OnDetailTableDataBind="gvPosition_DetailTableDataBind" OnItemCreated="gvPosition_ItemCreated">
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
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="true" Name="Citizens" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Citizens</h6>
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
                                                                <%--<asp:Button ID="btnCitizensAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button runat="server" ID="btnCitizensExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                <asp:Button runat="server" ID="btnCitizensExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                <asp:Button runat="server" ID="btnCitizensExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                <asp:Button runat="server" ID="btnCitizensPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                <asp:Button ID="btnCitizensRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="CiizensPayCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Pay Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="true">
                                                    <ColumnValidationSettings>
                                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                                    </ColumnValidationSettings>
                                                    <FilterTemplate>
                                                        <strong>Search</strong>
                                                    </FilterTemplate>
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>

                                                <telerik:GridTemplateColumn DataField="pospcc" SortExpression="pospcc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Pay Code" UniqueName="TemplateColumn132">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlPayCode" runat="server" Text='<%# Eval("pospcc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlPayCodeId" runat="server" Value='<%# Eval("pospci") %>' />
                                                                    <asp:HiddenField ID="hfddlPayCodeText" runat="server" Value='<%# Eval("pospcc") %>' />
                                                                    <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdPayCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnPayCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator66" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlPayCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCPCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtCPCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtCPCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCPCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCPCsngtoo" Width="75" MaxLength="9" MaxValue="9999999" AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCPCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="comparefieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCPCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtCPCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCPCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCPCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCPCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCPCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCPCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCPCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare1fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCPCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxCPCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this  Citizen Pay Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete Citizen Pay code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" EditMode="InPlace" AllowFilteringByColumn="true" Name="CiizensBenefitCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Benefit Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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

                                                <telerik:GridTemplateColumn DataField="posbnc" SortExpression="posbnc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Benefit Code" UniqueName="TemplateColumn12">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlBenefitCode" runat="server" Text='<%# Eval("posbnc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlBenefitCodeID" runat="server" Value='<%# Eval("posbni") %>' />
                                                                    <asp:HiddenField ID="hfddlBenefitCodeText" runat="server" Value='<%# Eval("posbnc") %>' />

                                                                    <telerik:RadComboBox ID="ddlBenefitCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelBenefitCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdBenefitCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBenefitCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                                    </ClientSettings>
                                                                                    <MasterTableView DataKeyNames="recidd,bftcod,bftds1" ClientDataKeyNames="recidd,bftcod,bftds1">
                                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </RowIndicatorColumn>
                                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </ExpandCollapseColumn>
                                                                                        <Columns>
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="bftcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="bftds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnBenefitCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBenefitCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                                </td> <td style="border-bottom:0px">     <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlBenefitCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCBCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtCBCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtCBCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCBCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCBCsngtoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCBCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare2fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCBCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtCBCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCBCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCBCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCBCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCBCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCBCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCBCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare3fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCBCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxCBCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen Benefit Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete  Citizen Benefit Code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="CiizensDeductionCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Deduction Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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

                                                <telerik:GridTemplateColumn DataField="posddc" SortExpression="posddc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Deduction Code" UniqueName="TemplateColumn1233">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlDeductionCode" runat="server" Text='<%# Eval("posddc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlDeductionCodeID" runat="server" Value='<%# Eval("posddi") %>' />
                                                                    <asp:HiddenField ID="hfddlDeductionCodeText" runat="server" Value='<%# Eval("posddc") %>' />
                                                                    <telerik:RadComboBox ID="ddlDeductionCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDeductionCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdDeductionCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDeductionCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="dedcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="dedds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnDeductionCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDeductionCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                               </td> <td style="border-bottom:0px">      <asp:RequiredFieldValidator ID="RequiredFieldValidator61" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlDeductionCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCDCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtCDCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtCDCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCDCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCDCsngtoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCDCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare4fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCDCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtCDCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCDCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCDCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCDCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCDCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxCDCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCDCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare5fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxCDCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxCDCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this  Citizen Deduction Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete   Citizen Deduction Code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="CitizenLoanRecords" CommandItemDisplay="Top"
                                            DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Loan Codes</h6>
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
                                                                        <asp:Button ID="btnAddLoan" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnLoanExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnLoanExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnLoanExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnLoanPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnLoanRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                <telerik:GridTemplateColumn DataField="loncod" SortExpression="loncod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Loan Code" UniqueName="TemplateColumn0301">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblclslnc" runat="server" Text='<%# Eval("loncod") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 155px;border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlLoanCodeId" runat="server" Value='<%# Eval("lonidd") %>' />
                                                                    <asp:HiddenField ID="hfddlLoanCodeText" runat="server" Value='<%# Eval("loncod") %>' />
                                                                    <telerik:RadComboBox ID="ddlLoanCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelLoanCode" runat="server" Width="155px" LoadingPanelID="RadAjaxLoadingPanelLoanCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdLoanCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLoanCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                    </ClientSettings>

                                                                                    <MasterTableView DataKeyNames="recidd,loncod,lvcds1" ClientDataKeyNames="recidd,loncod,lvcds1">
                                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </RowIndicatorColumn>
                                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </ExpandCollapseColumn>
                                                                                        <Columns>
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="recidd">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="loncod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="loncod">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="lvcds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="lvcds1">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnLoanCodeRowClick"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLoanCode" runat="server">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>

                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1281" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                        ControlToValidate="ddlLoanCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="lonmax" SortExpression="lonmax" FilterControlWidth="130px" CurrentFilterFunction="EqualTo"
                                                    AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Max. Loan Amount" UniqueName="TemplateColumn21">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMaxLoanAmount" runat="server" Text='<%# Eval("lonmax", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px;border-bottom:0px">

                                                                    <telerik:RadNumericTextBox runat="server" ID="txtbxMaxLoanAmount" ClientIDMode="Static" Width="75" MaxValue="999999" MaxLength="8"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("lonmax") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2123" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtbxMaxLoanAmount"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditLoanRecords" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen Loan record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteLoanRecords" ConfirmTextFormatString='Are you sure to delete Citizen Loan record # {0}?'>
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


                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" Name="CitizenContributionCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Contribution Codes</h6>
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
                                                                        <asp:Button ID="btnContributionRecordsAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnContributionRecordsPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnContributionRecordsRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false" >
                                                    <ColumnValidationSettings>
                                                        <ModelErrorMessage Text=""></ModelErrorMessage>
                                                    </ColumnValidationSettings>
                                                    <FilterTemplate>
                                                        <strong>Search</strong>
                                                    </FilterTemplate>
                                                    <ItemStyle Width="50px" />
                                                </telerik:GridBoundColumn>
                                                <telerik:GridTemplateColumn DataField="cntcod" SortExpression="cntcod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                                    CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Contribution Code" UniqueName="TemplateColumn001">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcontributioncod" runat="server" Text='<%# Eval("cntcod") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px">
                                                                    <asp:HiddenField ID="hfPositionId" runat="server" Value='<%# Eval("posidd") %>' />
                                                                    <asp:HiddenField ID="hfPositionTyp" runat="server" Value='<%# Eval("postyp") %>' />

                                                                    <telerik:RadComboBox ID="ddlContributionCode" runat="server"
                                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelContributionCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelContributionCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdContributionCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdContributionCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                    </ClientSettings>

                                                                                    <MasterTableView DataKeyNames="recidd,cntcod,cntds1" ClientDataKeyNames="recidd,cntcod,cntds1">
                                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                                                                                            <telerik:GridBoundColumn DataField="cntcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="cntcod">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="cntds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="cntds1">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowDeselected="OnContributionCodeRowSelected" OnRowSelected="OnContributionCodeRowSelected"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelContributionCode" runat="server">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>

                                                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator122222" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlPaycode"></asp:RequiredFieldValidator>--%>
                                                                </td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="cntds1" SortExpression="cntds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("cntds1") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditContributionCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen Contribution Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteContributionCode" ConfirmTextFormatString='Are you sure to delete Citizen Contribution Code record # {0}?'>
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
                                        <telerik:GridTemplateColumn DataField="poscod" SortExpression="poscod" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Position" UniqueName="TemplateColumn0">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCMPosition" runat="server" Text='<%# Eval("poscod") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="postypd" SortExpression="postypd" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Employee type" UniqueName="TemplateColumn01">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCMPositionEmployementType" runat="server" Text='<%# Eval("postypd") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--  <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditCitizen" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteCitizen" ConfirmTextFormatString='Are you sure to delete Citizen record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>--%>
                                    </Columns>
                                    <SortExpressions>
                                        <telerik:GridSortExpression FieldName="recidd" SortOrder="Ascending" />
                                    </SortExpressions>
                                    <EditFormSettings>
                                        <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                        </EditColumn>
                                    </EditFormSettings>
                                </telerik:GridTableView>
                                <telerik:GridTableView runat="server" AllowFilteringByColumn="true" Name="Expatriate" CommandItemDisplay="Top" DataKeyNames="recidd">
                                    <CommandItemTemplate>
                                        <div class="title">
                                            <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expatriate</h6>
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
                                                                <%--                                                                <asp:Button ID="btnCitizensAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button runat="server" ID="btnCitizensExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                <asp:Button runat="server" ID="btnCitizensExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                <asp:Button runat="server" ID="btnCitizensExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                <asp:Button runat="server" ID="btnCitizensPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                <asp:Button ID="btnCitizensRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="ExpatriatePayCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Pay Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                <telerik:GridTemplateColumn DataField="pospcc" SortExpression="pospcc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Pay Code" UniqueName="TemplateColumn152">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlPayCode" runat="server" Text='<%# Eval("pospcc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlPayCodeId" runat="server" Value='<%# Eval("pospci") %>' />
                                                                    <asp:HiddenField ID="hfddlPayCodeText" runat="server" Value='<%# Eval("pospcc") %>' />
                                                                    <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel2" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdPayCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="paycod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnPayCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator66" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlPayCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEPCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtEPCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtEPCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEPCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEPCsngtoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEPCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare7fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEPCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtEPCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEPCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEPCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEPCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEPCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEPCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEPCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare8fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEPCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxEPCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate Pay Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete Expatriate Pay Code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="ExpatriateBenefitCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Benefit Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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

                                                <telerik:GridTemplateColumn DataField="posbnc" SortExpression="posbnc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Benefit Code" UniqueName="TemplateColumn12">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlBenefitCode" runat="server" Text='<%# Eval("posbnc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlBenefitCodeID" runat="server" Value='<%# Eval("posbni") %>' />
                                                                    <asp:HiddenField ID="hfddlBenefitCodeText" runat="server" Value='<%# Eval("posbnc") %>' />

                                                                    <telerik:RadComboBox ID="ddlBenefitCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelBenefitCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdBenefitCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBenefitCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                                    </ClientSettings>
                                                                                    <MasterTableView DataKeyNames="recidd,bftcod,bftds1" ClientDataKeyNames="recidd,bftcod,bftds1">
                                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </RowIndicatorColumn>
                                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </ExpandCollapseColumn>
                                                                                        <Columns>
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="bftcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="bftds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnBenefitCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBenefitCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                               </td><td    style="border-bottom:0px"  ><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlBenefitCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>


                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEBCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtEBCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtEBCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEBCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEBCsngtoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEBCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare92fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEBCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtEBCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEBCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEBCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEBCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEBCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEBCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEBCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare95fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEBCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxEBCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate Benefit Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete Expatriate Benefit Code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="ExpatriateDeductionCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Deduction Codes</h6>
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
                                                                        <asp:Button ID="btnExpatriateAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnExpatriateExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnExpatriateExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnExpatriatePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnExpatriateRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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

                                                <telerik:GridTemplateColumn DataField="posddc" SortExpression="posddc" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Deduction Code" UniqueName="TemplateColumn1233">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblddlDeductionCode" runat="server" Text='<%# Eval("posddc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlDeductionCodeID" runat="server" Value='<%# Eval("posddi") %>' />
                                                                    <asp:HiddenField ID="hfddlDeductionCodeText" runat="server" Value='<%# Eval("posddc") %>' />
                                                                    <telerik:RadComboBox ID="ddlDeductionCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel3" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDeductionCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdDeductionCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDeductionCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="column1">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="dedcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="column2">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="dedds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="column3">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnDeductionCodeRowClicked"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDeductionCode" runat="server" Skin="Default" Transparency="20">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>
                                                               </td> <td   style="border-bottom:0px" >  <asp:RequiredFieldValidator ID="RequiredFieldValidator61" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="ddlDeductionCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="possfrm" SortExpression="possfrm" FilterControlAltText="Filter TemplateColumn1 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single From" UniqueName="TemplateColumn1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEDCsngfrm" runat="server" Text='<%# Eval("possfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtEDCsngfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtEDCsngfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="possto" SortExpression="possto" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Single To" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEDCsngtoo" runat="server" Text='<%# Eval("possto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEDCsngtoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("possto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEDCsngtoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare19fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEDCsngtoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtEDCsngfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmfrm" SortExpression="posmfrm" FilterControlAltText="Filter TemplateColumn3 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false"
                                                    HeaderText="Married From" UniqueName="TemplateColumn3">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEDCmarfrm" runat="server" Text='<%# Eval("posmfrm", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEDCmarfrm" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmfrm") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEDCmarfrm"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="posmto" SortExpression="posmto" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn4 column"
                                                    HeaderText="Married To" UniqueName="TemplateColumn4">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEDCmartoo" runat="server" Text='<%# Eval("posmto", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">
                                                                    <telerik:RadNumericTextBox runat="server" ID="txtBxEDCmartoo" Width="75" MaxLength="9" MaxValue="9999999"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("posmto") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>


                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEDCmartoo"></asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ID="compare10fieldvalidator" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtBxEDCmartoo" Operator="GreaterThanEqual" Type="Integer"
                                                                        ControlToCompare="txtBxEDCmarfrm"></asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditExpat" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate Deduction Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteExpat" ConfirmTextFormatString='Are you sure to delete Expatriate Deduction Code record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true" EditMode="InPlace" Name="ExpatriateLoanRecords" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Loan Codes</h6>
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
                                                                        <asp:Button ID="btnAddLoan" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnLoanExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnLoanExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnLoanExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnLoanPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnLoanRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                <telerik:GridTemplateColumn DataField="loncod" SortExpression="loncod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Loan Code" UniqueName="TemplateColumn0301">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblclslnc" runat="server" Text='<%# Eval("loncod") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="border-bottom:0px">
                                                                    <asp:HiddenField ID="hfddlLoanCodeId" runat="server" Value='<%# Eval("lonidd") %>' />
                                                                    <asp:HiddenField ID="hfddlLoanCodeText" runat="server" Value='<%# Eval("loncod") %>' />
                                                                    <telerik:RadComboBox ID="ddlLoanCode" runat="server"
                                                                        Width="155px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelLoanCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLoanCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdLoanCode4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLoanCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                    </ClientSettings>

                                                                                    <MasterTableView DataKeyNames="recidd,loncod,lvcds1" ClientDataKeyNames="recidd,loncod,lvcds1">
                                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </RowIndicatorColumn>
                                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                                        </ExpandCollapseColumn>
                                                                                        <Columns>
                                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="recidd">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="loncod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="loncod">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="lvcds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="lvcds1">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowClick="OnLoanCodeRowClick"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLoanCode" runat="server">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>

                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1281" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                        ControlToValidate="ddlLoanCode"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridTemplateColumn DataField="lonmax" SortExpression="lonmax" FilterControlWidth="130px" CurrentFilterFunction="EqualTo"
                                                    AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Max. Loan Amount" UniqueName="TemplateColumn21">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblMaxLoanAmount" runat="server" Text='<%# Eval("lonmax", "{0:0.00}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td  style="border-bottom:0px">

                                                                    <telerik:RadNumericTextBox runat="server" ID="txtbxMaxLoanAmount" ClientIDMode="Static" Width="75" MaxValue="999999" MaxLength="8"
                                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("lonmax") %>'
                                                                        EnableSingleInputRendering="True">
                                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                            KeepTrailingZerosOnFocus="True" />
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                                <td  style="border-bottom:0px">
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2123" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                        ControlToValidate="txtbxMaxLoanAmount"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditLoanRecords" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate Loan record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteLoanRecords" ConfirmTextFormatString='Are you sure to delete Expatriate Loan record # {0}?'>
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
                                        <telerik:GridTableView runat="server" AllowFilteringByColumn="true"
                                            Name="ExpatriateContributionCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
                                            <CommandItemTemplate>
                                                <div class="title">
                                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Contribution Codes</h6>
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
                                                                        <asp:Button ID="btnContributionRecordsAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                        <asp:Button runat="server" ID="btnContributionRecordsExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                        <asp:Button runat="server" ID="btnContributionRecordsPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                        <asp:Button ID="btnContributionRecordsRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                <telerik:GridTemplateColumn DataField="cntcod" SortExpression="cntcod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                                    CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                    HeaderText="Contribution Code" UniqueName="TemplateColumn001">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcontributioncod" runat="server" Text='<%# Eval("cntcod") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px">
                                                                    <asp:HiddenField ID="hfPositionId" runat="server" Value='<%# Eval("posidd") %>' />
                                                                    <asp:HiddenField ID="hfPositionTyp" runat="server" Value='<%# Eval("postyp") %>' />

                                                                    <telerik:RadComboBox ID="ddlContributionCode" runat="server"
                                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelContributionCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelContributionCode" Height="200px">
                                                                                <telerik:RadGrid ID="rGrdContributionCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdContributionCode4DDL_NeedDataSource"
                                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                    <ClientSettings>
                                                                                        <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                    </ClientSettings>

                                                                                    <MasterTableView DataKeyNames="recidd,cntcod,cntds1" ClientDataKeyNames="recidd,cntcod,cntds1">
                                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                                                                                            <telerik:GridBoundColumn DataField="cntcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="cntcod">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="cntds1" FilterControlAltText="Filter column3 column"
                                                                                                HeaderText="Description" UniqueName="cntds1">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowDeselected="OnContributionCodeRowSelected" OnRowSelected="OnContributionCodeRowSelected"></ClientEvents>
                                                                                    </ClientSettings>
                                                                                    <FilterMenu EnableImageSprites="False">
                                                                                    </FilterMenu>
                                                                                </telerik:RadGrid>
                                                                            </telerik:RadAjaxPanel>
                                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelContributionCode" runat="server">
                                                                            </telerik:RadAjaxLoadingPanel>
                                                                        </ItemTemplate>
                                                                        <Items>
                                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                        </Items>
                                                                    </telerik:RadComboBox>

                                                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator122222" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlPaycode"></asp:RequiredFieldValidator>--%>
                                                                </td>
                                                                <td></td>
                                                                <td></td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridTemplateColumn DataField="cntds1" SortExpression="cntds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("cntds1") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                    UniqueName="EditContributionCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                    <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                </telerik:GridEditCommandColumn>
                                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Expatriate Contribution Code record?"
                                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                    UniqueName="DeleteContributionCode" ConfirmTextFormatString='Are you sure to delete Expatriate Contribution Code record # {0}?'>
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
                                        <telerik:GridTemplateColumn DataField="poscod" SortExpression="poscod" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Position" UniqueName="TemplateColumn0">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCMPosition" runat="server" Text='<%# Eval("poscod") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <telerik:GridTemplateColumn DataField="postypd" SortExpression="postypd" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="false" FilterControlAltText="Filter TemplateColumn0 column"
                                            HeaderText="Employee type" UniqueName="TemplateColumn01">
                                            <ItemTemplate>
                                                <asp:Label ID="lblCMPositionEmployementType" runat="server" Text='<%# Eval("postypd") %>'></asp:Label>
                                            </ItemTemplate>
                                        </telerik:GridTemplateColumn>
                                        <%--  <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditCitizen" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Citizen record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteCitizen" ConfirmTextFormatString='Are you sure to delete Citizen record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>--%>
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
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                            <CommandItemTemplate>
                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Position Setup</h6>
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
                                                        <asp:Button runat="server" ID="btnPositionExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />
                                                        <asp:Button runat="server" ID="btnPositionCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />
                                                        <asp:Button runat="server" ID="btnPositionPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                        <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                        <asp:Button runat="server" ID="btnPositionPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />
                                                        <asp:Button ID="btnPositionRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                <telerik:GridBoundColumn DataField="recidd" AllowFiltering="false" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                    <ItemStyle />
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="poscod" SortExpression="poscod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Position Code" UniqueName="TemplateColumn001">
                                    <ItemTemplate>
                                        <asp:Label ID="lblposcod" runat="server" Text='<%# Eval("poscod") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadTextBox ID="txtPositionCode" MaxLength="15" runat="server" Text='<%# Eval("poscod") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtPositionCode"></asp:RequiredFieldValidator>
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="posds1" SortExpression="posds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("posds1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("posds1") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="posds2" SortExpression="posds2" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn133 column"
                                    HeaderText="Description 2" UniqueName="TemplateColumn133">
                                    <ItemTemplate>
                                        <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("posds2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("posds2") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Ticket Class" UniqueName="TemplateColumn025363">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTicketClass" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfTicketClassdllID" runat="server" Value='<%# Eval("postcc") %>' />
                                                    <asp:HiddenField ID="hfTicketClassdllText" runat="server" Value='<%# Eval("postcctext") %>' />
                                                    <telerik:RadComboBox ID="ddlTicketClass" runat="server"
                                                        Width="250px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelTicketClass" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelTicketClass" Height="200px">
                                                                <telerik:RadGrid ID="rposTicketClass4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposTicketClass4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                        <ClientEvents OnRowClick="OnTicketClassRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDefaultPayrollType" runat="server" Skin="Default" Transparency="20">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>

                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCalenderID" Style="padding-left: 13px" Width="250px" runat="server" Text="Calender ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfCalenderdllID" runat="server" Value='<%# Eval("poscli") %>' />
                                                    <asp:HiddenField ID="hfCalenderdllText" runat="server" Value='<%# Eval("posclc") %>' />

                                                    <telerik:RadComboBox ID="ddlCalender" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelCalender" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCalender" Height="200px">
                                                                <telerik:RadGrid ID="rposCalender4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposCalender4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd,calcod,caldsc" ClientDataKeyNames="recidd,calcod,caldsc">
                                                                        <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="calcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="caldsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnCalenderRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCalender" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>


                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Gratuity/Indeminity" UniqueName="TemplateColumn02533">

                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfGraduitydllID" runat="server" Value='<%# Eval("posgri") %>' />
                                                    <asp:HiddenField ID="hfGraduitydllText" runat="server" Value='<%# Eval("posgrd") %>' />

                                                    <telerik:RadComboBox ID="ddlGraduity" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGraduity" Height="200px">
                                                                <telerik:RadGrid ID="rposGraduity4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposGraduity4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd, grtcod,grtdsc" ClientDataKeyNames="recidd, grtcod,grtdsc">
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnGraduityRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGraduity" runat="server" Skin="Default" Transparency="20">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblGratuityProID" Style="padding-left: 13px" Width="250px" runat="server" Text="Gratuity Prov"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfGratuityProdllID" runat="server" Value='<%# Eval("posgpi") %>' />
                                                    <asp:HiddenField ID="hfGratuityProdllText" runat="server" Value='<%# Eval("posgpc") %>' />

                                                    <telerik:RadComboBox ID="ddlGratuityPro" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGraduity" Height="200px">
                                                                <telerik:RadGrid ID="rposGraduityProv4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposGraduityProv4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd, grtcod,grtdsc" ClientDataKeyNames="recidd, grtcod,grtdsc">
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="grtdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnGraduityProvRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGraduityProv" runat="server" Skin="Default" Transparency="20">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>

                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Overtime ID" UniqueName="TemplateColumn022533">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfOvertimedllID" runat="server" Value='<%# Eval("posovi") %>' />
                                                    <asp:HiddenField ID="hfOvertimedllText" runat="server" Value='<%# Eval("posovc") %>' />

                                                    <telerik:RadComboBox ID="ddlOvertime" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelOvertime" Height="200px">
                                                                <telerik:RadGrid ID="rposOvertime4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposOvertime4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd, ovtcod,ovtdsc" ClientDataKeyNames="recidd, ovtcod,ovtdsc">
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="ovtcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="ovtdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnOvertimeRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelOvertime" runat="server" Skin="Default" Transparency="20">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLeaveID" Style="padding-left: 13px" Width="250px" runat="server" Text="Leave ID"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfLeavedllID" runat="server" Value='<%# Eval("posani") %>' />
                                                    <asp:HiddenField ID="hfLeavedllText" runat="server" Value='<%# Eval("posanc") %>' />

                                                    <telerik:RadComboBox ID="ddlLeave" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanel4" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGraduity" Height="200px">
                                                                <telerik:RadGrid ID="rposLeave4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rposLeave4DDL_NeedDataSource"
                                                                    Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                    <ClientSettings>
                                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                                    </ClientSettings>
                                                                    <MasterTableView DataKeyNames="recidd, levcod,levdsc" ClientDataKeyNames="recidd, levcod,levdsc">
                                                                        <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </RowIndicatorColumn>
                                                                        <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                            <HeaderStyle Width="20px"></HeaderStyle>
                                                                        </ExpandCollapseColumn>
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                HeaderText="ID" UniqueName="column1">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="levcod" FilterControlAltText="Filter column2 column"
                                                                                HeaderText="Code" UniqueName="column2">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Description" UniqueName="column3">
                                                                            </telerik:GridBoundColumn>
                                                                        </Columns>
                                                                        <EditFormSettings>
                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                            </EditColumn>
                                                                        </EditFormSettings>
                                                                    </MasterTableView>
                                                                    <ClientSettings>
                                                                        <ClientEvents OnRowClick="OnLeaveRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLeave" runat="server" Skin="Default" Transparency="20">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>

                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>


                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                    UniqueName="Editposcod" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Position Record?"
                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="Deleteposcod" ConfirmTextFormatString='Are you sure to delete Position record # "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Position Record # "{0}":' CaptionDataField="recidd">
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                                <EditColumn ButtonType="ImageButton" />
                            </EditFormSettings>
                        </MasterTableView>
                    </telerik:RadGrid>
                </div>
            </telerik:RadAjaxPanel>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20">
            </telerik:RadAjaxLoadingPanel>
            </div>
    </fieldset>
</asp:Content>


