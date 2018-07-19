<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="DivisionSetup.aspx.cs" Inherits="Payroll_Division" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnDivisionExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDivisionCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDivisionPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnDivisionPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnDivisionRefresh") >= 0 ||
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
            function ValidateDivision(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Division Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateDepartment(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Department Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }
            function ValidateSection(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Section Code Required.<br/>';
                }
                if ($('#' + txtDescriptionId).val() == undefined || $('#' + txtDescriptionId).val() == "") {
                    str += 'Description Required.<br/>';
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
                        <telerik:RadGrid ID="gvDivision" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvDivision_InsertCommand"
                            OnNeedDataSource="gvDivision_NeedDataSource" PageSize="20" OnDeleteCommand="gvDivision_DeleteCommand"
                            OnUpdateCommand="gvDivision_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvDivision_ItemDataBound"
                            OnItemCommand="gvDivision_ItemCommand" OnDetailTableDataBind="gvDivision_DetailTableDataBind"
                            OnItemCreated="gvDivision_ItemCreated" >
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="dividd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="Departments" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="dptidd">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Department Setup</h6>
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
                                                                    <asp:Button runat="server" ID="btnDivisionExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnDivisionCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnDivisionPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnDivisionPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnDivisionRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridTableView runat="server" Name="Sections" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="secidd">
                                                <CommandItemTemplate>
                                                    <div class="title">
                                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Section Setup</h6>
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
                                                                            <asp:Button ID="btnSectionInsert" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                        </td>
                                                                        <td align="right">
                                                                            <asp:Button runat="server" ID="btnSectionExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                            <asp:Button runat="server" ID="btnSectionCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                            <asp:Button runat="server" ID="btnSectionPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                            <asp:Button runat="server" ID="btnSectionPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                            <asp:Button ID="btnSectionRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                                    <telerik:GridBoundColumn DataField="secidd" FilterControlAltText="Filter column column"
                                                        HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" visible="false">
                                                        <ColumnValidationSettings>
                                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                                        </ColumnValidationSettings>
                                                        <FilterTemplate>
                                                            <strong>Search</strong>
                                                        </FilterTemplate>
                                                        <ItemStyle Width="50px" />
                                                    </telerik:GridBoundColumn>

                                                    <telerik:GridTemplateColumn DataField="seccod" FilterControlWidth="130px" SortExpression="seccod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                        HeaderText="Section Code" UniqueName="seccod">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblsecCode" runat="server" Text='<%# Eval("seccod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadTextBox ID="txtsecCode" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("seccod") %>'>
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtsecCode"></asp:RequiredFieldValidator></td>

                                                                </tr>
                                                            </table>

                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="secds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="secds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Description" UniqueName="secds1">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("secds1") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadTextBox ID="txtsecds1" MaxLength="50" runat="server" Text='<%# Eval("secds1") %>'>
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                            ControlToValidate="txtsecds1"></asp:RequiredFieldValidator>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>
                                                    <telerik:GridTemplateColumn DataField="secds2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="secds2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                        HeaderText="Description 2" UniqueName="secds2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("secds2") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                                        <telerik:RadTextBox ID="txtsecdv2" MaxLength="50" runat="server" Text='<%# Eval("secds2") %>'>
                                                                        </telerik:RadTextBox>
                                                                    </td>
                                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                    </telerik:GridTemplateColumn>


                                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditSection">
                                                        <ItemStyle HorizontalAlign="Center" Width="43px" />
                                                    </telerik:GridEditCommandColumn>
                                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Section?"
                                                        ConfirmTextFields="secidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                        UniqueName="DeleteSection" ConfirmTextFormatString='Are you sure to delete Section # {0}?'>
                                                        <ItemStyle HorizontalAlign="Center" Width="43px" />
                                                    </telerik:GridButtonColumn>

                                                </Columns>
                                                <SortExpressions>
                                                    <telerik:GridSortExpression FieldName="secidd" SortOrder="Ascending" />
                                                </SortExpressions>
                                                <EditFormSettings>
                                                    <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                                    </EditColumn>
                                                </EditFormSettings>
                                            </telerik:GridTableView>

                                        </DetailTables>
                                        <Columns>
                                          <telerik:GridBoundColumn DataField="dptidd" FilterControlAltText="Filter column column"
                                                HeaderText="ID" UniqueName="column" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                                <ColumnValidationSettings>
                                                    <ModelErrorMessage Text=""></ModelErrorMessage>
                                                </ColumnValidationSettings>
                                                <FilterTemplate>
                                                    <strong>Search</strong>
                                                </FilterTemplate>
                                                <ItemStyle Width="50px" />
                                            </telerik:GridBoundColumn>

                                            <telerik:GridTemplateColumn DataField="dptcod" FilterControlWidth="130px" SortExpression="dptcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Department Code" UniqueName="dptcod">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldptCode" runat="server" Text='<%# Eval("dptcod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                                <telerik:RadTextBox ID="txtdptCode" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("dptcod") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="border-bottom: 0px; padding-left: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtdptCode"></asp:RequiredFieldValidator></td>

                                                        </tr>
                                                    </table>

                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dptds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="dptds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description" UniqueName="dptds1">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("dptds1") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                                <telerik:RadTextBox ID="txtdptds1" MaxLength="50" runat="server" Text='<%# Eval("dptds1") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="border-bottom: 0px; padding-left: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtdptds1"></asp:RequiredFieldValidator>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="dptds2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="dptds2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                HeaderText="Description 2" UniqueName="dptds2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("dptds2") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                                <telerik:RadTextBox ID="txtdptdv2" MaxLength="50" runat="server" Text='<%# Eval("dptds2") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="border-bottom: 0px; padding-left: 0px">
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditDepartment">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Department?"
                                                ConfirmTextFields="dptidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteDepartment" ConfirmTextFormatString='Are you sure to delete Department # {0}?'>
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridButtonColumn>

                                        </Columns>
                                        <SortExpressions>
                                            <telerik:GridSortExpression FieldName="dptidd" SortOrder="Ascending" />
                                        </SortExpressions>
                                        <EditFormSettings>
                                            <EditColumn ButtonType="ImageButton" FilterControlAltText="Filter EditCommandColumn column">
                                            </EditColumn>
                                        </EditFormSettings>
                                    </telerik:GridTableView>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Division Setup</h6>
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
                                    <telerik:GridBoundColumn DataField="dividd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="dividd" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="divcod" FilterControlWidth="130px" SortExpression="divcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Division Code" UniqueName="divcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDivCode" runat="server" Text='<%# Eval("divcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtDivCode" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("divcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtDivCode"></asp:RequiredFieldValidator></td>

                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="divds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="divds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="divds1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("divds1") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtdivds1" MaxLength="200" runat="server" Text='<%# Eval("divds1") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtdivds1"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="divdv2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="divdv2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description 2" UniqueName="divdv2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("divdv2") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtdivdv2" MaxLength="200" runat="server" Text='<%# Eval("divdv2") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditDivision"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Division?"
                                        ConfirmTextFields="dividd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteDivision" ConfirmTextFormatString='Are you sure to delete Division record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Division record # "{0}":' CaptionDataField="dividd">
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


