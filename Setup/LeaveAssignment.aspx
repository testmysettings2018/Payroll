<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="LeaveAssignment.aspx.cs" Inherits="Payroll_LeaveAssignment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style type="text/css">
        @media only screen and (min-width: 0px) and (max-width: 600px) {
            .rgEditForm > table tr td:first-child {min-width: 75px !important;}
            .formRight label {margin-right: 0px !important;}
            /*.RadAjaxPanel {overflow:scroll;}*/
        }
    </style>
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        
        <script type="text/javascript">
            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }

            function OnLeaveTypeRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "levtypcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveType4DDL', ''));
                combo.set_text(headerValues);
            }

            function OnLeaveRowSelected(sender, args) {
                var grid = $find(sender.ClientID);
                var MasterTable = grid.get_masterTableView();
                var selectedRows = MasterTable.get_selectedItems();
                var headerValues = '';
                for (var i = 0; i < selectedRows.length; i++) {
                    var row = selectedRows[i];
                    var cell = MasterTable.getCellByColumnUniqueName(row, "levcod")
                    if (headerValues != '')
                        headerValues = headerValues + ',';
                    headerValues = headerValues + cell.textContent;
                }
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeave4DDL', ''));
                combo.set_text(headerValues);
            }

            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnEmployeeExcelExport") >= 0 ||
                   args.get_eventTarget().indexOf("LinkEmployeeExcelExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkEmployeeCsvExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("LinkEmployeePdfExport") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeePrint") >= 0 ||
                       args.get_eventTarget().indexOf("LinkbtnEmployeePrint") >= 0 ||
                       args.get_eventTarget().indexOf("btnEmployeeRefresh") >= 0 ||
                       args.get_eventTarget().indexOf("LinkEmployeeRefresh") >= 0 ||

                    // args.get_eventTarget().indexOf("btnAdd") >= 0 ||
                                           args.get_eventTarget().indexOf("btnExportExcel") >= 0 ||
                                           args.get_eventTarget().indexOf("btnExportCsv") >= 0 ||
                                          args.get_eventTarget().indexOf("btnExportPdf") >= 0 ||
                                           args.get_eventTarget().indexOf("btnPrint") >= 0 ||
                     args.get_eventTarget().indexOf("btnRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }

            function OnEmpLeavesTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdEmpLeavesType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateEmpLeaveTypes(ddlLeaveTypeId) {
                var str = '';
                if ($('#' + ddlLeaveTypeId).val() == undefined || $('#' + ddlLeaveTypeId).val() == "") {
                    str = 'Leave Type Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateEmpLeaves(ddlLeaveId) {
                var str = '';
                if ($('#' + ddlLeaveId).val() == undefined || $('#' + ddlLeaveId).val() == "") {
                    str = 'Leave Code Required.<br/>';
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
                        <telerik:RadGrid ID="gvEmployee" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvEmployee_InsertCommand"
                            OnNeedDataSource="gvEmployee_NeedDataSource" PageSize="20" OnDeleteCommand="gvEmployee_DeleteCommand"
                            OnUpdateCommand="gvEmployee_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvEmployee_ItemDataBound"
                            OnItemCommand="gvEmployee_ItemCommand" OnDetailTableDataBind="gvEmployee_DetailTableDataBind"
                            OnItemCreated="gvEmployee_ItemCreated">
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" EditMode="EditForms"
                                DataKeyNames="recidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="EmpLeaveTypes" CommandItemDisplay="Top" DataKeyNames="recidd">
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
                                                                    <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridTableView runat="server" AllowFilteringByColumn="true" Name="EmpLeaves" CommandItemDisplay="Top" DataKeyNames="recidd">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Code</h6>
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
                                                                            <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Button runat="server" ID="btnExportExcel" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnExportCsv" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnExportPdf" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <asp:Button runat="server" ID="btnPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                        HeaderText="ID" UniqueName="LeaveTypeId" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="levdsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="levdsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Description" UniqueName="TemplateColumn2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("levdsc") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="levsld" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="levsld" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn133 column"
                                                        HeaderText="Description 2" UniqueName="TemplateColumn133">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("levsld") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="levtypcod" Visible="false" FilterControlWidth="130px" SortExpression="levtypcod"
                                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                        HeaderText="Leave Code" UniqueName="TemplateColumn870">

                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 210px">
                                                                        <asp:HiddenField ID="hfEmployeeLevId" runat="server" Value='<%# Eval("emplevidd") %>' />
                                                                        <span class="combo180">
                                                                        <telerik:RadComboBox ID="ddlLeave" runat="server"
                                                                            Width="180px" Height="200px" DropDownWidth="180px"
                                                                            EmptyMessage="Please select...">
                                                                            <ItemTemplate>
                                                                                
                                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelLeave" runat="server" Width="180px" LoadingPanelID="RadAjaxLoadingPanelLeave" Height="200px">
                                                                                    <div style="overflow: auto; height: 200px;">
                                                                                    <telerik:RadGrid ID="rGrdLeave4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeave4DDL_NeedDataSource"
                                                                                        Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                        <ClientSettings>
                                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                        </ClientSettings>

                                                                                        <MasterTableView DataKeyNames="recidd,levcod,levdsc" ClientDataKeyNames="recidd,levcod,levdsc">
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
                                                                                                <telerik:GridBoundColumn DataField="levcod" FilterControlAltText="Filter column2 column"
                                                                                                    HeaderText="Code" UniqueName="levcod">
                                                                                                </telerik:GridBoundColumn>
                                                                                                <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column3 column"
                                                                                                    HeaderText="Description" UniqueName="levdsc">
                                                                                                </telerik:GridBoundColumn>
                                                                                            </Columns>
                                                                                            <EditFormSettings>
                                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                                </EditColumn>
                                                                                            </EditFormSettings>
                                                                                        </MasterTableView>
                                                                                        <ClientSettings>
                                                                                            <ClientEvents OnRowDeselected="OnLeaveRowSelected" OnRowSelected="OnLeaveRowSelected"></ClientEvents>
                                                                                        </ClientSettings>
                                                                                        <FilterMenu EnableImageSprites="False">
                                                                                        </FilterMenu>
                                                                                    </telerik:RadGrid>
                                                                                        </div>
                                                                                </telerik:RadAjaxPanel>
                                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLeave" runat="server">
                                                                                </telerik:RadAjaxLoadingPanel>
                                                                                    
                                                                            </ItemTemplate>
                                                                            <Items>
                                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                            </Items>
                                                                        </telerik:RadComboBox>
                                                                            </span>

                                                                    </td>
                                                                    <td>
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="ddlLeave"></asp:RequiredFieldValidator></td>
                                                                    <td></td>
                                                                </tr>
                                                            </table>

                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="EditEmpLeaves" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="25px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Leave Code record?"
                                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteEmpLeaves" ConfirmTextFormatString='Are you sure to delete Employee Leave Code record # {0}?'>
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
                                            <telerik:GridBoundColumn DataField="recidd" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="LeaveTypeId" ReadOnly="True" DataType="System.Int32" Visible="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                            </telerik:GridBoundColumn>
                                            <telerik:GridTemplateColumn DataField="levtypcod" Visible="false" FilterControlWidth="130px" SortExpression="levtypcod"
                                                AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Leave Type" UniqueName="TemplateColumn870">
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 210px">
                                                                <asp:HiddenField ID="hfEmployeeId" runat="server" Value='<%# Eval("empidd") %>' />
                                                                <span class="combo180">
                                                                <telerik:RadComboBox ID="ddlLeaveType" runat="server"
                                                                    Width="180px" Height="200px" DropDownWidth="180px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <telerik:RadAjaxPanel ID="RadAjaxPanelLeaveType" runat="server" Width="180px" LoadingPanelID="RadAjaxLoadingPanelLeaveType" Height="200px">
                                                                            <div style="overflow: auto; height: 200px;">
                                                                            <telerik:RadGrid ID="rGrdLeaveType4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeaveType4DDL_NeedDataSource"
                                                                                Width="180px" ClientSettings-EnableRowHoverStyle="True">
                                                                                <ClientSettings>
                                                                                    <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                                </ClientSettings>

                                                                                <MasterTableView DataKeyNames="recidd,levtypcod,levdsc" ClientDataKeyNames="recidd,levtypcod,levdsc">
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
                                                                                        <telerik:GridBoundColumn DataField="levtypcod" FilterControlAltText="Filter column2 column"
                                                                                            HeaderText="Code" UniqueName="levtypcod">
                                                                                        </telerik:GridBoundColumn>
                                                                                        <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column3 column"
                                                                                            HeaderText="Description" UniqueName="levdsc">
                                                                                        </telerik:GridBoundColumn>
                                                                                    </Columns>
                                                                                    <EditFormSettings>
                                                                                        <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                        </EditColumn>
                                                                                    </EditFormSettings>
                                                                                </MasterTableView>
                                                                                <ClientSettings>
                                                                                    <ClientEvents OnRowDeselected="OnLeaveTypeRowSelected" OnRowSelected="OnLeaveTypeRowSelected"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                                </div>
                                                                        </telerik:RadAjaxPanel>
                                                                        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLeaveType" runat="server">
                                                                        </telerik:RadAjaxLoadingPanel>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                    </span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator167" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlLeaveType"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levdsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="levdsc" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description" UniqueName="TemplateColumn2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("levdsc") %>'></asp:Label>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="levsld" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="levsld" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn133 column"
                                                HeaderText="Description 2" UniqueName="TemplateColumn133">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("levsld") %>'></asp:Label>
                                                </ItemTemplate>

                                            </telerik:GridTemplateColumn>
                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                UniqueName="EditEmpLeaves" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                <ItemStyle HorizontalAlign="Center" Width="25px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Leave Type record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteEmpLeaves" ConfirmTextFormatString='Are you sure to delete Employee Leave Type record # {0}?'>
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
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee Leave Assignment</h6>
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
                                                            <%--                                                            <asp:Button ID="Button1" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlteratteText="Add" ToolTip="Add" />--%>
                                                        </td>
                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnEmployeeExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlteratteText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnEmployeeCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlteratteText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnEmployeePdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlteratteText="Pdf" ToolTip="Pdf" />
                                                            <span class="combo180">
                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="180px" DropDownWidth="180px"></telerik:RadComboBox>
                                                            </span>
                                                            <asp:Button runat="server" ID="btnEmployeePrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlteratteText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnEmployeeRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlteratteText="Refresh" ToolTip="Refresh" />
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
                                        HeaderText="ID" UniqueName="EmployeeId" ReadOnly="True" DataType="System.Int32" Visible="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn DataField="empcod" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Employee Code" UniqueName="TemplateColumn0">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempcod" runat="server" Text='<%# Eval("empcod") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="empfsn" FilterControlWidth="130px" SortExpression="empcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="First Name" UniqueName="TemplateColumn01">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempfsn" runat="server" Text='<%# Eval("empfsn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="empmdn" Visible="false" FilterControlWidth="130px" SortExpression="empmdn" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Middle Name" UniqueName="TemplateColumn02">
                                        <ItemTemplate>
                                            <asp:Label ID="lblempmdn" runat="server" Text='<%# Eval("empmdn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="emplsn" FilterControlWidth="130px" SortExpression="emplsn" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Last Name" UniqueName="TemplateColumn03">
                                        <ItemTemplate>
                                            <asp:Label ID="lblemplsn" runat="server" Text='<%# Eval("emplsn") %>'></asp:Label>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="levtypcod" Visible="false" FilterControlWidth="130px" SortExpression="levtypcod"
                                        AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Leave Type" UniqueName="TemplateColumn870">

                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 280px">

                                                        <telerik:RadComboBox ID="ddlLeaveType" runat="server"
                                                            Width="260px" Height="200px" DropDownWidth="410px"
                                                            EmptyMessage="Please select...">
                                                            <ItemTemplate>
                                                                <telerik:RadAjaxPanel ID="RadAjaxPanelLeaveType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelLeaveType" Height="200px">
                                                                    <telerik:RadGrid ID="rGrdLeaveType4DDL" AllowMultiRowSelection="true" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdLeaveType4DDL_NeedDataSource"
                                                                        Width="410px" ClientSettings-EnableRowHoverStyle="True">
                                                                        <ClientSettings>
                                                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true"></Selecting>
                                                                        </ClientSettings>

                                                                        <MasterTableView DataKeyNames="recidd,levtypcod,levdsc" ClientDataKeyNames="recidd,levtypcod,levdsc">
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
                                                                                <telerik:GridBoundColumn DataField="levtypcod" FilterControlAltText="Filter column2 column"
                                                                                    HeaderText="Code" UniqueName="levtypcod">
                                                                                </telerik:GridBoundColumn>
                                                                                <telerik:GridBoundColumn DataField="levdsc" FilterControlAltText="Filter column3 column"
                                                                                    HeaderText="Description" UniqueName="levdsc">
                                                                                </telerik:GridBoundColumn>
                                                                            </Columns>
                                                                            <EditFormSettings>
                                                                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                                                                </EditColumn>
                                                                            </EditFormSettings>
                                                                        </MasterTableView>
                                                                        <ClientSettings>
                                                                            <ClientEvents OnRowDeselected="OnLeaveTypeRowSelected" OnRowSelected="OnLeaveTypeRowSelected"></ClientEvents>
                                                                        </ClientSettings>
                                                                        <FilterMenu EnableImageSprites="False">
                                                                        </FilterMenu>
                                                                    </telerik:RadGrid>
                                                                </telerik:RadAjaxPanel>
                                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelLeaveType" runat="server">
                                                                </telerik:RadAjaxLoadingPanel>
                                                            </ItemTemplate>
                                                            <Items>
                                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                            </Items>
                                                        </telerik:RadComboBox>

                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1877" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="ddlLeaveType"></asp:RequiredFieldValidator></td>
                                                    <td></td>
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <%-- <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditEmployee"
                                        ButtonType="ImageButton" ItemStyle-Width="40px" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee record?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        ItemStyle-Width="40px" UniqueName="DeleteEmployee" ConfirmTextFormatString='Are you sure to delete Employee record "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>--%>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for EmployeeClass Record # "{0}":' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" IsSticky="true" runat="server" Skin="Default" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>



