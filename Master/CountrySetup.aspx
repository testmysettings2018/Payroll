<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="CountrySetup.aspx.cs" Inherits="Payroll_CountrySetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <style type="text/css">
        .RadGrid_Silk .rgFilterRow input
        {
            vertical-align: middle;
        }
        </style>
    
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnCountryCityExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryCityCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryCityPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryCityPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryCityRefresh") >= 0 ||
                    args.get_eventTarget().indexOf("btnCountryExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnCountryRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }
            function OnCategoryRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdCategory4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }
            function OnGroupRowClicked(sender, args) {
                var cellValues = args.getDataKeyValue("Text");
                var id = args.getDataKeyValue("ValueSetID");
                var combo = $find(sender.ClientID.replace('_i0_rGrdGroup4DDL', ''));
                setTimeout(function () {
                    combo.trackChanges();
                    combo.set_text(cellValues);
                    combo.get_items().getItem(0).set_value(id);
                    combo.commitChanges();
                }, 50);
            }

            function ValidateCountry(txtbxCodeId, txtNameId, txtctrntsId, ddlGroupId, ddlCategoryId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtNameId).val() == undefined || $('#' + txtNameId).val() == "") {
                    str += 'Name Required.<br/>';
                }
                if ($('#' + txtctrntsId).val() == undefined || $('#' + txtctrntsId).val() == "") {
                    str += 'Nationality Required.<br/>';
                }
                if ($('#' + ddlCategoryId).val() == undefined || $('#' + ddlCategoryId).val() == "") {
                    str += 'Category Required.<br/>';
                }
                if ($('#' + ddlGroupId).val() == undefined || $('#' + ddlGroupId).val() == "") {
                    str += 'Group Required.<br/>';
                }

                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateCity(txtctrctyId, txtBxctrnamId, txtBxctrdscId) {
                var str = '';
                if ($('#' + txtctrctyId).val() == undefined || $('#' + txtctrctyId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtBxctrnamId).val() == undefined || $('#' + txtBxctrnamId).val() == "") {
                    str += 'Name Required.<br/>';
                }
                if ($('#' + txtBxctrdscId).val() == undefined || $('#' + txtBxctrdscId).val() == "") {
                    str += 'Description Required.<br/>';
                }
                if (str != '') {
                    showError(str, null, 10000);
                }
            }

            function ValidateProvince(txtprvcodId, txtprvnamId, txtprvdscId) {
                var str = '';
                if ($('#' + txtprvcodId).val() == undefined || $('#' + txtprvcodId).val() == "") {
                    str = 'Code Required.<br/>';
                }
                if ($('#' + txtprvnamId).val() == undefined || $('#' + txtprvnamId).val() == "") {
                    str += 'Name Required.<br/>';
                }
                if ($('#' + txtprvdscId).val() == undefined || $('#' + txtprvdscId).val() == "") {
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
                        <telerik:RadGrid ID="gvCountry" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvCountry_InsertCommand"
                            OnNeedDataSource="gvCountry_NeedDataSource" PageSize="20" OnDeleteCommand="gvCountry_DeleteCommand"
                            OnUpdateCommand="gvCountry_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvCountry_ItemDataBound"
                            OnItemCommand="gvCountry_ItemCommand" OnDetailTableDataBind="gvCountry_DetailTableDataBind" OnItemCreated="gvCountry_ItemCreated">
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
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-ShowExportToCsvButton="true" CommandItemSettings-ShowExportToExcelButton="true" 
                                CommandItemSettings-ShowExportToPdfButton="true" CommandItemSettings-ShowExportToWordButton="true" AutoGenerateColumns="False" DataKeyNames="recidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="EditForms">
                                <DetailTables>
                                    <telerik:GridTableView runat="server" Name="City" CommandItemDisplay="Top" EditMode="InPlace" DataKeyNames="recidd">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Country City</h6>
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
                                                                    <asp:Button ID="btnCountryAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnCountryExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnCountryCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnCountryPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnCountryPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnCountryRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridTemplateColumn DataField="ctrcty" FilterControlWidth="130px" SortExpression="ctrcty" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                                HeaderText="Code" UniqueName="ctrcty" >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblctrcty" runat="server" Text='<%# Eval("ctrcty") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtctrcty" Style="float: left" runat="server" MaxLength="15" Text='<%# Eval("ctrcty") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtctrcty"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn DataField="ctrnam" SortExpression="ctrnam" FilterControlAltText="Filter TemplateColumn2 column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                                HeaderText="Name" UniqueName="TemplateColumn212">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblctrnam" runat="server" Text='<%# Eval("ctrnam") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtBxctrnam" Style="float: left" runat="server" MaxLength="200" Text='<%# Eval("ctrnam") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator612311" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtBxctrnam"></asp:RequiredFieldValidator></td>

                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="ctrdsc" SortExpression="ctrdsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0111 column"
                                                HeaderText="Description" UniqueName="TemplateColumn001111">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblctrdsc" runat="server" Text='<%# Eval("ctrdsc") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtBxctrdsc" Style="float: left" runat="server" MaxLength="200" Text='<%# Eval("ctrdsc") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6122311" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtBxctrdsc"></asp:RequiredFieldValidator></td>

                                                        </tr>
                                                    </table>


                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                               <telerik:GridTemplateColumn DataField="ctyamount" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctyamount" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Amount" UniqueName="ctyamount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblctyamount" runat="server" Text='<%# Convert.ToDouble(Eval("ctyamount")).ToString("#####0.00") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 100px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadNumericTextBox ID="txtctyamount" MaxLength="50" runat="server" Text='<%# Eval("ctyamount") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                             
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditCity">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Country City record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteCity" ConfirmTextFormatString='Are you sure to delete Country City record # {0}?'>
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


                                    <telerik:GridTableView runat="server" Name="Province" AllowFilteringByColumn="false" CommandItemDisplay="Top" EditMode="EditForms" DataKeyNames="recidd">
                                        <CommandItemTemplate>
                                            <div class="title">
                                                <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Country Provinces</h6>
                                            </div>
                                            <tr class="rgCommandRow">

                                                <td colspan="16" class="rgCommandCell">

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
                                                                    <asp:Button ID="btnCountryAdd" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                                </td>
                                                                <td align="right">
                                                                    <asp:Button runat="server" ID="btnCountryExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                                    <asp:Button runat="server" ID="btnCountryCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                                    <asp:Button runat="server" ID="btnCountryPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                    <asp:Button runat="server" ID="btnCountryPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                                    <asp:Button ID="btnCountryRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                            <telerik:GridTemplateColumn DataField="prvcod" FilterControlWidth="130px" SortExpression="prvcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter prvcod column"
                                                HeaderText="Code" UniqueName="prvcod" >
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprvcod" runat="server" Text='<%# Eval("prvcod") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtprvcod" Style="float: left" runat="server" MaxLength="15" Text='<%# Eval("prvcod") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVprvcod" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtprvcod"></asp:RequiredFieldValidator>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>


                                            <telerik:GridTemplateColumn DataField="prvnam" SortExpression="prvnam" FilterControlAltText="Filter prvnam column" FilterControlWidth="130px" CurrentFilterFunction="EqualTo" AutoPostBackOnFilter="true" AllowFiltering="true"
                                                HeaderText="Name" UniqueName="prvnam">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprvnam" runat="server" Text='<%# Eval("prvnam") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtprvnam" Style="float: left" runat="server" MaxLength="200" Text='<%# Eval("prvnam") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVprvnam" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtprvnam"></asp:RequiredFieldValidator></td>

                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="prvdsc" SortExpression="prvdsc" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter prvdsc column"
                                                HeaderText="Description" UniqueName="prvdsc">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblprvdsc" runat="server" Text='<%# Eval("prvdsc") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <table>
                                                        <tr>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <telerik:RadTextBox ID="txtprvdsc" Style="float: left" runat="server" MaxLength="200" Text='<%# Eval("prvdsc") %>'>
                                                                </telerik:RadTextBox>
                                                            </td>
                                                            <td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVprvdsc" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txtprvdsc"></asp:RequiredFieldValidator></td>

                                                        </tr>
                                                    </table>


                                                </EditItemTemplate>
                                            </telerik:GridTemplateColumn>
                                               <telerik:GridTemplateColumn DataField="tx1lbl" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx1lbl" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx1lbl column"
                                                    HeaderText="tax1 Label" UniqueName="tx1lbl">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx1lbl" runat="server" Text='<%# Eval("tx1lbl") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadTextBox ID="txttx1lbl" MaxLength="10" runat="server" Text='<%# Eval("tx1lbl") %>'>
                                                                    </telerik:RadTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx1lbl" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx1lbl"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx1val" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx1val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx1val column"
                                                    HeaderText="tax1 Value" UniqueName="tx1val">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx1val" runat="server" Text='<%# Eval("tx1val") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px;">
                                                                    <telerik:RadNumericTextBox ID="txttx1val" MaxLength="50" runat="server" Text='<%# Eval("tx1val") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx1val" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx1val"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx1enb" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx1enb" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter tx1enb column"
                                                    HeaderText="tax1 enable" UniqueName="tx1enb">
                                                    <ItemTemplate>
                                                        <asp:checkbox ID="cbtx1en" runat="server" Enabled="false" checked='<%# Eval("tx1enb") %>'></asp:checkbox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px;">
                                                                    <asp:checkbox ID="cbtx1enb" runat="server" checked='<%# Eval("tx1enb") %>'>
                                                                    </asp:checkbox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="tx2lbl" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx2lbl" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx2lbl column"
                                                    HeaderText="tax2 Label" UniqueName="tx2lbl">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx2lbl" runat="server" Text='<%# Eval("tx2lbl") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadTextBox ID="txttx2lbl" MaxLength="10" runat="server" Text='<%# Eval("tx2lbl") %>'>
                                                                    </telerik:RadTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx2lbl" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx2lbl"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx2val" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx2val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx2val column"
                                                    HeaderText="tax2 Value" UniqueName="tx2val">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx2val" runat="server" Text='<%# Eval("tx2val") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadNumericTextBox ID="txttx2val" MaxLength="50" runat="server" Text='<%# Eval("tx2val") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx2val" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx2val"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx2enb" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx2enb" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter tx2enb column"
                                                    HeaderText="tax2 enable" UniqueName="tx2enb">
                                                    <ItemTemplate>
                                                        <asp:checkbox ID="cbtx2en" runat="server" Enabled="false" checked='<%# Eval("tx2enb") %>'></asp:checkbox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <asp:checkbox ID="cbtx2enb" runat="server" checked='<%# Eval("tx2enb") %>'>
                                                                    </asp:checkbox>
                                                                </td
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="tx3lbl" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx3lbl" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx3lbl column"
                                                    HeaderText="tax3 Label" UniqueName="tx3lbl">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx3lbl" runat="server" Text='<%# Eval("tx3lbl") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadTextBox ID="txttx3lbl" MaxLength="10" runat="server" Text='<%# Eval("tx3lbl") %>'>
                                                                    </telerik:RadTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx3lbl" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx3lbl"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx3val" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx3val" CurrentFilterFunction="Contains" FilterControlAltText="Filter tx3val column"
                                                    HeaderText="tax3 Value" UniqueName="tx3val">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lbltx3val" runat="server" Text='<%# Eval("tx3val") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadNumericTextBox ID="txttx3val" MaxLength="50" runat="server" Text='<%# Eval("tx3val") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td
                                                                <%--<td style="width: 280px;border-bottom: 0px">
                                                                <asp:RequiredFieldValidator ID="RFVtx3val" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                                    ControlToValidate="txttx3val"></asp:RequiredFieldValidator></td>--%>
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            <telerik:GridTemplateColumn DataField="tx3enb" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="tx3enb" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter tx3enb column"
                                                    HeaderText="tax3 enable" UniqueName="tx3enb">
                                                    <ItemTemplate>
                                                        <asp:checkbox ID="cbtx3en" runat="server" Enabled="false" checked='<%# Eval("tx3enb") %>'></asp:checkbox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <asp:checkbox ID="cbtx3enb" runat="server" checked='<%# Eval("tx3enb") %>'>
                                                                    </asp:checkbox>
                                                                </td
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            <telerik:GridTemplateColumn DataField="defval" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="defval" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter defval column"
                                                    HeaderText="isdefault" UniqueName="defval">
                                                    <ItemTemplate>
                                                        <asp:checkbox ID="cboxdefval" runat="server" Enabled="false" checked='<%# Eval("defval") %>'></asp:checkbox>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 280px; border-bottom: 0px; padding-left: 0px">
                                                                    <asp:checkbox ID="cbdefval" runat="server" checked='<%# Eval("defval") %>'>
                                                                    </asp:checkbox>
                                                                </td
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>

                                            <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column"
                                                ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:" UniqueName="EditCity">
                                                <ItemStyle HorizontalAlign="Center" Width="43px" />
                                            </telerik:GridEditCommandColumn>
                                            <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Country Province record?"
                                                ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                                UniqueName="DeleteCity" ConfirmTextFormatString='Are you sure to delete Country Province record # {0}?'>
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
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Country Setup</h6>
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

                                                            <asp:Button ID="Button2" runat="server" CssClass="rgAdd" CommandName="InitInsert" AlternateText="Add" ToolTip="Add" />
                                                        </td>

                                                        <td align="right">
                                                            <asp:Button runat="server" ID="btnCountryCityExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnCountryCityCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnCountryCityPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                            <asp:Button runat="server" ID="btnCountryCityPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />
                                                            <asp:Button ID="btnCountryCityRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                        HeaderText="ID" UniqueName="recidd" ReadOnly="True" DataType="System.Int32"  Visible ="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="ctrcod" FilterControlWidth="130px" SortExpression="ctrcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="ctrcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblctrcod" runat="server" Text='<%# Eval("ctrcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtctrcod" Style="float: left" MaxLength="15" runat="server" Text='<%# Eval("ctrcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtctrcod"></asp:RequiredFieldValidator></td>

                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ctrnam" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctrnam" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Name" UniqueName="ctrnam">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("ctrnam") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtctrnam" MaxLength="200" runat="server" Text='<%# Eval("ctrnam") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtctrnam"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ctrsnm" Visible="false" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctrsnm" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Name 2" UniqueName="ctrsnm">
                                        <ItemTemplate>
                                            <asp:Label ID="lblName2" runat="server" Text='<%# Eval("ctrsnm") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtctrsnm" MaxLength="200" runat="server" Text='<%# Eval("ctrsnm") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ctrnat" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctrnat" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Nationality" UniqueName="ctrnat">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNationality" runat="server" Text='<%# Eval("ctrnat") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtctrnat" MaxLength="200" runat="server" Text='<%# Eval("ctrnat") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator61112" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtctrnat"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="ctrnts" Visible="false" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctrnts" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Nationality 2" UniqueName="ctrnts">
                                        <ItemTemplate>
                                            <asp:Label ID="lblNationality2" runat="server" Text='<%# Eval("ctrnts") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtctrnts" MaxLength="200" runat="server" Text='<%# Eval("ctrnts") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="clscod" Visible="false" SortExpression="clscod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Category" UniqueName="TemplateColumn001">
                                        <EditItemTemplate>

                                            <asp:HiddenField ID="hfCategorydllID" runat="server" Value='<%# Eval("ctrcat") %>' />
                                            <asp:HiddenField ID="hfCategorydllText" runat="server" Value='<%# Eval("ctrcattext") %>' />
                                            <telerik:RadComboBox ID="ddlCategory" runat="server"
                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelCategory" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelCategory" Height="200px">
                                                        <telerik:RadGrid ID="rGrdCategory4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdCategory4DDL_NeedDataSource"
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
                                                                <ClientEvents OnRowClick="OnCategoryRowClicked"></ClientEvents>
                                                            </ClientSettings>
                                                            <FilterMenu EnableImageSprites="False">
                                                            </FilterMenu>
                                                        </telerik:RadGrid>
                                                    </telerik:RadAjaxPanel>
                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelCategory" runat="server">
                                                    </telerik:RadAjaxLoadingPanel>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator122" runat="server" ErrorMessage="*" ForeColor="Red"
                                                ControlToValidate="ddlCategory"></asp:RequiredFieldValidator>


                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="clscod" Visible="false" SortExpression="clscod" FilterControlWidth="130px" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Group" UniqueName="TemplateColumn0201">

                                        <EditItemTemplate>

                                            <asp:HiddenField ID="hfGroupdllID" runat="server" Value='<%# Eval("ctrgrp") %>' />
                                            <asp:HiddenField ID="hfGroupdllText" runat="server" Value='<%# Eval("ctrgrptext") %>' />
                                            <telerik:RadComboBox ID="ddlGroup" runat="server"
                                                Width="260px" Height="200px" DropDownWidth="410px"
                                                EmptyMessage="Please select...">
                                                <ItemTemplate>
                                                    <telerik:RadAjaxPanel ID="RadAjaxPanelGroup" runat="server" Width="410px" LoadingPanelID="RadAjaxLoadingPanelGroup" Height="200px">
                                                        <telerik:RadGrid ID="rGrdGroup4DDL" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellSpacing="0" GridLines="None" OnNeedDataSource="rGrdGroup4DDL_NeedDataSource"
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
                                                                <ClientEvents OnRowClick="OnGroupRowClicked"></ClientEvents>
                                                            </ClientSettings>
                                                            <FilterMenu EnableImageSprites="False">
                                                            </FilterMenu>
                                                        </telerik:RadGrid>
                                                    </telerik:RadAjaxPanel>
                                                    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanelGroup" runat="server">
                                                    </telerik:RadAjaxLoadingPanel>
                                                </ItemTemplate>
                                                <Items>
                                                    <telerik:RadComboBoxItem runat="server" Text=""></telerik:RadComboBoxItem>
                                                </Items>
                                            </telerik:RadComboBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator122323" runat="server" ErrorMessage="*" ForeColor="Red"
                                                ControlToValidate="ddlGroup"></asp:RequiredFieldValidator>


                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                      <telerik:GridTemplateColumn DataField="ctramount" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="ctramount" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                                    HeaderText="Amount" UniqueName="ctramount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblctramount" runat="server" Text='<%# Convert.ToDouble(Eval("ctramount")).ToString("#####0.00") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <EditItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td style="width: 100px; border-bottom: 0px; padding-left: 0px">
                                                                    <telerik:RadNumericTextBox ID="txtctramount" MaxLength="50" runat="server" Text='<%# Eval("ctramount") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                             
                                                            </tr>
                                                        </table>
                                                    </EditItemTemplate>
                                                </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="defval" FilterControlWidth="130px" SortExpression="defval" AutoPostBackOnFilter="true" CurrentFilterFunction="EqualTo" FilterControlAltText="Filter defval column"
                                        HeaderText="Is Default" UniqueName="defval">
                                        <ItemTemplate>
                                                        <asp:Label ID="lbldefval" runat="server" Text='<%# Eval("defval") %>'></asp:Label>
                                                    </ItemTemplate>
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
                                   
                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditCountry"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Country?"
                                        ConfirmTextFields="recidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteCountry" ConfirmTextFormatString='Are you sure to delete Country record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Country record # "{0}":' CaptionDataField="recidd">
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                    <EditColumn ButtonType="ImageButton" />
                                </EditFormSettings>
                            </MasterTableView>

                        </telerik:RadGrid>
                    </div>
                </telerik:RadAjaxPanel>
                <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="BlackMetroTouch" Transparency="20">
                </telerik:RadAjaxLoadingPanel>
            </div>
        </fieldset>
    </div>
</asp:Content>
