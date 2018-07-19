using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_BranchSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // base page initialization
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Branch Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // branch grid data loading and binding
    protected void gvBranch_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Branches", htSearchParams).Tables[0];
        dt.TableName = "BranchMaster";
        gvBranch.DataSource = dt;
        gvBranch.DataMember = "BranchMaster";
    }

    // grid update command
    protected void gvBranch_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Branch(ref e, "Update");
    }

    // grid delete command
    protected void gvBranch_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("brnidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Branch", ht);
        }
    }

    // client side validation function for branch form
    public void ValidateBranch(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtbrncod = (editForm.FindControl("txtbrncod") as RadTextBox);
        RadTextBox txtbrnds1 = (editForm.FindControl("txtbrnds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateBranch('" +
                txtbrncod.ClientID + "','" +
                txtbrnds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateBranch('" +
                txtbrncod.ClientID + "','" +
                txtbrnds1.ClientID
                + "')");
        }
    }

    // set form input controls for insert/update
    protected void gvBranch_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "BranchMaster")
            {
                ValidateBranch(e);
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

    // clear grid input form for insert/update
    // exporting functions
    protected void gvBranch_ItemCommand(object sender, GridCommandEventArgs e)
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

            grid.MasterTableView.GetColumn("EditBranch").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBranch").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditBranch").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBranch").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditBranch").Visible = false;
            grid.MasterTableView.GetColumn("DeleteBranch").Visible = false;
            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnPrint = (Button)e.Item.FindControl("btnBranchPrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    String qstring = clsEncryption.EncryptData(ddlPrintOptions.Text);
                    //btnPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    // grid insert command
    protected void gvBranch_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Branch(ref e, "Insert");
    }

    // insert/update function
    private void Insert_or_Update_Branch(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "BranchMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@brnidd"] = (int)editedItem.GetDataKeyValue("brnidd");
                }
                newValues["@brncod"] = (editedItem.FindControl("txtbrnCod") as RadTextBox).Text.Trim();
                newValues["@brnds1"] = (editedItem.FindControl("txtbrnds1") as RadTextBox).Text;
                newValues["@brnds2"] = (editedItem.FindControl("txtbrnds2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Branch", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Branch", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }
                else
                {
                ShowClientMessage("Branch saved successfully.", MessageType.Success);
                gvBranch.Rebind();
                }
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Branch. Reason: " + ex.Message, MessageType.Error);
            e.Canceled = true;
        }
    }

    // display message on client side
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

    // detail grid data binding
    protected void gvBranch_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
    }

    // get value of grid boolean column
    protected bool CheckBoxValue(object value)
    {
        if (Convert.ToString(value) == "1") return true;
        else if (Convert.ToString(value) == "True") return true;
        else if (Convert.ToString(value) == "true") return true;

        return false;
    }

    // get image for grid boolean column
    protected string getImagePathForTrue(bool flag)
    {
        if (flag)
            return "~/Images/16x16_tick.png";
        else
            return "";
    }

    // grid header formating for exporting
    protected void gvBranch_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}