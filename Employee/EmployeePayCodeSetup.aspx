<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="EmployeePayCodeSetup.aspx.cs" Inherits="Payroll_EmployeePayCodeSetup" %>

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
            } function OnPayCodeTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdPayCodeType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function ValidatePayCode(ddlPayCodeId, txtDescriptionId, ddlPayCodeTypeId, ddlPayPeriodId) {
                var str = '';
                if ($('#' + ddlPayCodeId).val() == undefined || $('#' + ddlPayCodeId).val() == "") {
                    str = 'PayCode Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlPayCodeTypeId).val() == undefined || $('#' + ddlPayCodeTypeId).val() == "") {
                    str += 'Pay Type Required.<br/>';
                }
                if ($('#' + ddlPayPeriodId).val() == undefined || $('#' + ddlPayPeriodId).val() == "") {
                    str += 'Pay Period Required.<br/>';
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
                            OnItemCommand="gvEmployee_ItemCommand" OnDetailTableDataBind="gvEmployee_DetailTableDataBind" OnItemCreated="gvEmployee_ItemCreated">
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
                                InsertItemPageIndexAction="ShowItemOnCurrentPage">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" AllowFilteringByColumn="false" Name="PayCodes" CommandItemDisplay="Top" DataKeyNames="recidd">
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
                                            <telerik:GridTemplateColumn DataField="paycod" SortExpression="paycod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Pay Code" UniqueName="TemplateColumn001">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpaycod" runat="server" Text='<%# Eval("paycod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:HiddenField ID="hfddlPayCodeId" runat="server" Value='<%# Eval("payidd") %>' />
                                                                <asp:HiddenField ID="hfddlPayCodeText" runat="server" Value='<%# Eval("paycod") %>' />
                                                                <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                                    Width="255px" Height="200px" DropDownWidth="410px"
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
                                                            <td>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator66" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="ddlPayCode"></asp:RequiredFieldValidator>
                                                                <asp:Label ID="lblInclude" Style="padding-left: 13px" Width="250px" runat="server" Text="Inactive:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:CheckBox runat="server" ID="chkbxInclude" Text="" Checked='<%# CheckBoxValue( Eval("payact")) %>' />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="payds1" SortExpression="payds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description" UniqueName="TemplateColumn2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("payds1") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("payds1") %>' MaxLength="200">
                                                    </telerik:RadTextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                        ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="payds2" SortExpression="payds2" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn133 column"
                                                HeaderText="Description 2" UniqueName="TemplateColumn133">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("payds2") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("payds2") %>' MaxLength="200">
                                                    </telerik:RadTextBox>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="false" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Pay Type" UniqueName="TemplateColumn0">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPayCodeType" runat="server" Text=''></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:HiddenField ID="hfPayCodeTypedllID" runat="server" Value='<%# Eval("paytyp") %>' />
                                                                <asp:HiddenField ID="hfPayCodeTypedllText" runat="server" Value='<%# Eval("paytyptext") %>' />
                                                                <asp:HiddenField ID="hfPayCodeTypedllValue" runat="server" Value='<%# Eval("paytypvalue") %>' />
                                                                <telerik:RadComboBox ID="ddlPayCodeType" runat="server"
                                                                    Width="260px" Height="200px" DropDownWidth="410px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <telerik:RadAjaxPanel ID="RadAjaxPanelPayCodeType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCodeType" Height="200px">
                                                                            <telerik:RadGrid ID="rGrdPayCodeType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayCodeType4DDL_NeedDataSource"
                                                                                Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                    <ClientEvents OnRowClick="OnPayCodeTypeRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                        </telerik:RadAjaxPanel>
                                                                        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCodeType" runat="server">
                                                                        </telerik:RadAjaxLoadingPanel>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>
                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                    ControlToValidate="ddlPayCodeType"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn711 column"
                                                HeaderText="Pay Rate" UniqueName="TemplateColumn711">
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <telerik:RadNumericTextBox runat="server" ID="txtPayrate" Width="75" MaxLength="8" MaxValue="999999"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("payrat") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                            <td>
                                                                <%--                                                    <asp:Label ID="lblUnitofPay" Style="padding-left: 13px" Width="250px" runat="server" Text="Unit of Pay:"></asp:Label>--%>
                                                            </td>
                                                            <td>
                                                                <%-- <telerik:RadTextBox ID="txtUnitofPay" ReadOnly="true" runat="server"  MaxLength="100" Text='<%# Eval("payunp") %>'>
                                                    </telerik:RadTextBox>--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn71 column"
                                                HeaderText="Pay Period" UniqueName="TemplateColumn71">
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:HiddenField ID="hfPayPerioddllID" runat="server" Value='<%# Eval("payper") %>' />
                                                                <asp:HiddenField ID="hfPayPeriodddlText" runat="server" Value='<%# Eval("paypertext") %>' />
                                                                <asp:HiddenField ID="hfPayPeriodddlValue" runat="server" Value='<%# Eval("paypervalue") %>' />
                                                                <telerik:RadComboBox ID="ddlPayPeriod" runat="server"
                                                                    Width="255px" Height="200px" DropDownWidth="410px"
                                                                    EmptyMessage="Please select...">
                                                                    <ItemTemplate>
                                                                        <telerik:RadAjaxPanel ID="RadAjaxPanelPayPeriod" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayPeriod" Height="200px">
                                                                            <telerik:RadGrid ID="rGrdPayPeriod4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdPayPeriod4DDL_NeedDataSource"
                                                                                Width="410px" ClientSettings-EnableRowHoverStyle="True">
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
                                                                                    <ClientEvents OnRowClick="OnPayPeriodRowClicked"></ClientEvents>
                                                                                </ClientSettings>
                                                                                <FilterMenu EnableImageSprites="False">
                                                                                </FilterMenu>
                                                                            </telerik:RadGrid>
                                                                        </telerik:RadAjaxPanel>
                                                                        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelPayCodeType" runat="server">
                                                                        </telerik:RadAjaxLoadingPanel>
                                                                    </ItemTemplate>
                                                                    <Items>
                                                                        <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                                    </Items>

                                                                </telerik:RadComboBox>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator12222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                                    ControlToValidate="ddlPayPeriod"></asp:RequiredFieldValidator>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblPayperperiod" Style="padding-left: 13px" Width="250px" runat="server" Text="Pay per Period:"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <telerik:RadNumericTextBox runat="server" ID="txtpayperpriod" Width="75" MaxLength="8" MaxValue="999999"
                                                                    AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("payppr") %>'
                                                                    EnableSingleInputRendering="True">
                                                                    <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                                        KeepTrailingZerosOnFocus="True" />
                                                                </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn Visible="false" DataField="paydft" SortExpression="paydft" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0111 column"
                                                HeaderText="Is Default Code" UniqueName="TemplateColumn0011">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpaydft" runat="server" Text='<%# Eval("paydft") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px">
                                                                <asp:CheckBox runat="server" ID="chkbxDefault" Text="" Checked='<%# CheckBoxValue( Eval("paydft")) %>' />
                                                            </td>
                                                            <td></td>
                                                            <td></td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                UniqueName="EditPayCode" ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                                <ItemStyle HorizontalAlign="Center" Width="25px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Employee Pay Code record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeletePayCode" ConfirmTextFormatString='Are you sure to delete Employee Pay Code record # {0}?'>
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
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Employee Pay Code Setup</h6>
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
                                <EditFormSettings EditFormType="Template" CaptionFormatString='Edit Details for Employee "{0}":' CaptionDataField="recidd">
                                    <EditColumn UniqueName="EditCommandColumn1" />
                                    <FormTemplate>
                                        <table style="margin: 10px">
                                            <tr>
                                                <td align="left">
                                                    <asp:Button ID="btnUpdate" CssClass="rgUpdate" Text="" CausesValidation="true"
                                                        runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'></asp:Button>
                                                    <asp:Button ID="btnCancel" CssClass="rgCancel" Text="" runat="server" CausesValidation="False"
                                                        CommandName="Cancel"></asp:Button>
                                                </td>
                                            </tr>
                                        </table>
                                    </FormTemplate>
                                    <PopUpSettings ScrollBars="None" />
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

