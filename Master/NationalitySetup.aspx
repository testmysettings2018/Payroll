<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/UserMasterPage.master" AutoEventWireup="true" CodeFile="NationalitySetup.aspx.cs" Inherits="Payroll_NationalitySetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ControlContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="mainContentPlaceHolder" runat="Server">
    <telerik:RadCodeBlock ID="rcb1" runat="server">
        <script type="text/javascript">
            function onRequestStart(sender, args) {
                if (args.get_eventTarget().indexOf("btnNationalityExcelExport") >= 0|| 
                    args.get_eventTarget().indexOf("LinkNationalityExcelExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnNationalityCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkNationalityCsvExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnNationalityPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("LinkNationalityPdfExport") >= 0 ||
                        args.get_eventTarget().indexOf("btnNationalityPrint") >= 0 ||
                        args.get_eventTarget().indexOf("LinkbtnNationalityPrint") >= 0 ||
                        args.get_eventTarget().indexOf("btnNationalityRefresh") >= 0 ||
                        args.get_eventTarget().indexOf("LinkNationalityRefresh") >= 0
                    ) {
                    args.set_enableAjax(false);
                }
            }
            function ValidateNationality(txtbxCodeId, txtDescriptionId) {
                var str = '';
                if ($('#' + txtbxCodeId).val() == undefined || $('#' + txtbxCodeId).val() == "") {
                    str = 'Nationality Code Required.<br/>';
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
                        <telerik:RadGrid ID="gvNationality" runat="server" AllowPaging="True" AllowSorting="True" AllowFilteringByColumn="True"
                            AutoGenerateColumns="False" CellSpacing="0" GridLines="None" OnInsertCommand="gvNationality_InsertCommand"
                            OnNeedDataSource="gvNationality_NeedDataSource" PageSize="20" OnDeleteCommand="gvNationality_DeleteCommand"
                            OnUpdateCommand="gvNationality_UpdateCommand" ShowStatusBar="false" OnItemDataBound="gvNationality_ItemDataBound"
                            OnItemCommand="gvNationality_ItemCommand" OnDetailTableDataBind="gvNationality_DetailTableDataBind" OnGridExporting="gvNationality_GridExporting1" OnItemCreated="gvNationality_ItemCreated" OnExcelMLExportStylesCreated="gvNationality_ExcelMLExportStylesCreated">
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
                            <MasterTableView CommandItemDisplay="Top" CommandItemSettings-ShowExportToCsvButton="true" CommandItemSettings-ShowExportToExcelButton="true" CommandItemSettings-ShowExportToPdfButton="true" CommandItemSettings-ShowExportToWordButton="true" AutoGenerateColumns="False" DataKeyNames="natidd"
                                InsertItemPageIndexAction="ShowItemOnCurrentPage" EditMode="InPlace">
                                <DetailTables>
                                </DetailTables>
                                 <CommandItemTemplate>
                                 <div class="title">
                                        <img src="../../images/icons/dark/list.png" alt="" class="titleIcon" /><h6>Nationality Setup</h6>
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
                                                            <asp:Button runat="server" ID="btnNationalityExcelExport" CssClass="rgExportExcel" ClientIDMode="Static" CommandName="ExportToExcel" AlternateText="Excel" ToolTip="Excel" />
                                                            
                                                            <asp:Button runat="server" ID="btnNationalityCsvExport" CssClass="rgExportCsv" ClientIDMode="Static" CommandName="ExportToCsv" AlternateText="Csv" ToolTip="Csv" />
                                                            
                                                            <asp:Button runat="server" ID="btnNationalityPdfExport" CssClass="rgExportPdf" ClientIDMode="Static" CommandName="ExportToPdf" AlternateText="Pdf" ToolTip="Pdf" />
                                                                                                                     <telerik:RadComboBox ID="ddlPrintOptions" Style="margin: 0px 5px" runat="server" Width="250px" DropDownWidth="250px"></telerik:RadComboBox>

                                                            <asp:Button runat="server" ID="btnNationalityPrint" CssClass="rgPrint" ClientIDMode="Static" CommandName="Print" AlternateText="Print" ToolTip="Print" />                                                          
                                                            <asp:Button ID="btnNationalityRefresh" CssClass="rgRefresh" runat="server" CommandName="Rebind"   AlternateText="Refresh" ToolTip="Refresh"  />
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
                                    <telerik:GridBoundColumn DataField="natidd" FilterControlAltText="Filter column column"
                                        HeaderText="ID" UniqueName="natidd" ReadOnly="True" DataType="System.Int32">
                                        <ColumnValidationSettings>
                                            <ModelErrorMessage Text=""></ModelErrorMessage>
                                        </ColumnValidationSettings>
                                        <FilterTemplate>
                                            <strong>Search</strong>
                                        </FilterTemplate>
                                    </telerik:GridBoundColumn>

                                    <telerik:GridTemplateColumn DataField="natcod" FilterControlWidth="130px" SortExpression="natcod" AutoPostBackOnFilter="true" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn0 column"
                                        HeaderText="Code" UniqueName="natcod">
                                        <ItemTemplate>
                                            <asp:Label ID="lblnatcod" runat="server" Text='<%# Eval("natcod") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 180px; border-bottom:0px; padding-left:0px">
                                                        <telerik:RadTextBox ID="txtnatcod" Style="float: left" runat="server" Text='<%# Eval("natcod") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="border-bottom:0px; padding-left:0px">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                            ControlToValidate="txtnatcod"></asp:RequiredFieldValidator></td>
                                                  
                                                </tr>
                                            </table>

                                        </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="natds1" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="natds1" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description" UniqueName="natds1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Eval("natds1") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom:0px; padding-left:0px"> <telerik:RadTextBox ID="txtnatds1" runat="server" Text='<%# Eval("natds1") %>'>
                                            </telerik:RadTextBox>
                                          </td>
                                                    <td style="border-bottom:0px; padding-left:0px">   <asp:RequiredFieldValidator ID="RequiredFieldValidator6111" Style="float: left" runat="server" ErrorMessage="*" ForeColor="Red" Display="Dynamic"
                                                ControlToValidate="txtnatds1"></asp:RequiredFieldValidator>
                                       </tr>
                                            </table> </EditItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn DataField="natds2" FilterControlWidth="130px" AutoPostBackOnFilter="true" SortExpression="natds2" CurrentFilterFunction="Contains" FilterControlAltText="Filter TemplateColumn2 column"
                                        HeaderText="Description 2" UniqueName="natds2">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription2" runat="server" Text='<%# Eval("natds2") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <table>
                                                <tr>
                                                    <td style="width: 330px; border-bottom:0px; padding-left:0px"> <telerik:RadTextBox ID="txtnatds2" runat="server" Text='<%# Eval("natds2") %>'>
                                            </telerik:RadTextBox>
                                          </td>
                                                    <td style="border-bottom:0px; padding-left:0px">   
                                       </tr>
                                            </table> </EditItemTemplate>
                                    </telerik:GridTemplateColumn>

                                    <telerik:GridEditCommandColumn FilterControlAltText="Filter EditCommandColumn column" UniqueName="EditNationality"
                                        ButtonType="ImageButton" EditFormHeaderTextFormat="{0}:">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridEditCommandColumn>
                                    <telerik:GridButtonColumn ButtonType="ImageButton" CommandName="Delete" ConfirmText="Are you sure to delete this Nationality?"
                                        ConfirmTextFields="natidd" ConfirmTitle="Delete" FilterControlAltText="Filter column6 column"
                                        UniqueName="DeleteNationality" ConfirmTextFormatString='Are you sure to delete Nationality record "{0}"?'>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridButtonColumn>
                                </Columns>
                                <EditFormSettings CaptionFormatString='Edit Details for Nationality "{0}":' CaptionDataField="natidd">
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
