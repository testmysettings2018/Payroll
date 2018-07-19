using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_DayType : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // initializing base values
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "DayType Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // master grid data loading and binding function
    protected void gvDayType_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_GetDayTypes", htSearchParams).Tables[0];
        dt.TableName = "DayTypeMaster";
        gvDayType.DataSource = dt;
        gvDayType.DataMember = "DayTypeMaster";
    }

    // grid insert/update command
    protected void gvDayType_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_DayType(ref e, "Update");
    }

    // grid delete command
    protected void gvDayType_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("recidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_DayType", ht);
        }
    }

    // client side form input validation function
    public void ValidateDayType(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtdaycod = (editForm.FindControl("txtdaycod") as RadTextBox);
        RadTextBox txtdayds1 = (editForm.FindControl("txtdayds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateDayType('" +
                txtdaycod.ClientID + "','" +
                txtdayds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateDayType('" +
                txtdaycod.ClientID + "','" +
                txtdayds1.ClientID
                + "')");
        }
    }

    // set form input controls for insert/update
    protected void gvDayType_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "DayTypeMaster")
            {
                ValidateDayType(e);
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

    // clear input form fields and handle exporting functions
    protected void gvDayType_ItemCommand(object sender, GridCommandEventArgs e)
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

            grid.MasterTableView.GetColumn("daywkd").Visible = false;
            grid.MasterTableView.GetColumn("dayrel").Visible = false;
            grid.MasterTableView.GetColumn("daygov").Visible = false;
            grid.MasterTableView.GetColumn("EditDayType").Visible = false;
            grid.MasterTableView.GetColumn("DeleteDayType").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("daywkd").Visible = false;
            grid.MasterTableView.GetColumn("dayrel").Visible = false;
            grid.MasterTableView.GetColumn("daygov").Visible = false;
            grid.MasterTableView.GetColumn("EditDayType").Visible = false;
            grid.MasterTableView.GetColumn("DeleteDayType").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("daywkd").Visible = false;
            grid.MasterTableView.GetColumn("dayrel").Visible = false;
            grid.MasterTableView.GetColumn("daygov").Visible = false;
            grid.MasterTableView.GetColumn("EditDayType").Visible = false;
            grid.MasterTableView.GetColumn("DeleteDayType").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnDayTypePrint");
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

    // insert/update command
    protected void gvDayType_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_DayType(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_DayType(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "DayTypeMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@recidd"] = (int)editedItem.GetDataKeyValue("recidd");
                }
                newValues["@daycod"] = (editedItem.FindControl("txtdaycod") as RadTextBox).Text.Trim();
                newValues["@dayds1"] = (editedItem.FindControl("txtdayds1") as RadTextBox).Text;
                newValues["@dayds2"] = (editedItem.FindControl("txtdayds2") as RadTextBox).Text;
                newValues["@daywkd"] = (editedItem.FindControl("chkbxdaywkd") as CheckBox).Checked;
                newValues["@daygov"] = (editedItem.FindControl("chkbxdaygov") as CheckBox).Checked;
                newValues["@dayrel"] = (editedItem.FindControl("chkbxdayrel") as CheckBox).Checked; 

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_Insert_DayType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_DayType", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Day Type saved successfully.", MessageType.Success);
                gvDayType.Rebind();
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert DayType. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }
    
    // display client side messages
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

    // detail table data bind
    protected void gvDayType_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
    }

    // get boolean column values for grid
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for boolean grid columns
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }
    
    // header settings for export functions
    protected void gvDayType_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }

}