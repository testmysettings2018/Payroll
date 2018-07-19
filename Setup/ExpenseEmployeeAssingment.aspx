<%@ Page Title="Expense Employee Assignment" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="ExpenseEmployeeAssingment.aspx.cs" Inherits="ExpenseEmployeeAssingment" %>

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

            function OnddlEmployeeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "empcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmployee4DDL', ''));
                combo.set_text(headerValues);
            }

            function ValidateExpenseDetail(ddlEmployeeId) {
                var str = '';
                if ($('#' + ddlEmployeeId).val() == undefined || $('#' + ddlEmployeeId).val() == "") {
                    str = 'Employee Required.<br/>';
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
                        <telerik:RadGrid ID="gvExpense" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="false"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvExpense_InsertCommand"
                            OnNeedDataSource="gvExpense_NeedDataSource" PageSize="20" OnDeleteCommand="gvExpense_DeleteCommand"
                            OnUpdateCommand="gvExpense_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvExpense_ItemDataBound"
                            OnItemCommand="gvExpense_ItemCommand" OnDetailTableDataBind="gvExpense_DetailTableDataBind"
                            OnItemCreated="gvExpense_ItemCreated" >
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="exptidd,exptcod" 
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>

                                    <telerik:GridTableView runat="server" Name="ExpTypeEmpAssignment" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="empidd" AllowFilteringByColumn="false">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee List</h6>
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
                                            <telerik:GridBoundColumn DataField="empidd" FilterControlAltText="Filter empidd column" AllowFiltering="false"
                                                HeaderText="ID" UniqueName="empidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="empidd" FilterControlWidth="130px" SortExpression="empidd" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter empidd column" HeaderText="ID" UniqueName="empidd">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblempidd" runat="server" Text='<%# Eval("empidd") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter empcod column" HeaderText="Code" UniqueName="empcode">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblempcod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="empfsn" FilterControlWidth="130px" SortExpression="empfsn" AutoPostBackOnFilter="true"
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter empfsn column" HeaderText="Name" UniqueName="empfsn">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblempfsn" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                                ConfirmTextFields="empidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteExpEmpAssignment" ConfirmTextFormatString='Are you sure to delete Expense employee assignment of emp Id:  {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="0px" />
                                            </telerik:GridButtonColumn>

                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="empidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>



                                    <telerik:GridTableView runat="server" Name="ExpSubTypeDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="expsubtidd,exptidd,expsubtcod"  AllowFilteringByColumn="false">
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
                                            <telerik:GridTableView runat="server" Name="ExpEmpAssignmentDetail" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="recidd" AllowFilteringByColumn="false">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee List</h6>
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
                                                    <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter recidd column" AllowFiltering="false"
                                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="empidd" FilterControlWidth="130px" SortExpression="empidd" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter empidd column" HeaderText="ID" UniqueName="empidd">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblempidd" runat="server" Text='<%# Eval("empidd") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter empcod column" HeaderText="Code" UniqueName="empcode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblempcod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="empfsn" FilterControlWidth="130px" SortExpression="empfsn" AutoPostBackOnFilter="true"
                                                        CurrentFilterFunction="Contains" FilterControlAltText="Filter empfsn column" HeaderText="Name" UniqueName="empfsn">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblempfsn" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteExpEmpAssignment" ConfirmTextFormatString='Are you sure to delete Expense employee assignment record # {0}?'>
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

                                            <telerik:GridTemplateColumn DataField="expsubtcod" FilterControlWidth="130px" SortExpression="expsubtcod" AutoPostBackOnFilter="true" 
                                                CurrentFilterFunction="Contains" FilterControlAltText="Filter expsubtcod column" HeaderText="Expense Sub Type" UniqueName="expsubtcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblexpsubtcod" runat="server" Text='<%# Eval("expsubtcod") %>'></asp:Label>
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            
                                            <telerik:GridTemplateColumn DataField="empcod" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                                SortExpression="empcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Employee" UniqueName="empcod">
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                                <span class="combo180">
                                                                    <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                                                        Width="180px" DropDownWidth="180px"
                                                                        EmptyMessage="Please select...">
                                                                        <ItemTemplate>
                                                                            <div style="overflow: auto; max-height: 200px;">
                                                                                <telerik:RadGrid ID="rGrdEmployee4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource" AllowFilteringByColumn="false"
                                                                                    Width="180px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                            <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                            <telerik:GridBoundColumn DataField="recidd" Visible="true" FilterControlAltText="Filter column1 column"
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
                                                                                        <ClientEvents OnRowDeselected="OnddlEmployeeRowSelected" OnRowSelected="OnddlEmployeeRowSelected"></ClientEvents>
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
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>

                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditExpenseSubType"
                                                ButtonType="ImageButton" ItemStyle-Width="56px" EditFormHeaderTextFormat="{0}:">
                                                <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                            </telerik:GridEditCommandColumn>
                                            
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                                ConfirmTextFields="expsubtidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteExpenseSubType" ConfirmTextFormatString='Are you sure to delete Expense employee assignment record # {0}?'>
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
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Expense Type List</h6>
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
                                    <telerik:GridBoundColumn DataField="exptidd" SortExpression="exptidd" FilterControlAltText="Filter exptidd column"
                                        HeaderText="ID" UniqueName="exptidd" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="exptcod" FilterControlWidth="130px" SortExpression="exptcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter exptcod column"
                                        HeaderText="Expense Type" UniqueName="exptcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblexptcod" runat="server" Text='<%# Eval("exptcod") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridTemplateColumn DataField="empcod" Visible="false" FilterControlWidth="80px" AutoPostBackOnFilter="true"
                                        SortExpression="empcod" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Employee" UniqueName="empcod">
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td class="tabletds" style="border-bottom: 0px; padding-left: 0px">
                                                        <span class="combo180">
                                                            <telerik:RadComboBox ID="ddlEmployee" runat="server"
                                                                Width="180px" DropDownWidth="180px"
                                                                EmptyMessage="Please select...">
                                                                <ItemTemplate>
                                                                    <div style="overflow: auto; max-height: 200px;">
                                                                        <telerik:RadGrid ID="rGrdEmployee4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdEmployee4DDL_NeedDataSource" AllowFilteringByColumn="false"
                                                                            Width="180px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                    <telerik:GridClientSelectColumn></telerik:GridClientSelectColumn>

                                                                                    <telerik:GridBoundColumn DataField="recidd" Visible="true" FilterControlAltText="Filter column1 column"
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
                                                                                <ClientEvents OnRowDeselected="OnddlEmployeeRowSelected" OnRowSelected="OnddlEmployeeRowSelected"></ClientEvents>
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
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditExpenseSubType"
                                        ButtonType="ImageButton" ItemStyle-Width="56px" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" CssClass="displayBlock" />
                                    </telerik:GridEditCommandColumn>

                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this record?"
                                        ConfirmTextFields="exptidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteExpenseSubType" ConfirmTextFormatString='Are you sure to delete Expense employee assignment record # {0}'>
                                        <ItemStyle HorizontalAlign="Center" Width="0px" />
                                    </telerik:GridButtonColumn>

                                </Columns>
                                <EditFormSettings >
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




