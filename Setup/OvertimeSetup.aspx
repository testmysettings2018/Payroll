<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="OvertimeSetup.aspx.cs" Inherits="Payroll_OvertimeSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   
     <style>
         .displayBlock {
         }
        .RadComboBox .rcbInputCellLeft {
            width : 118px !important;   
            overflow:hidden; 
        }
         .RadComboBox .rcbInputCellLeft inputs {
            width : 140px !important;
            }
          .RadComboBoxDropDown{
    min-width:150px !important;
}
    </style>
     <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnOvertimeExcelExport") >= 0 ||
                   args.get_eventTarget().indexOf("LinkOvertimeExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimePrint") >= 0 ||
                       args.get_eventTarget().indexOf("LinkbtnOvertimePrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeRefresh") >= 0 ||
                       args.get_eventTarget().indexOf("LinkOvertimeRefresh") >= 0 ||

                                       args.get_eventTarget().indexOf("btnOvertimeDetailAdd") >= 0 ||
                                           args.get_eventTarget().indexOf("btnOvertimeDetailExcelExport") >= 0 ||
                                           args.get_eventTarget().indexOf("btnOvertimeDetailCsvExport") >= 0 ||
                                          args.get_eventTarget().indexOf("btnOvertimeDetailPdfExport") >= 0 ||
                                           args.get_eventTarget().indexOf("btnOvertimeDetailPrint") >= 0 ||
                     args.get_eventTarget().indexOf("btnOvertimeDetailRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }
            function OnDataEntryStyleRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdDataEntryStyle4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
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
            function ValidateOvertime(txtbxCodeId, txtDescriptionId, ddlBasedOnId, ddlDataEntryStyleId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlBasedOnId).val() == undefined || $('#' + ddlBasedOnId).val() == "") {
                    str += 'Based On Required.<br/>';
                }
                if ($('#' + ddlDataEntryStyleId).val() == undefined || $('#' + ddlDataEntryStyleId).val() == "") {
                    str += 'Data Entry Style Required.<br/>';
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
            function ValidateOvertimeDetail(ddlDayTypeId) {
                var str = '';
                if ($('#' + ddlDayTypeId).val() == undefined || $('#' + ddlDayTypeId).val() == "") {
                    str = 'Day Type Required.<br/>';
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
                        <telerik:RadGrid ID="gvOvertime" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvOvertime_InsertCommand"
                            OnNeedDataSource="gvOvertime_NeedDataSource" PageSize="20" OnDeleteCommand="gvOvertime_DeleteCommand"
                            OnUpdateCommand="gvOvertime_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvOvertime_ItemDataBound"
                            OnItemCommand="gvOvertime_ItemCommand" OnDetailTableDataBind="gvOvertime_DetailTableDataBind"
                            OnItemCreated="gvOvertime_ItemCreated" >
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
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="ovtDetail" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="recidd"  AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Overtime Detail</h6>
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
                                                                    <asp:Button ID="btnOvertimeDetailAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnOvertimeDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnOvertimeDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnOvertimeDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnOvertimeDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnOvertimeDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column" AllowFiltering="false"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="daycod" FilterControlWidth="130px" SortExpression="daycod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Day Type" UniqueName="daycod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldaycod" runat="server" Text='<%# Eval("daycod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="border-bottom:0px">
                                                                <asp:HiddenField ID="hfdayId" runat="server" Value='<%# Eval("dayidd") %>' />
                                                                <asp:HiddenField ID="hfdaycod" runat="server" Value='<%# Eval("daycod") %>' />
                                                                <telerik:RadComboBox ID="ddlDayType" runat="server"
                                                                    Width="155px" Height="200px" DropDownWidth="410px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <telerik:RadAjaxPanel ID="RadAjaxPanelDayType" runat="server" Width="155px" LoadingPanelID="RadAjaxLoadingPanelDayType" Height="200px">
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
                                                                
                                                            </td>
                                                            <td style="border-bottom:0px"><asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlDayType"></asp:RequiredFieldValidator></td>
                                                           
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dayprt" FilterControlWidth="130px" SortExpression="dayprt" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Rate in percentage" UniqueName="dayprt">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldayprt" runat="server" Text='<%# Eval("dayprt") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtdayprt" Width="75" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("dayprt") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                         
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dayrat" FilterControlWidth="130px" SortExpression="dayrat" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Rate in amount" UniqueName="dayrat">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldayrat" runat="server" Text='<%# Eval("dayrat") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtdayrat" Width="75" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("dayrat") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                           
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dy2prt" FilterControlWidth="110px" SortExpression="dy2prt" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Rate2 in percentage" UniqueName="dy2prt">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldy2prt" runat="server" Text='<%# Eval("dy2prt") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtdy2prt" Width="75" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("dy2prt") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                         
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dy2rat" FilterControlWidth="110px" SortExpression="dy2rat" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Rate2 in amount" UniqueName="dy2rat">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldy2rat" runat="server" Text='<%# Eval("dy2rat") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px;border-bottom:0px">

                                                                <telerik:RadNumericTextBox runat="server" ID="txtdy2rat" Width="75" MaxLength="8"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("dy2rat") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                           
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditovtDetail">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Overtime Day Type record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteovtDetail" ConfirmTextFormatString='Are you sure to delete Overtime Day Type record # {0}?'>
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
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Overtime Setup</h6>
                                    </div>
                                    <tr class="rgCommandRow">

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
                                                        <td align="left">
                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlterovteText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnOvertimeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlterovteText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnOvertimeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlterovteText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnOvertimePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlterovteText="Pdf" ToolTip="Pdf" />

                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                            <asp:Button runat="server" ID="btnOvertimePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlterovteText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnOvertimeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlterovteText="Refresh" ToolTip="Refresh" />
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
                                    <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="OvertimeId" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="ovtcod" FilterControlWidth="130px" SortExpression="ovtcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="TemplateColumn0">
                                        <ItemTemplate>
                                            <asp:Label ID="lblovtcod" runat="server" Text='<%# Eval("ovtcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtovtcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("ovtcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtovtcod"></asp:RequiredFieldValidator>
                                                    </td>                                                  
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ovtdsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ovtdsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="ovtdsc">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("ovtdsc") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtovtdsc" MaxLength="200" runat="server" Text='<%# Eval("ovtdsc") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtovtdsc"></asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="ovtflttext" SortExpression="ovtflttext"  FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Based On" UniqueName="TemplateColumn0253">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 200px; border-bottom:0px">
                                                        <asp:HiddenField ID="hfBasedOndllID" runat="server" Value='<%# Eval("ovtbao") %>' />
                                                        <asp:HiddenField ID="hfBasedOndllText" runat="server" Value='<%# Eval("ovtbaotext") %>' />
                                                        <telerik:RadComboBox ID="ddlBasedOn" runat="server"
                                                            Width="155px" Height="200px" DropDownWidth="155px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelBasedOn" runat="server" Width="155px" LoadingPanelID="RadAjaxLoadingPanelBasedOn" Height="200px">
                                                                    <telerik:RadGrid ID="rGrdBasedOn4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBasedOn4DDL_NeedDataSource"
                                                                        Width="155px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                                        </ClientSettings>
                                                                        <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                                                                                    HeaderText="Description" UniqueName="column3">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                            <EditFormSettings>
                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                </EditColumn>
                                                                            </EditFormSettings>
                                                                        </MasterTableView>
                                                                        <ClientSettings>
                                                                            <ClientEvents OnRowClick="OnBasedOnRowClicked"></ClientEvents>
                                                                        </ClientSettings>
                                                                        <FilterMenu EnableImageSprites="False">
                                                                        </FilterMenu>
                                                                    </telerik:RadGrid>
                                                                </telerik:RadAjaxPanel>
                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBasedOn" runat="server">
                                                                </telerik:RadAjaxLoadingPanel>
                                                            </ItemTemplate>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        </td><td style="border-bottom:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator212242" runat="server" ErrorMessage="*" ForeColor="Red"
                                                            ControlToValidate="ddlBasedOn"></asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ovtdfttext" SortExpression="ovtdfttext"  FilterControlWidth="130px" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Data Entry Style" UniqueName="TemplateColumn025453">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 200px;border-bottom:0px">
                                                        <asp:HiddenField ID="hfDataEntryStyledllID" runat="server" Value='<%# Eval("ovtdae") %>' />
                                                        <asp:HiddenField ID="hfDataEntryStyledllText" runat="server" Value='<%# Eval("ovtdaetext") %>' />
                                                        <telerik:RadComboBox ID="ddlDataEntryStyle" runat="server"
                                                            Width="155px" Height="200px" DropDownWidth="155px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelDataEntryStyle" runat="server" Width="155px" LoadingPanelID="RadAjaxLoadingPanelDataEntryStyle" Height="200px">
                                                                    <telerik:RadGrid ID="rGrdDataEntryStyle4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdDataEntryStyle4DDL_NeedDataSource"
                                                                        Width="155px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true"></Selecting>
                                                                        </ClientSettings>
                                                                        <MasterTableView DataKeyNames="ValueSetID,Text,Value" ClientDataKeyNames="ValueSetID,Text,Value">
                                                                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
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
                                                                            <ClientEvents OnRowClick="OnDataEntryStyleRowClicked"></ClientEvents>
                                                                        </ClientSettings>
                                                                        <FilterMenu EnableImageSprites="False">
                                                                        </FilterMenu>
                                                                    </telerik:RadGrid>
                                                                </telerik:RadAjaxPanel>
                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelDataEntryStyle" runat="server">
                                                                </telerik:RadAjaxLoadingPanel>
                                                            </ItemTemplate>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                            </Items>
                                                        </telerik:RadComboBox>
                                                        </td><td style="border-bottom:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                            ControlToValidate="ddlDataEntryStyle"></asp:RequiredFieldValidator>
                                                    </td>
                                                   
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="paycod" SortExpression="paycod" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Pay Codes" UniqueName="TemplateColumn001">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 200px; border-bottom:0px">
                                                        <asp:HiddenField ID="hfOvertimeId" runat="server" Value='<%# Eval("recidd") %>' />
                                                        <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                            Width="155px" Height="200px" DropDownWidth="410px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelPayCode" runat="server" Width="155px" LoadingPanelID="RadAjaxLoadingPanelPayCode" Height="200px">
                                                                    <telerik:RadGrid ID="rGrdPayCode4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCode4DDL_NeedDataSource"
                                                                        Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        </ClientSettings>

                                                                        <MasterTableView DataKeyNames="recidd,paycod,payds1" ClientDataKeyNames="recidd,paycod,payds1">
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
                                                                            <ClientEvents OnRowDeselected="OnPayCodeRowSelected" OnRowSelected="OnPayCodeRowSelected"></ClientEvents>
                                                                        </ClientSettings>
                                                                        <FilterMenu EnableImageSprites="False">
                                                                        </FilterMenu>
                                                                    </telerik:RadGrid>
                                                                </telerik:RadAjaxPanel>
                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCode" runat="server">
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

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditOvertime"
                                        ButtonType="ImageButton" ItemStyle-Width="45px"  EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Overtime record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="0px" UniqueName="DeleteOvertime" ConfirmTextFormatString='Are you sure to delete Overtime record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Overtime record # "{0}":' CaptionDataField="recidd">
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




