using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class AttendanceEntryConfiguration : BasePage
{

    // base page initializing
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "AttendanceEntryConfiguration";
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
        DataTable dtConfigs = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_AttEntConfigs", htt).Tables[0];
        if (dtConfigs.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(dtConfigs.Rows[0]["btnsubtxt"].ToString()))
            {
                txtbtnsubtxt.Text = dtConfigs.Rows[0]["btnsubtxt"].ToString();
            }
            if (!string.IsNullOrEmpty(dtConfigs.Rows[0]["btnsubmsg"].ToString()))
            {
                txtbtnsubmsg.Text = dtConfigs.Rows[0]["btnsubmsg"].ToString();
            }
            if (!string.IsNullOrEmpty(dtConfigs.Rows[0]["copyNvalue"].ToString()))
            {
                txtcopyNvalue.Text = dtConfigs.Rows[0]["copyNvalue"].ToString();
            }
            if (dtConfigs.Rows[0]["isddlposvis"].ToString()=="True")
            {
                cbxisddlposvis.Checked = true;
            }
            if (dtConfigs.Rows[0]["copypremvalues"].ToString() == "True")
            {
                cbxcpypremval.Checked = true;
            }
            if (dtConfigs.Rows[0]["copyhrtvalues"].ToString() == "True")
            {
                cbxcpyhrtval.Checked = true;
            }

            if (dtConfigs.Rows[0]["allowedit"].ToString() == "True")
            {
                cbxallowedit.Checked = true;
            }
            if (dtConfigs.Rows[0]["isprthisreq"].ToString() == "True")
            {
                cbxisprthisreq.Checked = true;
            }
            if (dtConfigs.Rows[0]["ishrthisreq"].ToString() == "True")
            {
                cbxishrthisreq.Checked = true;
            }
            if (dtConfigs.Rows[0]["ishrtprthisreq"].ToString() == "True")
            {
                cbxishrtprthisreq.Checked = true;
            }

            if (dtConfigs.Rows[0]["isFriOff"].ToString() == "True")
            {
                cbxisfrioff.Checked = true;
            }
            if (dtConfigs.Rows[0]["isSatOff"].ToString() == "True")
            {
                cbxissatoff.Checked = true;
            }
            if (dtConfigs.Rows[0]["isSunOff"].ToString() == "True")
            {
                cbxissunoff.Checked = true;
            }
        }
    }

    //function to display messages
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
            newValues["@btnsubtxt"] = txtbtnsubtxt.Text;
            newValues["@btnsubmsg"] = txtbtnsubmsg.Text;

            newValues["@isddlposvis"] = cbxisddlposvis.Checked;
            newValues["@cpypremval"] = cbxcpypremval.Checked;
            newValues["@cpyhrtval"] = cbxcpyhrtval.Checked;
            newValues["@copyNvalue"] = txtcopyNvalue.Text == "" ? 0 : Convert.ToInt32(txtcopyNvalue.Text);

            newValues["@allowedit"] = cbxallowedit.Checked;
            newValues["@isprthisreq"] = cbxisprthisreq.Checked;
            newValues["@ishrthisreq"] = cbxishrthisreq.Checked;
            newValues["@ishrtprthisreq"] = cbxishrthisreq.Checked;

            newValues["@isFriOff"] = cbxisprthisreq.Checked;
            newValues["@isSatOff"] = cbxishrthisreq.Checked;
            newValues["@isSunOff"] = cbxishrthisreq.Checked;

            newValues["@DBMessage"] = "";

            string DBMessage = "";

            DBMessage = clsDAL.ExecuteNonQuery_payroll("sp_payroll_InsertUpdate_EmpAttConfiguration", newValues, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

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
        Response.Redirect("~/Payroll/Setup/AttendanceEntryConfiguration.aspx");
    }
}