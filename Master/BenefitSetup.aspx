<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="BenefitSetup.aspx.cs" Inherits="Payroll_BenefitSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">

            function ShowReport(Reportname) {
                window.open("../Reports/LaunchReport.aspx?Reportname=" + Reportname);
                return false;
            }

            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnBenefitExcelExport") >= 0 ||
                  args.get_eventTarget().indexOf("LinkBenefitExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnBenefitCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkBenefitCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnBenefitPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkBenefitPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnBenefitPrint") >= 0 ||
                      args.get_eventTarget().indexOf("LinkbtnBenefitPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnBenefitRefresh") >= 0 ||
                      args.get_eventTarget().indexOf("LinkBenefitRefresh") >= 0
                  ) {
                    args.set_enableAjax(false);
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
            function OnBenefitTypeRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdBenefitType4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGarnismentCategoryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGarnismentCategory4DDL', ''));
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

            function OnMethodRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdMethod4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateBenefit(txtBenefitCodeId, txtDescriptionId, ddlBenefitTypeId, ddlMethodId, dtpStartdateId, dtpEnddateId, ddlFrequencyId) {
                var str = '';
                var needDateCamparison = true;
                if ($('#' + txtBenefitCodeId).val() == undefined || $('#' + txtBenefitCodeId).val() == "") {
                    str = 'Benefit Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if ($('#' + ddlBenefitTypeId).val() == undefined || $('#' + ddlBenefitTypeId).val() == "") {
                    str += 'Benefit Type Required.<br/>';
                }
                if ($('#' + ddlMethodId).val() == undefined || $('#' + ddlMethodId).val() == "") {
                    str += 'Method Required.<br/>';
                }
                if ($('#' + dtpStartdateId).val() == undefined || $('#' + dtpStartdateId).val() == "") {
                    needDateCamparison = false;
                }
                if ($('#' + dtpEnddateId).val() == undefined || $('#' + dtpEnddateId).val() == "") {
                    needDateCamparison = false;
                }
                if (needDateCamparison) {
                    if (new Date($('#' + dtpStartdateId).val()).getTime() > new Date($('#' + dtpEnddateId).val()).getTime())
                        str += 'Greater End Date Required.<br/>';
                }
                if ($('#' + ddlFrequencyId).val() == undefined || $('#' + ddlFrequencyId).val() == "") {
                    str += 'Frequency Required.<br/>';
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
    <fieldset>
        <div class="widget">
            <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server" ClientEvents-OnRequestStart="onRequestStart" LoadingPanelID="RadAjaxLoadingPanel1">
                <div class="formRight">
                    <telerik:RadGrid ID="gvBenefit" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="true"
                        AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvBenefit_InsertCommand"
                        OnNeedDataSource="gvBenefit_NeedDataSource" PageSize="20" OnDeleteCommand="gvBenefit_DeleteCommand"
                        OnUpdateCommand="gvBenefit_UpdateCommand" OnItemDataBound="gvBenefit_ItemDataBound"
                        OnItemCommand="gvBenefit_ItemCommand" OnItemCreated="gvBenefit_ItemCreated">
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
                            </DetailTables>
                            <CommandItemSettings ExportToPdfText="Export to PDF"></CommandItemSettings>
                            <CommandItemTemplate>
                                <div class="title">
                                    <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Benefit Setup</h6>
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
                                                        <asp:Button runat="server" ID="btnBenefitExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />
                                                        <asp:Button runat="server" ID="btnBenefitCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />
                                                        <asp:Button runat="server" ID="btnBenefitPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                        <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>
                                                        <asp:Button runat="server" ID="btnBenefitPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />
                                                        <asp:Button ID="btnBenefitRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                <telerik:GridBoundColumn DataField="recidd" AllowFiltering="true" FilterControlAltText="Filter column column"
                                    HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                    <ItemStyle />
                                    <FilterTemplate>
                                        <strong>Search</strong>
                                    </FilterTemplate>
                                </telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn DataField="bftcod" SortExpression="bftcod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Benefit Code" UniqueName="TemplateColumn001">
                                    <ItemTemplate>
                                        <asp:Label ID="lblbftcod" runat="server" Text='<%# Eval("bftcod") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadTextBox ID="txtBenefitCode" runat="server" MaxLength="15" Text='<%# Eval("bftcod") %>'>
                                                    </telerik:RadTextBox>
                                                </td>
                                                <td>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="txtBenefitCode"></asp:RequiredFieldValidator>
                                                    <asp:Label ID="lblInclude" Style="padding-left: 13px" Width="250px" runat="server" Text="Inactive:"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox runat="server" ID="chkbxInclude" Text="" Checked='<%# CheckBoxValue( Eval("bftact")) %>' />
                                                </td>
                                            </tr>
                                        </table>

                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="bftds1" SortExpression="bftds1" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn2 column"
                                    HeaderText="Description" UniqueName="TemplateColumn2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("bftds1") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtDescription" runat="server" Text='<%# Eval("bftds1") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                            ControlToValidate="txtDescription"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="bftds2" SortExpression="bftds2" FilterControlWidth="130px" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn133 column"
                                    HeaderText="Description 2" UniqueName="TemplateColumn133">
                                    <ItemTemplate>
                                        <asp:Label ID="lblArabicDescription" runat="server" Text='<%# Eval("bftds2") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <telerik:RadTextBox ID="txtArabicDescription" runat="server" Text='<%# Eval("bftds2") %>' MaxLength="200">
                                        </telerik:RadTextBox>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn DataField="" Visible="false" SortExpression="" AllowFiltering="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Benefit Type" UniqueName="TemplateColumn0">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBenefitType" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>

                                        <asp:HiddenField ID="hfBenefitTypedllID" runat="server" Value='<%# Eval("bfttyp") %>' />
                                        <asp:HiddenField ID="hfBenefitTypedllText" runat="server" Value='<%# Eval("bfttyptext") %>' />
                                        <asp:HiddenField ID="hfBenefitTypedllValue" runat="server" Value='<%# Eval("bfttypvalue") %>' />
                                        <telerik:RadComboBox ID="ddlBenefitType" runat="server"
                                            Width="255px" Height="200px" DropDownWidth="410px"
                                            EmptyMessage="Please select...">

                                            <ItemTemplate>
                                                <telerik:RadAjaxPanel ID="RadAjaxPanelBenefitType" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelBenefitType" Height="200px">
                                                    <telerik:RadGrid ID="rGrdBenefitType4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdBenefitType4DDL_NeedDataSource"
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
                                                            <ClientEvents OnRowClick="OnBenefitTypeRowClicked"></ClientEvents>
                                                        </ClientSettings>
                                                        <FilterMenu EnableImageSprites="False">
                                                        </FilterMenu>
                                                    </telerik:RadGrid>
                                                </telerik:RadAjaxPanel>
                                                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBenefitType" runat="server">
                                                </telerik:RadAjaxLoadingPanel>
                                            </ItemTemplate>
                                            <Items>
                                                <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                            </Items>

                                        </telerik:RadComboBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlBenefitType"></asp:RequiredFieldValidator>


                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" DataField="" SortExpression="" AllowFiltering="true" CurrentFilterFunction="Contains" AutoPostBackOnFilter="true" FilterControlAltText="Filter TemplateColumn0 column"
                                    HeaderText="Start Date" UniqueName="TemplateColumn10">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStartDate" runat="server" Text=''></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>

                                        <telerik:RadDatePicker ID="dtpStartdate" runat="server" DbSelectedDate='<%# Bind("bftstr") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                            <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                            <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                        </telerik:RadDatePicker>

                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn7 column"
                                    HeaderText="End Date" UniqueName="TemplateColumn17">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <telerik:RadDatePicker ID="dtpEnddate" runat="server" DbSelectedDate='<%# Bind("bftend") %>' Culture="en-US" Style="margin: 2px; padding: 1px 0px;" Width="175px">
                                                        <Calendar UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" ViewSelectorText="x" DayCellToolTipFormat=" MM, dd, yyyy"></Calendar>
                                                        <DateInput DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%"></DateInput>
                                                    </telerik:RadDatePicker>
                                                     <asp:CompareValidator ID ="compare0fieldvalidator" runat="server" ErrorMessage="*"  ForeColor="Red"  Display="Dynamic"
                                                                        ControlToValidate ="dtpEnddate" Operator="GreaterThanEqual" Type="Date" 
                                                                ControlToCompare="dtpStartdate" ></asp:CompareValidator>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblmethod" Width="250px" Style="padding-left: 13px" runat="server" Text="Method:"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:HiddenField ID="hfMethoddllID" runat="server" Value='<%# Eval("bftmth") %>' />
                                                    <asp:HiddenField ID="hfMethodddlText" runat="server" Value='<%# Eval("bftmthtext") %>' />
                                                    <asp:HiddenField ID="hfMethodddlValue" runat="server" Value='<%# Eval("bftmthvalue") %>' />
                                                    <telerik:RadComboBox ID="ddlMethod" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">

                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelMethod" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelMethod" Height="200px">
                                                                <telerik:RadGrid ID="rGrdMethod4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdMethod4DDL_NeedDataSource"
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
                                                                        <ClientEvents OnRowClick="OnMethodRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGarnismentCategory" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>
                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlMethod"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn71 column"
                                    HeaderText="Frequency" UniqueName="TemplateColumn71">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfFrequencydllID" runat="server" Value='<%# Eval("bftfrq") %>' />
                                                    <asp:HiddenField ID="hfFrequencyddlText" runat="server" Value='<%# Eval("bftfrqtext") %>' />
                                                    <asp:HiddenField ID="hfFrequencyddlValue" runat="server" Value='<%# Eval("bftfrqvalue") %>' />
                                                    <telerik:RadComboBox ID="ddlFrequency" runat="server"
                                                        Width="255px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">

                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelFrequency" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelFrequency" Height="200px">
                                                                <telerik:RadGrid ID="rGrdFrequency4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                    CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdFrequency4DDL_NeedDataSource"
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
                                                                        <ClientEvents OnRowClick="OnFrequencyRowClicked"></ClientEvents>
                                                                    </ClientSettings>
                                                                    <FilterMenu EnableImageSprites="False">
                                                                    </FilterMenu>
                                                                </telerik:RadGrid>
                                                            </telerik:RadAjaxPanel>
                                                            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelBenefitType" runat="server">
                                                            </telerik:RadAjaxLoadingPanel>
                                                        </ItemTemplate>
                                                        <Items>
                                                            <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                        </Items>

                                                    </telerik:RadComboBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12222" runat="server" ErrorMessage="*" ForeColor="Red"
                                                        ControlToValidate="ddlFrequency"></asp:RequiredFieldValidator>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblMaximumBenefit" Style="padding-left: 13px" Width="250px" runat="server" Text="Maximum Benefit:"></asp:Label>
                                                </td>
                                                <td>
                                                    <telerik:RadNumericTextBox runat="server" ID="txtMaximumBenefit" Width="75" MaxLength="8" MaxValue="999999"
                                                        AllowOutOfRangeAutoCorrect="True" DataType="System.Decimal" Text='<%# Eval("bftmax") %>'
                                                        EnableSingleInputRendering="True">
                                                        <NumberFormat AllowRounding="False" DecimalDigits="2" KeepNotRoundedValue="True"
                                                            KeepTrailingZerosOnFocus="True" />
                                                    </telerik:RadNumericTextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>

                                <telerik:GridTemplateColumn Visible="false" FilterControlAltText="Filter TemplateColumn71111 column"
                                    HeaderText="Pay Codes" UniqueName="TemplateColumn71111">
                                    <EditItemTemplate>
                                        <table>
                                            <tr>
                                                <td style="width: 280px">
                                                    <asp:HiddenField ID="hfBenefitID" runat="server" Value='<%# Eval("recidd") %>' />
                                                    <telerik:RadComboBox ID="ddlPayCode" runat="server"
                                                        Width="260px" Height="200px" DropDownWidth="410px"
                                                        EmptyMessage="Please select...">
                                                        <ItemTemplate>
                                                            <telerik:RadAjaxPanel ID="RadAjaxPanelPayCode" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelPayCode" Height="200px">
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
                                                                                HeaderText="Text" UniqueName="paycod">
                                                                            </telerik:GridBoundColumn>
                                                                            <telerik:GridBoundColumn DataField="payds1" FilterControlAltText="Filter column3 column"
                                                                                HeaderText="Value" UniqueName="payds1">
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

                                                    <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator122222" runat="server" ErrorMessage="*" ForeColor="Red"
                                            ControlToValidate="ddlPaycode"></asp:RequiredFieldValidator>--%>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </EditItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                    ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditBenefit">
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridEditCommandColumn>
                                <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Benefit Record?"
                                    ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                    UniqueName="DeleteBenefit" ConfirmTextFormatString='Are you sure to delete Benefit record # "{0}"?'>
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridButtonColumn>
                            </Columns>
                            <EditFormSettings CaptionFormatString='Edit Details for Benefit Record # "{0}":' CaptionDataField="recidd">
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
