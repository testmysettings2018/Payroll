using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_EmployerSetup : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Employer Maintenance Form";
        base.Page_Init(sender, e);
    }

    // page loading function
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    // employer grid data loading and binding
    protected void gvEmployer_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_All_Employers", htSearchParams).Tables[0];
        dt.TableName = "EmployerMaster";
        gvEmployer.DataSource = dt;
        gvEmployer.DataMember = "EmployerMaster";
    }

    // grid update commnad
    protected void gvEmployer_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employer(ref e, "Update");
    }

    // grid delete command
    protected void gvEmployer_DeleteCommand(object sender, GridCommandEventArgs e)
    {
        int ID = (int)((GridDataItem)e.Item).GetDataKeyValue("empidd");

        if (ID > 0)
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ID", ID);

            clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Employer", ht);
        }
    }

    // client side validatioin function for form input controls
    public void ValidateEmployer(GridItemEventArgs e)
    {
        GridEditableItem editForm = (GridEditableItem)e.Item;
        ImageButton update = (ImageButton)editForm.FindControl("UpdateButton");
        ImageButton insert = (ImageButton)editForm.FindControl("PerformInsertButton");

        RadTextBox txtempcod = (editForm.FindControl("txtempcod") as RadTextBox);
        RadTextBox txtempds1 = (editForm.FindControl("txtempds1") as RadTextBox);

        if (update != null)
        {
            update.Attributes.Add("onclick", "return ValidateEmployer('" +
                txtempcod.ClientID + "','" +
                txtempds1.ClientID
                + "')");
        }
        if (insert != null)
        {
            insert.Attributes.Add("onclick", "return ValidateEmployer('" +
                txtempcod.ClientID + "','" +
                txtempds1.ClientID
                + "')");
        }
    }

    // form controls setting for insert/udpate
    protected void gvEmployer_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridEditableItem && e.Item.IsInEditMode)
        {
            if (e.Item.OwnerTableView.DataMember == "EmployerMaster")
            {
                ValidateEmployer(e);
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

    // clear form input controls for insert/update
    // grid exporting functions
    protected void gvEmployer_ItemCommand(object sender, GridCommandEventArgs e)
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

            grid.MasterTableView.GetColumn("EditEmployer").Visible = false;
            grid.MasterTableView.GetColumn("DeleteEmployer").Visible = false;

            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditEmployer").Visible = false;
            grid.MasterTableView.GetColumn("DeleteEmployer").Visible = false;

            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);

            grid.MasterTableView.GetColumn("EditEmployer").Visible = false;
            grid.MasterTableView.GetColumn("DeleteEmployer").Visible = false;

            grid.MasterTableView.ExportToPdf();
        }
        if (e.CommandName == "Print")
        {
            Button btnActionPrint = (Button)e.Item.FindControl("btnEmployerPrint");
            RadComboBox ddlPrintOptions = (RadComboBox)e.Item.FindControl("ddlPrintOptions");
            if (ddlPrintOptions != null)
            {
                if (!string.IsNullOrEmpty(ddlPrintOptions.Text))
                {
                    String qstring = clsEncryption.EncryptData(ddlPrintOptions.Text);
                    //btnActionPrint.Attributes["onclick"] = String.Format("return ShowReport('{0}');", qstring);
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + qstring + "');", true);
                }
            }
        }
    }

    // grid insert command
    protected void gvEmployer_InsertCommand(object sender, GridCommandEventArgs e)
    {
        Insert_or_Update_Employer(ref e, "Insert");
    }

    // insert/udpate function
    private void Insert_or_Update_Employer(ref GridCommandEventArgs e, string operation)
    {
        GridEditableItem editedItem = e.Item as GridEditableItem;
        try
        {
            if (e.Item.OwnerTableView.DataMember == "EmployerMaster")
            {
                //Insert new values
                Hashtable newValues = new Hashtable();

                if (operation == "Update")
                {
                    newValues["@empidd"] = (int)editedItem.GetDataKeyValue("empidd");
                }
                newValues["@empcod"] = (editedItem.FindControl("txtempCod") as RadTextBox).Text.Trim();
                newValues["@empds1"] = (editedItem.FindControl("txtempds1") as RadTextBox).Text;
                newValues["@empds2"] = (editedItem.FindControl("txtempds2") as RadTextBox).Text;

                newValues["@DBMessage"] = "";

                string DBMessage = "";

                if (operation == "Insert")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Insert_Employer", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }
                else if (operation == "Update")
                {
                    DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Employer", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    ShowClientMessage(DBMessage, MessageType.Error);
                    e.Canceled = true;
                }

                ShowClientMessage("Employer saved successfully.", MessageType.Success);
                gvEmployer.Rebind();
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Unable to update/insert Employer. Reason: " + ex.Message, MessageType.Error);
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

    // datail table data bidning
    protected void gvEmployer_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
    }

    // get value for grid boolean column
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

    // grid header export formating
    protected void gvEmployer_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (exporting && e.Item.ItemType == Telerik.Web.UI.GridItemType.FilteringItem)
        {
            e.Item.Visible = false;
        }
    }
}