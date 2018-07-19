<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="ReligionSetup.aspx.cs" Inherits="Payroll_ReligionSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnReligionExcelExport") >= 0 ||
                  args.get_eventTarget().indexOf("LinkReligionExcelExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnReligionCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkReligionCsvExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnReligionPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("LinkReligionPdfExport") >= 0 ||
                      args.get_eventTarget().indexOf("btnReligionPrint") >= 0 ||
                      args.get_eventTarget().indexOf("LinkbtnReligionPrint") >= 0 ||
                      args.get_eventTarget().indexOf("btnReligionRefresh") >= 0 ||
                      args.get_eventTarget().indexOf("LinkReligionRefresh") >= 0
                  ) {
                    args.set_enableAjax(false);
                }
            }
            function ValidateReligion(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Religion Code Required.<br/>';
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
                        <telerik:RadGrid ID="gvReligion" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvReligion_InsertCommand"
                            OnNeedDataSource="gvReligion_NeedDataSource" PageSize="20" OnDeleteCommand="gvReligion_DeleteCommand"
                            OnUpdateCommand="gvReligion_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvReligion_ItemDataBound"
                            OnItemCommand="gvReligion_ItemCommand" OnDetailTableDataBind="gvReligion_DetailTableDataBind"
                             OnItemCreated="gvReligion_ItemCreated">
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
                            <MasterTableView CommandItemDisplay="Top" AutoGenerateColumns="False" DataKeyNames="relidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                </DetailTables>
                                <CommandItemTemplate>
                                    <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Religion Setup</h6>
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
                                                            <asp:Button runat="server" ID="btnReligionExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />

                                                            <asp:Button runat="server" ID="btnReligionCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />

                                                            <asp:Button runat="server" ID="btnReligionPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                            <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                            <asp:Button runat="server" ID="btnReligionPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />

                                                            <asp:Button ID="btnReligionRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind" AlternateText="Refresh" ToolTip="Refresh" />
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
                                    <telerik:GridBoundColumn DataField="relidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="relidd" ReadOnly="True" DataType="System.Int32" Visible ="false">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="relcod" FilterControlWidth="130px" SortExpression="relcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="relcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblrelcod" runat="server" Text='<%# Eval("relcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtrelcod" MaxLength="15" Style="float: left" runat="server" Text='<%# Eval("relcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtrelcod"></asp:RequiredFieldValidator></td>

                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="relds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="relds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="relds1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("relds1") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtrelds1" runat="server" MaxLength="50" Text='<%# Eval("relds1") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtrelds1"></asp:RequiredFieldValidator>
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="relds2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="relds2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description 2" UniqueName="relds2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("relds2") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom: 0px; padding-left: 0px">
                                                        <telerik:RadTextBox ID="txtrelds2" runat="server" MaxLength="50" Text='<%# Eval("relds2") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom: 0px; padding-left: 0px">
                                                </tr>
                                            </table>
                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditReligion"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Religion?"
                                        ConfirmTextFields="relidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteReligion" ConfirmTextFormatString='Are you sure to delete Religion record # "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Religion record # "{0}":' CaptionDataField="relidd">
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

