<%@ Page Title="Employee Expense Assignment" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="EmployeeExpenseAssingment.aspx.cs" Inherits="EmployeeExpenseAssingment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
   
    <style>
        .displayBlock
        {
        }

        .RadComboBox .rcbInputCellLeft
        {
            width: 118px !important;
            overflow: hidden;
        }

            .RadComboBox .rcbInputCellLeft inputs
            {
                width: 140px !important;
            }

        .RadComboBoxDropDown
        {
            min-width: 150px !important;
        }

        .rgEditForm > table tr td:first-child
        {
            min-width: 85px;
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


                       args.get_eventTarget().indexOf("btnOvertimeDetailExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailPdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailPrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnOvertimeDetailRefresh") >= 0 ||

                       args.get_eventTarget().indexOf("btnExpenseDetailExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnExpenseDetailCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnExpenseDetailPdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnExpenseDetailPrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnExpenseDetailRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }

            function OnddlExpenseTypeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "exptcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpenseType4DDL', ''));
                combo.set_text(headerValues);
                
            }

            function btnclick() {
                $('#btnHidden').click();
            }

            function OnddlExpenseSubTypeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "expsubtcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdExpenseSubType4DDL', ''));
                combo.set_text(headerValues);
            }

            function ValidateEmployeeMaster(ddlExpenseTypeId) {
                var str = '';
                if ($('#' + ddlExpenseTypeId).val() == undefined || $('#' + ddlExpenseTypeId).val() == "") {
                    str = 'Expense type required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateExpenseDetail(ddlExpenseSubTypeId) {
                var str = '';
                if ($('#' + ddlExpenseSubTypeId).val() == undefined || $('#' + ddlExpenseSubTypeId).val() == "") {
                    str = 'Expense Sub Type Required.<br/>';
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
                        <telerik:RadGrid ID="gvEmployee" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvEmployee_InsertCommand"
                            OnNeedDataSource="gvEmployee_NeedDataSource" PageSize="20" OnDeleteCommand="gvEmployee_DeleteCommand"
                            OnUpdateCommand="gvEmployee_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvEmployee_ItemDataBound"
                            OnItemCommand="gvEmployee_ItemCommand" OnDetailTableDataBind="gvEmployee_DetailTableDataBind"
                            OnItemCreated="gvEmployee_ItemCreated" OnInfrastructureExporting="gvEmployee_InfrastructureExporting">
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
                                <%--<Excel DefaultCellAlignment="Center" />--%>
                                <Csv ColumnDelimiter="Tab" RowDelimiter="NewLine" FileExtension="TXT" EncloseDataWithQuotes="false" />
                                <Pdf PaperSize="A4">
                                </Pdf>
                            </ExportSettings>
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="recidd,empcod,empfsn" 
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="EmpExpTypeDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="exptidd,empidd"  AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense Type List</h6>
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
                                                                    <asp:Button ID="btnOvertimeDetailAdd" visible="false" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
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
                                            <telerik:GridTableView runat="server" Name="EmpExpSubTypeDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="recidd,expsubtidd" AllowFilteringByColumn="false">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense Sub Type List</h6>
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
                                                                            <asp:Button ID="btnExpenseDetailAdd" Visible="false" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Button runat="server" ID="btnExpenseDetailExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnExpenseDetailCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnExpenseDetailPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <asp:Button runat="server" ID="btnExpenseDetailPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnExpenseDetailRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    <telerik:GridBoundColumn DataField="expsubtidd" FilterControlAltText="Filter expsubtidd column" AllowFiltering="false"
                                                        HeaderText="ID" UniqueName="expsubtidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="expsubtidd" FilterControlWidth="130px" SortExpression="expsubtidd" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubtidd column" HeaderText="ID" UniqueName="expsubtidd">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblexpsubtidd" runat="server" Text='<%# Eval("expsubtidd") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="expsubtcod" FilterControlWidth="130px" SortExpression="expsubtcod" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubtcod column" HeaderText="Expense Sub Type" UniqueName="expsubtcod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblexpsubtcod" runat="server" Text='<%# Eval("expsubtcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="expsubttitle" FilterControlWidth="130px" SortExpression="expsubttitle" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubttitle column" HeaderText="Description" UniqueName="expsubttitle">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblexpsubttitle" runat="server" Text='<%# Eval("expsubttitle") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                                        ConfirmTextFields="expsubtidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteExpenseSubType" ConfirmTextFormatString='Are you sure to delete employee expense sub type assignment record # {0}?'>
                                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                                    </telerik:GridButtonColumn>

                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="expsubtidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>

                                        </DetailTables>
                                        <Columns>
                                            <telerik:GridTemplateColumn DataField="exptidd" FilterControlWidth="130px" SortExpression="exptidd" AutoPostBackOnFilter="true" 
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter exptidd column" HeaderText="ID" UniqueName="exptidd">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblexptidd" runat="server" Text='<%# Eval("exptidd") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridTemplateColumn DataField="exptcod" FilterControlWidth="130px" SortExpression="exptcod" AutoPostBackOnFilter="true" 
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter exptcod column" HeaderText="Expense Type" UniqueName="exptcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblexptcod" runat="server" Text='<%# Eval("exptcod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="expttitle" FilterControlWidth="130px" SortExpression="expttitle" AutoPostBackOnFilter="true" 
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter expttitle column" HeaderText="Description" UniqueName="expttitle">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblexpttitle" runat="server" Text='<%# Eval("expttitle") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridTemplateColumn DataField="ExpSubType" visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                SortExpression="ExpSubType" CurrentFilterFunction="Contains" FilterControlAltText="Filter ExpSubType column"
                                                HeaderText="Expense Sub Type" UniqueName="ExpSubType">
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                <span class="combo180">
                                                                    <telerik:RadComboBox ID="ddlExpenseSubType" runat="server"
                                                                        Width="180px" DropDownWidth="180px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <div style="overflow: auto; max-height: 200px;">
                                                                                <telerik:RadGrid ID="rGrdExpenseSubType4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpenseSubType4DDL_NeedDataSource" AllowFilteringByColumn="false"
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
                                                                                            <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                            <telerik:GridBoundColumn DataField="expsubtidd" Visible="true" FilterControlAltText="Filter column1 column"
                                                                                                HeaderText="ID" UniqueName="expsubtidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="expsubtcod" FilterControlAltText="Filter column2 column"
                                                                                                HeaderText="Code" UniqueName="expsubtcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                            </telerik:GridBoundColumn>
                                                                                            <telerik:GridBoundColumn DataField="expsubttitle" FilterControlAltText="filter column3 column"
                                                                                                HeaderText="Description" UniqueName="expsubttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                            </telerik:GridBoundColumn>
                                                                                        </Columns>
                                                                                        <EditFormSettings>
                                                                                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                            </EditColumn>
                                                                                        </EditFormSettings>
                                                                                    </MasterTableView>
                                                                                    <ClientSettings>
                                                                                        <ClientEvents OnRowDeselected="OnddlExpenseSubTypeRowSelected" OnRowSelected="OnddlExpenseSubTypeRowSelected"></ClientEvents>
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
                                                                <asp:RequiredFieldValidator ID="rfvddlExpenseSubType" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlExpenseSubType"></asp:RequiredFieldValidator>
                                                            </td>

                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditExpenseType"
                                                ButtonType="ImageButton" ItemStyle-Width="56px" EditFormHeaderTextFormat="{0}:">
                                                <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                            </telerik:GridEditCommandColumn>
                                            
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                                ConfirmTextFields="exptidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteExpenseType" ConfirmTextFormatString='Are you sure to delete employee expense assignment record # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>

                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="exptidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>

                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee List</h6>
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
                                                            <asp:Button ID="Button1" runat="server" visible="false" CssClass="rgAdd" CommandName="InitInsert" AlterovteText="Add" ToolTip="Add" />
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnOvertimeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlterovteText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnOvertimeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlterovteText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnOvertimePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlterovteText="Pdf" ToolTip="Pdf" />

                                                            <span>
                                                                <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="150px" DropDownWidth="152px"></telerik:RadComboBox>
                                                            </span>
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
                                    <telerik:GridBoundColumn DataField="recidd" SortExpression="recidd" FilterControlAltText="Filter recidd column"
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter empcod column"
                                        HeaderText="Code" UniqueName="empcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempcod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <asp:Label ID="lblempcod1" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                                    </td>                                           
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="empfsn" FilterControlWidth="130px" SortExpression="empfsn" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter prjds1 column"
                                        HeaderText="Name" UniqueName="empfsn">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempfsn" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <asp:Label ID="lblempfsn1" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                                    </td>                                           
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="ExpType" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                        SortExpression="ExpType" CurrentFilterFunction="Contains" FilterControlAltText="Filter ExpType column"
                                        HeaderText="Expense Type" UniqueName="ExpType">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                        <span class="combo180">
                                                            <telerik:RadComboBox ID="ddlExpenseType" runat="server"
                                                                Width="180px" DropDownWidth="180px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdExpenseType4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdExpenseType4DDL_NeedDataSource" AllowFilteringByColumn="false"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                            <GroupingSettings CaseSensitive="false" />
                                                                            <ClientSettings>
                                                                                <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                            </ClientSettings>
                                                                            <MasterTableView DataKeyNames="exptidd,exptcod,expttitle" ClientDataKeyNames="exptidd,exptcod,expttitle">
                                                                                <RowIndicatorColumn Visible="True" FilterControlAltText="Filter RowIndicator column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </RowIndicatorColumn>
                                                                                <ExpandCollapseColumn Visible="True" FilterControlAltText="Filter ExpandColumn column">
                                                                                    <HeaderStyle Width="2px"></HeaderStyle>
                                                                                </ExpandCollapseColumn>
                                                                                <Columns>
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="exptidd" Visible="true" FilterControlAltText="Filter column1 column"
                                                                                        HeaderText="ID" UniqueName="exptidd" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="exptcod" FilterControlAltText="Filter column2 column"
                                                                                        HeaderText="Code" UniqueName="exptcod" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                    <telerik:GridBoundColumn DataField="expttitle" FilterControlAltText="filter column3 column"
                                                                                        HeaderText="Description" UniqueName="expttitle" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true">
                                                                                    </telerik:GridBoundColumn>
                                                                                </Columns>
                                                                                <EditFormSettings>
                                                                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                    </EditColumn>
                                                                                </EditFormSettings>
                                                                            </MasterTableView>
                                                                            <ClientSettings>
                                                                                <ClientEvents OnRowDeselected="OnddlExpenseTypeRowSelected" OnRowSelected="OnddlExpenseTypeRowSelected"></ClientEvents>
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
                                                        <asp:RequiredFieldValidator ID="rfvddlExpenseType" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="ddlExpenseType"></asp:RequiredFieldValidator>
                                                    </td>

                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="defval" Visible="false" FilterControlWidth="130px" SortExpression="defval" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter defval column"
                                        HeaderText="Default Values" UniqueName="defval">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 250px; border-bottom: 0px; padding-left: 0px">
                                                        <asp:CheckBox runat="server" ID="cbDefVal" Text="" Checked="false" />
                                                    </td>                                           
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditEmployee"
                                        ButtonType="ImageButton" ItemStyle-Width="56px"  EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="0px" UniqueName="DeleteEmployee" ConfirmTextFormatString='Are you sure to delete the detail of employee record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit record of Employee Id: "{0}"' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20" IsSticky="true">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>




