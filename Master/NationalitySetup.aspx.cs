using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_NationalitySetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    /// <summary>   Event handler. Called by Page for initialise events. </summary>
    ///
    /// <remarks>   22, 13/09/2013. </remarks>
    ///
    /// <param name="sender">   Source of the event. </param>
    /// <param name="e">        Event information. </param>
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Nationality Maintenance Form";
        base.Page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void gvNationality_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Nationalities", htSearchParams).Tables[0];
        dt.TableName = "NationalityMaster";
        gvNationality.DataSource = dt;
        gvNationality.DataMember = "NationalityMaster";
    }

    protected void gvNationality_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Nationality(ref e, "Update");
    }

    protected void gvNationality_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("natidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Nationality", ht);
        }
    }
    public void ValidateNationality(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtnatcod = (editForm.FindControl("txtnatcod") as RadTextBox);
        RadTextBox txtnatds1 = (editForm.FindControl("txtnatds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateNationality('" +
                txtnatcod.ClientID + "','" +
                txtnatds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateNationality('" +
                txtnatcod.ClientID + "','" +
                txtnatds1.ClientID
                + "')");
        }
    }

    protected void gvNationality_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "NationalityMaster")
            {
                ValidateNationality(e);
            }
        }
        if (e.Item is GridCommandItem)
        {
            GridCommandItem commandItem = (GridCommandItem)e.Item;
            RadComboBox ddlPrintOptions = (RadComboBox)commandItem.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                Hashtable ht_Reports = new Hashtable();
                ht_Reports.Add("@userid", Session["_UserID"].ToString());
                ht_Reports.Add("@formtypeid", Request.QueryString["FormType"]);     
                DataTable dt_Reports = clsDAL.GetDataSet_admin("sp_Payroll_Get_Reports", ht_Reports).Tables[0];
                if (ddlPrintOptions != null)
                {
                    ddlPrintOptions.DataSource = dt_Reports;
                    ddlPrintOptions.DataTextField = "reportname";
                    ddlPrintOptions.DataValueField = "idd";
                    ddlPrintOptions.DataBind();
                    ddlPrintOptions.SelectedIndex = 0;
                }
            }
        }
    }
    protected void gvNationality_ItemCommand(object sender, GridCommandEventArgs e)
    {
        RadGrid grid = (sender as RadGrid);
        if (e.CommandName == RadGrid.InitInsertCommandName)
        {
            grid.MasterTableView.ClearEditItems();

        }
        if (e.CommandName == RadGrid.EditCommandName)
        {
            e.Item.OwnerTableView.IsItemInserted = false;

        }
        if (e.CommandName == RadGrid.RebindGridCommandName)
        {
            grid.MasterTableView.ClearEditItems();
            e.Item.OwnerTableView.IsItemInserted = false;

            if (htSearchParams != null)
                htSearchParams.Clear();
        }
        if (e.CommandName == RadGrid.ExportToExcelCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNationality").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNationality").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNationality").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNationality").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditNationality").Visible = false;
            grid.MasterTableView.GetColumn("DeleteNationality").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnNationalityPrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    string reportName = ddlPrintOptions.Text;
                    String qstring = clsEncryption.EncryptData(reportName);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    protected void gvNationality_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Nationality(ref e, "Insert");
    }

    private void Insert_or_Update_Nationality(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "NationalityMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@natidd"] = (int)editedItem.GetDataKeyValue("natidd");
                }
                newValues["@natcod"] = (editedItem.FindControl("txtnatCod") as RadTextBox).Text;
                newValues["@natds1"] = (editedItem.FindControl("txtnatds1") as RadTextBox).Text;
                newValues["@natds2"] = (editedItem.FindControl("txtnatds2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Nationality", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Nationality", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }

                ShowClientMessage("Nationality saved successfully.", MessageType.Success);
                gvNationality.Rebind();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Nationality. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }
    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showError('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showSuccess('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showWarning('" + message + "', '" + redirect + "', 5000)", true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", "showInfo('" + message + "', '" + redirect + "', 5000)", true);
        }
    }

    protected void gvNationality_GridExporting(object source, GridExportingArgs e)
    {

    }

    protected void gvNationality_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
    }
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }
    protected void gvNationality_GridExporting1(object sender, GridExportingArgs e)
    {
        switch (e.ExportType)
        {
            case ExportType.Excel:
                //    string css = "<style> body { border:solid 0.1pt #CCCCC; }</style>";
                //e.ExportOutput = e.ExportOutput.Replace("</head>", css + "</head>");   
                break;
            case ExportType.ExcelML:
                //do something with the e.ExportOutput value     
                break;
            case ExportType.Word:
                //do something with the e.ExportOutput value       
                break;
            case ExportType.Csv:
                //do something with the e.ExportOutput value    
                break;
            case ExportType.Pdf:
                //you can't change the output here - use the PdfExporting event instead   
                break;
        }
    }
    protected void gvNationality_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
    protected void gvNationality_ExcelMLExportStylesCreated(object sender, Telerik.Web.UI.GridExcelBuilder.GridExportExcelMLStyleCreatedArgs e)
    {
        //// To set the Excel cell borders style
        //BorderStylesCollection borders = new BorderStylesCollection();
        //BorderStyles borderStyle = null;
        //for (int i = 1; i <= 4; i++)
        //{
        //    borderStyle = new BorderStyles();
        //    borderStyle.PositionType = (PositionType)i;
        //    borderStyle.Color = System.Drawing.Color.Black;
        //    borderStyle.LineStyle = LineStyle.Continuous;
        //    borderStyle.Weight = 1.0;
        //    borders.Add(borderStyle);
        //}

        //// styles have to set for export excel
        //foreach (StyleElement style in e.Styles)
        //{
        //    //For Header style - background color
        //    if (style.Id == "headerStyle")
        //    {
        //        style.InteriorStyle.Pattern = InteriorPatternType.Solid;
        //        style.InteriorStyle.Color = System.Drawing.Color.Gray;
        //    }
        //    ////For alternate row style - background color
        //    //if (style.Id == "alternatingItemStyle" || style.Id == "alternatingPriceItemStyle" || style.Id == "alternatingPercentItemStyle" || style.Id == "alternatingDateItemStyle")
        //    //{
        //    //    style.InteriorStyle.Pattern = InteriorPatternType.Solid;
        //    //    style.InteriorStyle.Color = System.Drawing.Color.LightGray;
        //    //}
        //      //      if
        //      //(
        //      //style.Id.Contains("itemStyle") || style.Id == "priceItemStyle" || style.Id == "percentItemStyle" || style.Id == "dateItemStyle")
        //      //      {
        //      //          style.InteriorStyle.Pattern = InteriorPatternType.Solid;
        //      //          style.InteriorStyle.Color = System.Drawing.Color.White;
        //      //      }

        //    // for each cell border styles
        //    foreach (BorderStyles border in borders)
        //    {
        //        style.Borders.Add(border);
        //    }

        //    // Each cell text wrapping
        //    style.AlignmentElement.Attributes.Add("ss:WrapText", "1");
        //}
    }
}