using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class ReimbursmentT2Configuration : BasePage
{

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "ReimbursmentT2Configuration";
        base.Page_Init(sender, e);
    }

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRecords();
        }
    }

    // data loading function from database 
    public void LoadRecords()
    {
        Hashtable htt = new Hashtable();
        DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_ReimbT2Configs", htt).Tables[0];
        if (dtConfigs.Rows.Count > 0)
        {
            if (dtConfigs.Rows[0]["isprjvis"].ToString() == "True")
            {
                cbxisprjvis.Checked = true;
            }
            if (dtConfigs.Rows[0]["isvndrvis"].ToString() == "True")
            {
                cbxisvndrvis.Checked = true;
            }
            if (dtConfigs.Rows[0]["isexphisreq"].ToString() == "True")
            {
                cbxisexphisreq.Checked = true;
            }

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


    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Hashtable newValues = new Hashtable();

            newValues["@isprjvis"] = cbxisprjvis.Checked;
            newValues["@isvndrvis"] = cbxisvndrvis.Checked;
            newValues["@isexphisreq"] = cbxisexphisreq.Checked;
            newValues["@DBMessage"] = "";

            string DBMessage = "";

            DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_InsertUpdate_ReimbursmentT2Configuration", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

            if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
            {
                ShowClientMessage(DBMessage, MessageType.Error);
            }
            else
            {
                ShowClientMessage("Attendance entry configuration saved/updated successfully.", MessageType.Success);
            }

        }
        catch (Exception ex)
        {
                ShowClientMessage("Unable to update/insert configuration record.", MessageType.Error);
        }

    }
    protected void rbtnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Payroll/Setup/ReimbursmentT2Configuration.aspx");
    }
}