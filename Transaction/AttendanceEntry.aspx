﻿<%@ Page Title="Attendance Entry" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="AttendanceEntry.aspx.cs" Inherits="Payroll_AttendanceEntry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style type="text/css">
        .rgEditForm > table tr td:first-child {min-width: 50px;}
        #mainDiv {padding: 5px; border: 1px solid #cdcdcd; margin: 5px;}
        @media only screen and (min-width: 601px) and (max-width: 1025px) {
            .RadGrid_Silk input.rgFilterBox {width:40%!important}
            .RadGrid .rgFilterRow>td {padding-left: 0px!important;padding-right: 0px!important;}
        }
        @media only screen and (min-width: 0px) and (max-width: 600px) {
            .RadGrid_Silk input.rgFilterBox {width:80%!important}
            .RadGrid_Silk .rgFilter {display:none;}
            .RadGrid .rgFilterRow>td {padding-left: 0px!important;padding-right: 0px!important;}
            #mainDiv {padding: 0px!important; border: 1px solid #cdcdcd; margin: 0px!important;}
        }
        
    </style>
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
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
                    args.get_eventTarget().indexOf("btnAttendanceDetailRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }

            function ValidateAtt(txtNormalHoursID, txtOvertime1ID, txtOvertime2ID, txtTotalOverTimeID, txtTotalHoursID, txtattcmtID) {
                var str = '';
                if ($('#' + txtNormalHoursID).val() == undefined || $('#' + txtNormalHoursID).val() == "") {
                    str += 'Normal Hours Required.<br/>';
                }
                if ($('#' + txtOvertime1ID).val() == undefined || $('#' + txtOvertime1ID).val() == "") {
                    str += 'Overtime 1 Required.<br/>';
                } else {
                    if (parseFloat($('#' + txtOvertime1ID).val()) > parseFloat($('#' + 'txtmaxovertime1').val())) {
                        str += 'Overtime 1 cant be greater than ' + parseFloat($('#' + 'txtmaxovertime1').val()) + ' .<br/>';
                    }
                }
                if ($('#' + txtOvertime2ID).val() == undefined || $('#' + txtOvertime2ID).val() == "") {
                    str += 'Overtime 2 Required.<br/>';
                } else {
                    if (parseFloat($('#' + txtOvertime2ID).val()) > parseFloat($('#' + 'txtbxmaxovertime2').val())) {
                        str += 'Overtime 2 cant be greater than ' + parseFloat($('#' + 'txtbxmaxovertime2').val()) + ' .<br/>';
                    }
                }
                if ($('#' + txtTotalOverTimeID).val() == undefined || $('#' + txtTotalOverTimeID).val() == "") {
                    str += 'Total Overtime Required.<br/>';
                }
                if ($('#' + txtTotalHoursID).val() == undefined || $('#' + txtTotalHoursID).val() == "") {
                    str += 'Total Hours Required.<br/>';
                } else {
                    if (parseFloat($('#' + txtTotalHoursID).val()) > parseFloat('24'))
                        str += 'Total Hours Cant be greater than 24 .<br/>';
                }
                //                if ($('#' + txtattcmtID).val() == undefined || $('#' + txtattcmtID).val() == "") {
                //                   str += 'Comments Required.<br/>';
                //              }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function OnProjectRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("prjcod");
                var id = args.getDataKeyValue("prjidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdProject4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
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

            function UserDeleteConfirmation() {
                return confirm("Are you sure you want to update all normal hours?");
            }

            function OnEmployeeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("empcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                    $('#ctl00_ctl00_MainContent_mainContentPlaceHolder_btnHidden').click();
                }, 50);
            }

        </script>
    </telerik:RadCodeBlock>
    <div class="widget" style="overflow:auto;">
        <fieldset>
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <table border="1" width="100%">
                            <tr>
                                <td>
                                    <div id="mainDiv" >
                                        <asp:Button ID="btnHidden" runat="server" Style="display: none;"
                                            CausesValidation="false" />
                                        <table>
                                            <tr>
                                                <%--<td style="width: 110px; border-bottom: 0px; padding-bottom: 10px">
                                                    <asp:Label ID="Label2" runat="server" Text="Employee:" meta:resourcekey="LabelResource1" Style="padding-left: 10px; padding-right: 10px"></asp:Label>
                                                </td>--%>
                                                <td style=" border-bottom: 0px; padding-left: 0px">
                                                    <div Style="float: left;width:271px;">
                                                    <asp:Label ID="Label2" runat="server" Text="Employee:" meta:resourcekey="LabelResource1" Style="padding-left: 10px; padding-right: 10px"></asp:Label>
                                                    <span class="combo180">
                                                    <telerik:RadComboBox ID="ddlEmployee" runat="server" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged"
                                                        Width="180px" DropDownWidth="180px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                                <div style="overflow: auto; max-height: 200px;">
                                                                    <telerik:RadGrid ID="rGrdEmployee4DDL" AllowMultiRowSelection="false" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource"
                                                                        Width="180px" ClientSettings-EnableRowHoverStyle="True">
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

                                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column1 column"
                                                                                    HeaderText="ID" UniqueName="recidd">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="empcod" FilterControlAltText="Filter column2 column"
                                                                                    HeaderText="Code" UniqueName="empcod">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="empfsn" FilterControlAltText="filter column3 column"
                                                                                    HeaderText="Name" UniqueName="empfsn">
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

                                                    <asp:RequiredFieldValidator ID="FieldValidatasdor1" Style=" padding-left: 8px" runat="server" meta:resourcekey="LabelResource3" ErrorMessage="*" ForeColor="Red" Display="Static"
                                                        ControlToValidate="ddlEmployee"></asp:RequiredFieldValidator>
                                                    </div>
                                                    <div id="lblCalenderDiv" Style="float: left;height:35px;">
                                                    <asp:Label ID="Label3" runat="server" Text="Calender:" meta:resourcekey="LabelResource2" Style="padding-left: 10px; padding-right: 30px;line-height:3;"></asp:Label>
                                                    <asp:Label ID="lblCalender" Text="" runat="server" meta:resourcekey="LabelResource2" Style="padding-left: 10px; padding-right: 10px;line-height:3;"></asp:Label>
                                                    </div>
                                                    <div Style="float: left;height:35px;">
                                                    <asp:Label ID="Label4" Text="Shift:" runat="server" meta:resourcekey="LabelResource2" Style="padding-left: 10px; padding-right: 30px;line-height:3;"></asp:Label>
                                                    <asp:Label ID="lblShift" Text="" runat="server" meta:resourcekey="LabelResource2" Style="padding-left: 10px; padding-right: 10px;line-height:3;"></asp:Label>
                                                    </div>
                                                </td>

                                            </tr>
                                        </table>
                                        <table>

                                            <tr>
                                                <td style=" border-bottom: 0px; padding-bottom: 10px">
                                                    <div Style="float: left;width:271px;">
                                                    <asp:Label ID="lbdasdalassadsdsdsdfsffsf" runat="server" Text="Start Date:" meta:resourcekey="LabelResource1" Style="padding-left: 10px; padding-right: 10px"></asp:Label>
                                                    <telerik:RadDatePicker ID="dtpStartDate" runat="server" Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    </telerik:RadDatePicker>
                                                    <asp:RequiredFieldValidator ID="FieldVahjhjlidatkjlkjlkor631131" Style="padding-left: 5px" runat="server" meta:resourcekey="LabelResource3" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                        ControlToValidate="dtpStartDate"></asp:RequiredFieldValidator>
                                                        </div>
                                                    <div Style="float: left;width:271px;">
                                                    <asp:Label ID="Label1" runat="server" Text="End Date:" meta:resourcekey="LabelResource2" Style="padding-left: 10px; padding-right: 14px"></asp:Label>
                                                    <telerik:RadDatePicker ID="dtpEndDate" runat="server" Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    </telerik:RadDatePicker>
                                                     <span style="padding-right:10px;padding-left:10px; display:inline-block!important;">   
                                                    <asp:RequiredFieldValidator ID="FieldValidatkjlkjlkor631131" Style=" padding-left: 5px;" runat="server" meta:resourcekey="LabelResource3" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                        ControlToValidate="dtpEndDate"></asp:RequiredFieldValidator>
                                                    <asp:CompareValidator ID="compare0fieldvalisdfdator" runat="server" ErrorMessage="Greater Required" ForeColor="Red" Display="Dynamic"
                                                        ControlToValidate="dtpEndDate" Operator="GreaterThanEqual" meta:resourcekey="LabelResource50" style="display:inline-block!important;"
                                                        ControlToCompare="dtpStartDate"></asp:CompareValidator>
                                                         </span>
                                                        </div>
                                                    <asp:Button ID="btnSearch" runat="server" CausesValidation="true" Style="float:left;margin-top: 3px;" Text="Search" meta:resourcekey="LabelResource4" OnClick="btnSearch_Click" />
                                                </td>

                                            </tr>
                                        </table>
                                        <br />
                                        <telerik:RadGrid ID="gvAtt" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="False"
                                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvAtt_InsertCommand"
                                            OnNeedDataSource="gvAtt_NeedDataSource" PageSize="31" OnDeleteCommand="gvAtt_DeleteCommand"
                                            OnUpdateCommand="gvAtt_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvAtt_ItemDataBound"
                                            OnItemCommand="gvAtt_ItemCommand" OnDetailTableDataBind="gvAtt_DetailTableDataBind"
                                            OnItemCreated="gvAtt_ItemCreated">
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
                                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="Date"
                                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                                <DetailTables>
                                                </DetailTables>
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" />
                                                        <h6>Attendance List</h6>
                                                    </div>
                                                    <tr class="rgCommandRow">

                                                        <td colspan="9" class="rgCommandCell">

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
                                                                            <asp:Button ID="Button1" Visible="false" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="left" style="padding-left: 285px">
                                                                            <asp:Button runat="server" ID="btnUpdateNH" OnClientClick="if (! UserDeleteConfirmation())
                                                                                return false;"
                                                                                CausesValidation="false" CommandName="UpdateAll" AlternateText="Update All" ToolTip="Update All" Text="Update All" />
                                                                            <div style="float:right">
                                                                                <asp:Button runat="server" ID="btnFilesExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnFilesCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnFilesPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <span>
                                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                                            </span>
                                                                            <asp:Button runat="server" ID="btnFilesPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnFilesRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                                        </td>
                                                                            </div>
                                                                        </td>
                                                                        <%--<td align="right">
                                                                            <asp:Button runat="server" ID="btnFilesExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnFilesCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnFilesPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <span>
                                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                                            </span>
                                                                            <asp:Button runat="server" ID="btnFilesPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnFilesRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
                                                                        </td>--%>
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
                                                            <asp:Label ID="lblOvertime2sad" runat="server" Text='<%# Eval("DayName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="additionalColumn" />
                                                        <ItemStyle CssClass="additionalColumn" />
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridBoundColumn UniqueName="IsPublicHoliday" DataField="IsPublicHoliday" ItemStyle-Width="0px" Display="false">
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridBoundColumn UniqueName="IsWeekend" DataField="IsWeekend" ItemStyle-Width="0px" Display="false">
                                                    </telerik:GridBoundColumn>
                                                    <telerik:GridTemplateColumn DataField="atthrs" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="atthrs" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Normal Hours" UniqueName="atthrs">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblNormalHours" runat="server" Text='<%# Eval("atthrs") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:HiddenField ID="maxnormalhrs" runat="server" ClientIDMode="Static" Value='<%# Eval("maxnormalhrs") %>' />
                                                                        <telerik:RadNumericTextBox ID="txtNormalHours" ClientEvents-OnValueChanged="onNormalHoursChange"
                                                                            ClientIDMode="Static"
                                                                            MaxLength="4" runat="server" Text='<%# Eval("atthrs") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFiasdfeldValidasdfator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtNormalHours"></asp:RequiredFieldValidator>

                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="attot1" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="attot1"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Overtime 1" UniqueName="attot1">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOvertime1" runat="server" Text='<%# Eval("attot1") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:TextBox runat="server" ID="txtmaxovertime1" ClientIDMode="Static" Style="display: none" Width="2px" Text='<%# Eval("maxovt1hrs") %>'></asp:TextBox>
                                                                        <telerik:RadNumericTextBox ID="txtOvertime1" ClientIDMode="Static"
                                                                            ClientEvents-OnValueChanged="onOvertime1Change" MaxLength="4"
                                                                            MaxValue="9" runat="server" Text='<%# Eval("attot1") %>'>
                                                                        </telerik:RadNumericTextBox>

                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidasdfator6111" Style="float: left" runat="server" ErrorMessage="req ot1" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtOvertime1"></asp:RequiredFieldValidator>
                                                                        <asp:CompareValidator ID="compare0fieldvalisdssdfsdsddator" runat="server" ErrorMessage="*"
                                                                            ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtOvertime1" Operator="LessThanEqual" Type="Double" meta:resourcekey="LabelResource50"
                                                                            ControlToCompare="txtmaxovertime1"></asp:CompareValidator>
                                                                        <asp:Label ID="lblOvesdfsrtime2" Style="padding-left: 18px" runat="server" Text="Overtime 2:"></asp:Label>
                                                                    </td>
                                                                    <td class="tabletds" style=" border-bottom: 0px; padding-left: 10px">
                                                                        <asp:TextBox runat="server" Width="2px" ClientIDMode="Static" Style="display: none" ID="txtbxmaxovertime2" Text='<%# Eval("maxovt2hrs") %>'></asp:TextBox>
                                                                        <telerik:RadNumericTextBox ID="txtOvertime2" ClientIDMode="Static"
                                                                            ClientEvents-OnValueChanged="onOvertime2Change" MaxLength="4"
                                                                            MaxValue="9" runat="server" Text='<%# Eval("attot2") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFasdfasieldValidator6111" Style="float: left" runat="server"
                                                                            ErrorMessage="req ov2" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtOvertime2"></asp:RequiredFieldValidator>
                                                                        <asp:CompareValidator ID="compare0fieldvfasdfasdalisdssdfdator" runat="server" ErrorMessage="*"
                                                                            ForeColor="Red" Display="Dynamic" Type="Double"
                                                                            ControlToValidate="txtOvertime2" Operator="LessThanEqual" meta:resourcekey="LabelResource50"
                                                                            ControlToCompare="txtbxmaxovertime2"></asp:CompareValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="attot2" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                        SortExpression="attot2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Overtime 2" UniqueName="attot2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblOvertiasdfame2" runat="server" Text='<%# Eval("attot2") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="TotalOverTime" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="TotalOverTime" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Total Overtime" UniqueName="TotalOverTime">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalOverTime" runat="server" Text='<%# Eval("TotalOverTime") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td class="tabletds" style=" border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadNumericTextBox ID="txtTotalOverTime" ClientIDMode="Static" ReadOnly="true" MaxLength="4"
                                                                            runat="server" Text='<%# Eval("TotalOverTime") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredasdfasfdFieldValidator6111" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtTotalOverTime"></asp:RequiredFieldValidator>
                                                                        <asp:Label ID="lblOvertiasdfame2" Style="padding-left: 18px" runat="server" Text="Total Hours:"></asp:Label>
                                                                    </td>
                                                                    <td class="tabletds" style=" border-bottom: 0px; padding-left: 7px">
                                                                        <telerik:RadNumericTextBox ID="txtTotalHours" ClientIDMode="Static" MaxLength="4"
                                                                            ReadOnly="true" runat="server" Text='<%# Eval("TotalHours") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                        <telerik:RadTextBox ID="txtTotalHoursCmp" Style="display: none" ClientIDMode="Static" MaxLength="4"
                                                                            ReadOnly="true" runat="server" Text='24' Width="2px">
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiasdfaredFieldValidator6111" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtTotalHours"></asp:RequiredFieldValidator>
                                                                        <asp:CompareValidator ID="compare0fieldvalisdssdfdator" Type="Double" runat="server" ErrorMessage="*"
                                                                            ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtTotalHours" Operator="LessThanEqual" meta:resourcekey="LabelResource50"
                                                                            ControlToCompare="txtTotalHoursCmp"></asp:CompareValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="TotalHours" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="TotalHours" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Total Hours" UniqueName="TotalHours">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalHours" runat="server" Text='<%# Eval("TotalHours") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="attcmt" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true" SortExpression="attcmt" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Comments" UniqueName="attcmt">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblattcmt" runat="server" Text='<%# Eval("attcmt") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 563px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadTextBox ID="txtattcmt" MaxLength="50" runat="server" Text='<%# Eval("attcmt") %>'>
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px"></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditFiles"
                                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </telerik:GridEditCommandColumn>
                                                </Columns>
                                                <EditFormSettings CaptionFormatString='Edit Attendance detail for Employee : "{0}":' CaptionDataField="empidd">
                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                    <EditColumn ButtonType="ImageButton" />
                                                </EditFormSettings>
                                            </MasterTableView>

                                        </telerik:RadGrid>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" Skin="Default" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>

