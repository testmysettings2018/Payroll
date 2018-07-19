<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="CalenderSetup.aspx.cs" Inherits="Payroll_CalenderSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function OnSalaryOptionRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdSalaryOption4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);

                if (cellValues == "Days Salary") {
                    $('#txtBxgrtdys').attr('readonly', false);
                    $('#txtgrtmns').attr('readonly', true);

                }

                if (cellValues == "Monthly Salary") {

                    $('#txtBxgrtdys').attr('readonly', true);
                    $('#txtgrtmns').attr('readonly', false);
                }
            }
            function OnBasedOnRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdBasedOn4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnDayTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("daycod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDayType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnDaysRoundingRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDaysRounding4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnCalenderExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnCalenderShiftDetailExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderShiftDetailCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderShiftDetailPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderShiftDetailPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnCalenderShiftDetailRefresh") >= 0 ||

                    args.get_eventTarget().indexOf("btnDepartmentExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDepartmentCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDepartmentPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDepartmentPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnDepartmentRefresh") >= 0 ||
                    args.get_eventTarget().indexOf("btnSectionExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnSectionCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnSectionPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnSectionPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnSectionRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }
            function ValidateCalender(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Calender Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function OnPayCodeRowSelected(sender, args) {
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
                combo.set_text(headerValues);
            }
            function ValidateHolidays(dtpExpectedDateId, ddlDayTypeId, txtDescriptionId) {
                var str = '';
                if ($('#' + dtpExpectedDateId).val() == undefined || $('#' + dtpExpectedDateId).val() == "") {
                    str = 'Expected Date Required.<br/>';
                }
                if ($('#' + ddlDayTypeId).val() == undefined || $('#' + ddlDayTypeId).val() == "") {
                    str += 'Holiday Type Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function getHour24(timeString) {
                time = null;
                var matches = timeString.match(/^(\d{1,2}):00 (\w{2})/);
                if (matches != null && matches.length == 3) {
                    time = parseInt(matches[1]);
                    if (matches[2] == 'PM') {
                        time += 12;
                    }
                }
                return time;
            }
            function ValidateShiftDetail(ddlDayTypeId, tpkrTimeInId, tpkrTimeOutId, tpkrLateArrivalId, tpkrLeaveEarlyId,
                tpkrOvertimeStartId, tpkrNightShiftStartId) {
                var str = '';
                var needTimeCamparison = true;
                var needEarlyCamparison = true;
                var needOvertimeCamparison = true;
                if ($('#' + ddlDayTypeId).val() == undefined || $('#' + ddlDayTypeId).val() == "") {
                    str = 'Day Type Required.<br/>';
                }
                if ($('#' + tpkrTimeInId).val() == undefined || $('#' + tpkrTimeInId).val() == "") {
                    str += 'Time In Required.<br/>';
                    needTimeCamparison = false;
                }
                if ($('#' + tpkrTimeOutId).val() == undefined || $('#' + tpkrTimeOutId).val() == "") {
                    str += 'Time Out Required.<br/>';
                    needTimeCamparison = false;
                    needOvertimeCamparison = false;
                }
                if (needTimeCamparison) {
                    if ( $find(tpkrTimeInId).get_selectedDate() >= $find(tpkrTimeOutId).get_selectedDate() ) {
                        str += 'Greater Time Out Value Required.<br/>';
                    }
                }
                if ($('#' + tpkrLateArrivalId).val() == undefined || $('#' + tpkrLateArrivalId).val() == "") {
                    str += 'Late Arrival Time Required.<br/>';
                    needEarlyCamparison = false;
                }
                if ($('#' + tpkrLeaveEarlyId).val() == undefined || $('#' + tpkrLeaveEarlyId).val() == "") {
                    str += 'Leave Early Time Required.<br/>';
                    needEarlyCamparison = false;
                }
                if (needEarlyCamparison) {
                    if ($find(tpkrLateArrivalId).get_selectedDate() >= $find(tpkrLeaveEarlyId).get_selectedDate()) {
                        str += 'Greater Leave Early Value Required.<br/>';
                    }
                }
                if ($('#' + tpkrOvertimeStartId).val() == undefined || $('#' + tpkrOvertimeStartId).val() == "") {
                    str += 'OT1 Start Time Required.<br/>';
                    needOvertimeCamparison = false;
                }
                if (needOvertimeCamparison) {
                    if ($find(tpkrTimeOutId).get_selectedDate() >= $find(tpkrOvertimeStartId).get_selectedDate()) {
                        str += 'Greater Overt Time Value Required.<br/>';
                    }
                }
                if ($('#' + tpkrNightShiftStartId).val() == undefined || $('#' + tpkrNightShiftStartId).val() == "") {
                    str += 'OT2 Start Time Required.<br/>';
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
    <div class="widget">

        <fieldset>
            <div class="widget">
                <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                    <div class="formRight">
                        <telerik:RadGrid ID="gvCalender" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvCalender_InsertCommand"
                            OnNeedDataSource="gvCalender_NeedDataSource" PageSize="20" OnDeleteCommand="gvCalender_DeleteCommand"
                            OnUpdateCommand="gvCalender_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvCalender_ItemDataBound"
                            OnItemCommand="gvCalender_ItemCommand" OnDetailTableDataBind="gvCalender_DetailTableDataBind" OnItemCreated="gvCalender_ItemCreated" >
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
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace" >
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="Holidays" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="recidd" AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
<%--                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Holidays Detail</h6>
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
                                                                    <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                    <asp:Label runat="server" Text="Holiday Details"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnCalenderExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnCalenderCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnCalenderPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnCalenderPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnCalenderRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="calext" SortExpression="calext" FilterControlWidth="130px" AllowFiltering="true" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Expected Date" UniqueName="TemplateColumn10">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExpectedDate" runat="server" Text='<%# Eval("calext","{0:d}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom:0px">
                                                                <telerik:RadDatePicker ID="dtpExpectedDate" runat="server" DbSelectedDate='<%# Bind("calext") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                                </telerik:RadDatePicker>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="dtpExpectedDate"></asp:RequiredFieldValidator>
                                                            </td>
                                                          
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="calact" SortExpression="calact" FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Actual Date" UniqueName="TemplateColumn17">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActualDate" runat="server" Text='<%# Eval("calact","{0:d}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom:0px">
                                                                <telerik:RadDatePicker ID="dtpActualdate" runat="server" DbSelectedDate='<%# Bind("calact") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                    <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                    <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                                </telerik:RadDatePicker>
                                                            </td>
                                                           
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn  DataField="calholcod" SortExpression="calholcod" FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true"   FilterControlAltText="Filter TemplateColumn72 column"
                                                HeaderText="Holiday Type" UniqueName="TemplateColumn3175">
                                                 <ItemTemplate>
                                                    <asp:Label ID="lblHolidayType" runat="server" Text='<%# Eval("calholcod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom:0px">
                                                                <asp:HiddenField ID="hfdayId" runat="server" Value='<%# Eval("calholidd") %>' />
                                                                <asp:HiddenField ID="hfdaycod" runat="server" Value='<%# Eval("calholcod") %>' />
                                                                <telerik:RadComboBox ID="ddlDayType" runat="server"
                                                                    Width="260px" Height="200px" DropDownWidth="410px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <telerik:RadAjaxPanel ID="RadAjaxPanelDayType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelDayType" Height="200px">
                                                                            <telerik:RadGrid ID="rGrdDayType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDayType4DDL_NeedDataSource"
                                                                                Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>

                                                                                <MasterTableView DataKeyNames="recidd,daycod,dayds1" ClientDataKeyNames="recidd,daycod,dayds1">
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
                                                                                        <telerik:GridBoundColumn DataField="daycod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="daycod">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="dayds1" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Description" UniqueName="dayds1">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowClick="OnDayTypeRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                        </telerik:RadAjaxPanel>
                                                                        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDayType" runat="server">
                                                                        </telerik:RadAjaxLoadingPanel>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlDayType"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="caldsc" SortExpression="caldsc" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description" UniqueName="TemplateColumn2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("caldsc") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("caldsc") %>' MaxLength="200">
                                                                </telerik:RadTextBox></td>
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditHolidays">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Holiday Detail record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteHolidays" ConfirmTextFormatString='Are you sure to delete Holiday Detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
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
                                    <telerik:GridTableView runat="server" Name="Shift" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="ValueSetID">
                                        <CommandItemTemplate>
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
                                                                    <%--                                                                    <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
                                                                <asp:Label ID="Sh" runat="server" Text="Shift Details"></asp:Label>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnCalenderExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnCalenderCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnCalenderPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnCalenderPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnCalenderRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridTableView runat="server" Name="ShiftDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="recidd">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Shift Detail</h6>
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
                                                                            <asp:Button ID="btnCalenderShiftDetailAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Button runat="server" ID="btnCalenderShiftDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnCalenderShiftDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnCalenderShiftDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <asp:Button runat="server" ID="btnCalenderShiftDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnCalenderShiftDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                                                                                                 HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="Day Type" DataField="caltds" SortExpression="caltds" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" UniqueName="TemplateColumn175">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcaltds" runat="server" Text='<%# Eval("caltds") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">
                                                                        <asp:HiddenField ID="hfdayId" runat="server" Value='<%# Eval("caldid") %>' />
                                                                        <asp:HiddenField ID="hfdaycod" runat="server" Value='<%# Eval("caltds") %>' />
                                                                        <telerik:RadComboBox ID="ddlDayType" runat="server"
                                                                            Width="260px" Height="200px" DropDownWidth="410px"
                                                                            EmptyMessage="Please select...">
                                                                            <ItemTemplate>
                                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelDayType" runat="server" Width="410px"
                                                                                    LoadingPanelID="RadAjaxLoadingPanelDayType" Height="200px">
                                                                                    <telerik:RadGrid ID="rGrdDayType4DDL" runat="server" AllowSorting="True"
                                                                                        AutoGenerateColumns="False"
                                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDayType4DDL_NeedDataSource"
                                                                                        Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                                        <ClientSettings>
                                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                        </ClientSettings>

                                                                                        <MasterTableView DataKeyNames="recidd,daycod,dayds1"
                                                                                            ClientDataKeyNames="recidd,daycod,dayds1">
                                                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                                                                                            <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator 

column">
                                                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                                                            </RowIndicatorColumn>
                                                                                            <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn 

column">
                                                                                                <HeaderStyle Width="20px"></HeaderStyle>
                                                                                            </ExpandCollapseColumn>
                                                                                            <Columns>

                                                                                                <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter 

column1 column"
                                                                                                    HeaderText="ID" UniqueName="recidd">
                                                                                                </telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn DataField="daycod" FilterControlAltText="Filter 

column2 column"
                                                                                                    HeaderText="Code" UniqueName="daycod">
                                                                                                </telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn DataField="dayds1" FilterControlAltText="Filter 

column3 column"
                                                                                                    HeaderText="Description" UniqueName="dayds1">
                                                                                                </telerik:GridBoundColumn>
                                                                                            </Columns>
                                                                                            <EditFormSettings>
                                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                </EditColumn>
                                                                                            </EditFormSettings>
                                                                                        </MasterTableView>
                                                                                        <ClientSettings>
                                                                                            <ClientEvents OnRowClick="OnDayTypeRowClicked"></ClientEvents>
                                                                                        </ClientSettings>
                                                                                        <FilterMenu EnableImageSprites="False">
                                                                                        </FilterMenu>
                                                                                    </telerik:RadGrid>
                                                                                </telerik:RadAjaxPanel>
                                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDayType" runat="server">
                                                                                </telerik:RadAjaxLoadingPanel>
                                                                            </ItemTemplate>
                                                                            <Items>
                                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                            </Items>
                                                                        </telerik:RadComboBox>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlDayType"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                    <td></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="caltmi" SortExpression="caltmi" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="Time In" UniqueName="TemplateColumn17752">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcaltmi" runat="server" Text='<%# Eval("caltmi") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrTimeIn" DbSelectedDate='<%# Eval("caltmi") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator61111" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrTimeIn"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="caltmo" SortExpression="caltmo" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="Time Out" UniqueName="TemplateColumn177352">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcaltmo" runat="server" Text='<%# Eval("caltmo") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrTimeOut" DbSelectedDate='<%# Eval("caltmo") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator611131" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrTimeOut"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="callta" SortExpression="callta" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="Late Arrival" UniqueName="TemplateColumn17723352">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcallta" runat="server" Text='<%# Eval("callta") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrLateArrival" DbSelectedDate='<%# Eval("callta") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6131131" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrLateArrival"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="callve" SortExpression="callve" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="Leave Early" UniqueName="TemplateColumn177233352">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcallve" runat="server" Text='<%# Eval("callve") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrLeaveEarly" DbSelectedDate='<%# Eval("callve") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator61311431" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrLeaveEarly"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn Visible="false" DataField="calovs" SortExpression="calovs" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="OT1 Start" UniqueName="TemplateColumn1737233352">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcalovs" runat="server" Text='<%# Eval("calovs") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrOvertimeStart" DbSelectedDate='<%# Eval("calovs") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator613114331" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrOvertimeStart"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn Visible="false" DataField="calnss" SortExpression="calnss" FilterControlWidth="100px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn7 column"
                                                        HeaderText="OT2 Start" UniqueName="TemplateColumn17372339352">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcalnss" runat="server" Text='<%# Eval("calnss") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 280px">

                                                                        <telerik:RadTimePicker ID="tpkrNightShiftStart" DbSelectedDate='<%# Eval("calnss") %>' Height="28px" TimeView-Interval="15" Width="100%" runat="server">
                                                                        </telerik:RadTimePicker>


                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator61310143331" Style="float: left" runat="server"
                                                                            ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="tpkrNightShiftStart"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditShiftDetails">
                                                        <ItemStyle HorizontalAlign="Center" Width="43px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Shift Detail record?"
                                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteShiftDetails" ConfirmTextFormatString='Are you sure to delete Shift Detail record # {0}?'>
                                                        <ItemStyle HorizontalAlign="Center" Width="43px" />
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
                                            <telerik:GridBoundColumn DataField="ValueSetID" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="calext" SortExpression="calext" FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Text" UniqueName="TemplateColumn10">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExpectedDate" runat="server" Text='<%# Bind("Text") %>'></asp:Label>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="calact" SortExpression="calact" FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Value" UniqueName="TemplateColumn17">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActualDate" runat="server" Text='<%# Bind("Value") %>'></asp:Label>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <%--<telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditHolidays">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Holiday Detail record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteHolidays" ConfirmTextFormatString='Are you sure to delete Holiday Detail record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridButtonColumn>--%>
                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="ValueSetID" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>

                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Calender Setup</h6>
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
                                                            <asp:Button ID="btnDepartmentAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnDepartmentExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnDepartmentCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnDepartmentPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                            <asp:Button runat="server" ID="btnDepartmentPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnDepartmentRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="calcod" FilterControlWidth="130px" SortExpression="calcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Calender Code" UniqueName="calcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcalcode" runat="server" Text='<%# Eval("calcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 280px">
                                                        <telerik:RadTextBox ID="txtcalcode" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("calcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtcalcode"></asp:RequiredFieldValidator>


                                                    </td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>



                                    <telerik:GridTemplateColumn DataField="caldsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="caldsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="caldsc">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("caldsc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 280px">
                                                        <telerik:RadTextBox ID="txtcaldsc" MaxLength="200" runat="server" Text='<%# Eval("caldsc") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtcaldsc"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="attact" Visible="false" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="attact" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Is Active" UniqueName="attact">

                                        <EditItemTemplate>

                                            <asp:CheckBox runat="server" ID="chkbxActive" Text="" Checked='<%# CheckBoxValue( Eval("calact")) %>' />

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditCalender"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Calender record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteCalender" ConfirmTextFormatString='Are you sure to delete Calender record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Calender record # "{0}":' CaptionDataField="recidd">
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
    </div>
</asp:Content>




