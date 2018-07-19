<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="LeaveBalance.aspx.cs" Inherits="Payroll_LeaveBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function KeyPress(sender, args) {
                if (args.get_keyCharacter() == sender.get_numberFormat().DecimalSeparator) {
                    args.set_cancel(true);
                }
            }
            function OnLeaveTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("levtypcod");
                var id = args.getDataKeyValue("recidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdLeaveType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
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

                    //args.get_eventTarget().indexOf("btnAdd") >= 0 ||
                                           args.get_eventTarget().indexOf("btnExportExcel") >= 0 ||
                                           args.get_eventTarget().indexOf("btnExportCsv") >= 0 ||
                                          args.get_eventTarget().indexOf("btnExportPdf") >= 0 ||
                                           args.get_eventTarget().indexOf("btnPrint") >= 0 ||
                     args.get_eventTarget().indexOf("btnRefresh") >= 0


                   ) {
                    args.set_enableAjax(false);
                }
            }

            function OnNatCodeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("natcod");
                var id = args.getDataKeyValue("natidd");
                var combo = $find(sender.ClientID.replace('_i0_rGrdNatCode4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnPayPeriodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayPeriod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            } function OnEmpLeavesTypeRowClicked(sender, args) {
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
            function ValidateEmpLeaves(txtBxBalanceId, dtpdateId) {
                var str = '';
                if ($('#' + txtBxBalanceId).val() == undefined || $('#' + txtBxBalanceId).val() == "") {
                    str = 'Balance Required.<br/>';
                }
                if ($('#' + dtpdateId).val() == undefined || $('#' + dtpdateId).val() == "") {
                    str += 'Date Required.<br/>';
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
                            OnItemCreated="gvEmployee_ItemCreated" >
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
                                    <telerik:GridTableView runat="server" AllowFilteringByColumn="true" Name="EmpLeaves" CommandItemDisplay="Top" DataKeyNames="lvtidd">
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
                                                                    <%--                                                                <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
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
                                            <telerik:GridTableView runat="server" AllowFilteringByColumn="true"
                                                Name="EmpLeavesDetail" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="levid">
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
                                                                            <%--                                                                <asp:Button ID="btnAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />--%>
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
                                                    <telerik:GridBoundColumn DataField="levid" FilterControlAltText="Filter column column"
                                                        HeaderText="ID" UniqueName="levid" ReadOnly="True" DataType="System.Int32">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="levcod" FilterControlWidth="130px" SortExpression="levcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                        HeaderText="Leave Code" UniqueName="TemplateColumn0">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbllevcod" runat="server" Text='<%# Eval("levcod") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="lvcbal" FilterControlWidth="130px" AutoPostBackOnFilter="true"
                                                        SortExpression="lvcbal" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Balance" UniqueName="TemplateColumn2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBalance" runat="server" Text='<%# Eval("lvcbal", "{0:0.00}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">
                                                                        <telerik:RadNumericTextBox runat="server" ID="txtBxBalance" Width="60px" MaxLength="8" MaxValue="999999"
                                                                            AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("lvcbal") %>'
                                                                            EnableSingleInputRendering="True">
                                                                            <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                                KeepTrailingZerosOnFocus="True" />
                                                                        </telerik:RadNumericTextBox>

                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtBxBalance"></asp:RequiredFieldValidator></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>

                                                    <telerik:GridTemplateColumn DataField="lvcdat" FilterControlWidth="130px"
                                                        AutoPostBackOnFilter="true" SortExpression="lvcdat" CurrentFilterFunction="Contains"
                                                        FilterControlAltText="Filter TemplateColumn133 column"
                                                        HeaderText="Date" UniqueName="TemplateColumn133">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDate" runat="server" Text='<%# Eval("lvcdat","{0:d}") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="border-bottom: 0px">
                                                                        <telerik:RadDatePicker ID="dtpdate" runat="server" DbSelectedDate='<%# Bind("lvcdat") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                                        </telerik:RadDatePicker>
                                                                    </td>
                                                                    <td style="border-bottom: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator21" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="dtpdate"></asp:RequiredFieldValidator>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        UniqueName="EditEmpLeaves" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                        <ItemStyle HorizontalAlign="Center" Width="45px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <%-- <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Leave Code record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteEmpLeaves" ConfirmTextFormatString='Are you sure to delete Employee Leave Code record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>--%>
                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="levid" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>

                                        </DetailTables>
                                        <Columns>
                                            <telerik:GridBoundColumn DataField="lvtidd" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="LeaveTypeId" ReadOnly="True" DataType="System.Int32">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="levtypcod" FilterControlWidth="130px" SortExpression="levtypcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Leave Type" UniqueName="TemplateColumn0">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbltypcod" runat="server" Text='<%# Eval("levtypcod") %>'></asp:Label>
                                                </ItemTemplate>

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


                                            <%-- <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                            UniqueName="EditEmpLeaves" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridEditCommandColumn>
                                        <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Leave Type record?"
                                            ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                            UniqueName="DeleteEmpLeaves" ConfirmTextFormatString='Are you sure to delete Employee Leave Type record # {0}?'>
                                            <ItemStyle HorizontalAlign="Center" Width="25px" />
                                        </telerik:GridButtonColumn>--%>
                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="lvtidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Leave Opening Balance</h6>
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

                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
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
                                        HeaderText="ID" UniqueName="EmployeeId" ReadOnly="True" DataType="System.Int32">
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
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>





