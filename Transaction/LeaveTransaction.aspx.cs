using System;
using System.Collections;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Drawing;


public partial class LeaveTransaction : BasePage
{

    #region Startup

    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "LeaveTransaction";
        base.Page_Init(sender, e);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Cache.SetExpires(DateTime.Now.AddSeconds(-1));
        Response.Cache.SetNoStore();
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        RadGrid rGrdEmployees4DDL = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, ucEmployeeCard);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbEntryType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbLeaveType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEmployees4DDL, rCmbLeaveCode);

        RadGrid rGrdEntryTypes4DDL = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rGrdEntryTypes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rCmbLeaveType);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, rCmbLeaveCode);
        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtFromDate);
        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtToDate);
        //RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtNumberOfDays);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRemarks1);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRemarks2);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, txtRejoiningDate);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdEntryTypes4DDL, checkAirTicket);

        RadGrid rGrdLeaveTypes4DDL = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rGrdLeaveTypes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rCmbLeaveCode);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveTypes4DDL, rGrdLeaveCodes4DDL);

        //RadGrid rGrdLeaveCodes4DDL = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveCodes4DDL, rGrdLeaveCodes4DDL);
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdLeaveCodes4DDL, ucEmployeeLeaveBalance);

        /*
         * <telerik:AjaxUpdatedControl ControlID="rCmbEntryType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveType"   />
                    <telerik:AjaxUpdatedControl ControlID="rCmbLeaveCode"   />
                    <telerik:AjaxUpdatedControl ControlID="txtFromDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtToDate"   />
                    <telerik:AjaxUpdatedControl ControlID="txtNumberOfDays"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks1"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRemarks2"   />
                    <telerik:AjaxUpdatedControl ControlID="txtRejoiningDate"   />
                    <telerik:AjaxUpdatedControl ControlID="checkAirTicket"   />
         */

    }

    #endregion

    #region  Misc. Functions

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

    protected string getImagePathForTrue(string status)
    {
        if (status == "In Process")
            return "~/Images/16x16_process.png";
        if (status == "Sucessfull")
            return "~/Images/16x16_approved.png";
        if (status == "Rejected")
            return "~/Images/16x16_rejected.png";
        else
            return "";
    }

    protected string GetUserFullName(int EmployeeUserID, string EmployeeFullName)
    {
        if (EmployeeUserID == int.Parse(Session["_UserID"].ToString()))
            return "Self";
        else
            return EmployeeFullName;
    }

    protected bool isCompletedVisible(string Last_Status_ID)
    {
        clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

        switch (statusID)
        {
            case clsCommon.RequestStatus.Completed:
                return true;

            default:
                return false;
        }
    }

    protected bool isEditVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }

        }
        else
            return false;
    }

    protected bool isInProcessVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRecallVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Pending:
                    return true;

                case clsCommon.RequestStatus.InProcess:
                    return true;

                case clsCommon.RequestStatus.Approved:
                    return true;

                case clsCommon.RequestStatus.Canceled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isRejectedVisible(string Last_Status_ID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {
            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Rejected:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    protected bool isSubmitVisible(string Last_Status_ID, int EmployeeUserID)
    {
        if (!string.IsNullOrEmpty(Last_Status_ID))
        {

            clsCommon.RequestStatus statusID = (clsCommon.RequestStatus)int.Parse(Last_Status_ID);

            switch (statusID)
            {
                case clsCommon.RequestStatus.Initiated:
                    return true;

                case clsCommon.RequestStatus.Edited:
                    return true;

                case clsCommon.RequestStatus.Recalled:
                    return true;

                default:
                    return false;
            }
        }
        else
            return false;
    }

    private void ClearEntryType()
    {
        RadGrid grid_EntryType = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        if (grid_EntryType != null)
        {
            grid_EntryType.SelectedIndexes.Clear();
            rCmbEntryType.Text = "";
            rCmbEntryType.ClearSelection();
        }
        rCmbLeaveCode.Enabled = false;
    }

    private void clearForm()
    {
        ClearEntryType();
        ClearLeaveType();
        ClearLeaveCode();

        txtNumberOfDays.Text = "";
        txtRejoiningDate.Clear();
        txtFromDate.Clear();
        txtToDate.Clear();
        checkAirTicket.Checked = false;
        txtRemarks1.Text = "";
        txtRemarks2.Text = "";

        // refresh grids
        refreshGrids();
    }

    private void ClearLeaveCode()
    {
        RadGrid grid_LeaveCode = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        if (grid_LeaveCode != null)
        {
            grid_LeaveCode.SelectedIndexes.Clear();
            rCmbLeaveCode.Text = "";
            rCmbLeaveCode.ClearSelection();
        }
    }

    private void ClearLeaveType()
    {
        RadGrid grid_LeaveType = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        if (grid_LeaveType != null)
        {
            grid_LeaveType.SelectedIndexes.Clear();
            rCmbLeaveType.Text = "";
            rCmbLeaveType.ClearSelection();
            rCmbLeaveCode.Enabled = false;
        }
    }

    public string GetDate()
    {
        return System.DateTime.Now.ToString();
    }

    protected void RadAjaxPanel1_AjaxRequest(object sender, AjaxRequestEventArgs e)
    {
        refreshGrids();
    }

    public void refreshGrids()
    {
        gvSavedRequests.Rebind();
        gvSubmittedRequests.Rebind();
        gvPendingAppRequests.Rebind();
        gvApprovedRequests.Rebind();
    }

    #endregion

    #region Tab1 - New Requests

    protected void LoadEmpcard(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
    }

    protected void LoadLeavecard(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeLeaveBalance.LoadLeaveBalance(rCmbEmployee.Items[0].Value, rCmbLeaveType.Items[0].Value, rCmbLeaveCode.Items[0].Value);
        }
    }

    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            save(1);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
        }
    }

    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        save(2);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        clearForm();
        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
        }
    }

    protected void rGrdEmployees4DDL_DataBound(object sender, EventArgs e)
    {
        var grid = sender as RadGrid;

        foreach (GridItem item in grid.MasterTableView.Items)
        {
            if (item is GridDataItem)
            {
                GridDataItem dataItem = (GridDataItem)item;
                if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == Session["_UserID"].ToString())
                {
                    dataItem.Selected = true;
                    break;
                }
            }
        }
    }

    protected void rGrdEmployees4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //var editItem = ((sender as RadGrid).NamingContainer.NamingContainer.NamingContainer);// as GridEditFormInsertItem);
        //var ddlSubModule = editItem.FindControl("ddlSubModule") as RadComboBox;
        //var module = ((sender as RadGrid).SelectedValues as Telerik.Web.UI.DataKey)["id"];
        //BindSubModule(ddlSubModule, int.Parse(Convert.ToString(module)), "");

        LoadLeavecard(null, null);
        clearForm();
    }

    protected void rGrdEmployees4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        rCmbEmployee.ClearSelection();

        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);

        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];

        rCmbEmployee.Items[0].Value = Session["_UserID"].ToString();
        rCmbEmployee.Items[0].Text = "Self";
        rCmbEmployee.Text = "Self";

        if (rCmbEmployee.Items[0].Value != null)
        {
            ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);
            LoadLeavecard(null, null);


        }


        //  clearForm();
    }

    protected void rGrdEmployees4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        clearForm();
    }

    protected void rGrdEntryTypes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        //if entry is selected then enable from date, to date, ticket requested 
        //If entry is selected then disable rejoining date, number of days 
        //If encashment is selected then disable from date, to date, rejoining date. 
        //If encashment is selected then enable number of days, ticket requested 
        //If adjustment is selected then disable from date, to date, rejoining date, ticket requested 
        //If adjustment is selected then enable number of days
        if (e.CommandName.ToLower() == "sort")
            return;

        RadGrid grid = (sender as RadGrid);
        if (grid != null)
        {
            if (grid.SelectedValues != null)
            {
                string entryType = Convert.ToString((grid.SelectedValues as Telerik.Web.UI.DataKey)["Text"]);
                ClearLeaveType();
                ClearLeaveCode();
                switch (entryType)
                {
                    case "Entry":
                        txtFromDate.Enabled = true;
                        txtToDate.Enabled = true;
                        checkAirTicket.Enabled = true;

                        txtRejoiningDate.Enabled = false;
                        txtNumberOfDays.Enabled = false;
                        break;
                    case "Encashment":
                        txtFromDate.Enabled = false;
                        txtToDate.Enabled = false;
                        txtRejoiningDate.Enabled = false;

                        checkAirTicket.Enabled = true;
                        txtNumberOfDays.Enabled = true;
                        break;
                    case "Adjustment":
                        txtFromDate.Enabled = false;
                        txtToDate.Enabled = false;
                        txtRejoiningDate.Enabled = false;
                        checkAirTicket.Enabled = false;

                        txtNumberOfDays.Enabled = true;
                        break;
                }
            }
        }

    }

    protected void rGrdEntryTypes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsCommon.DDLValueSet_GetByDDLID(Constraints.DropDownLists.LeaveEntryType, -1, 1).Tables[0];
    }

    protected void rGrdLeaveCodes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        LoadLeavecard(null, null);
    }

    protected void rGrdLeaveCodes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var leaveTypeID = rCmbLeaveType.Items[0].Value;

        Hashtable ht = new Hashtable();
        ht.Add("@LeaveType", leaveTypeID);

        RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveCodes", ht).Tables[0];
        LoadLeavecard(null, null);
    }

    protected void rGrdLeaveTypes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName.ToLower() == "sort")
            return;

        RadGrid grid = (sender as RadGrid);
        if (grid != null)
        {
            if (!string.IsNullOrEmpty(rCmbLeaveType.Items[0].Value))
            {
                var leveTypeID = Convert.ToInt32(rCmbLeaveType.Items[0].Value);
                this.GetLeaveCodes((int)leveTypeID);
                ClearLeaveCode();
                rCmbLeaveCode.Enabled = true;
            }
        }
    }

    protected void rGrdLeaveTypes4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveTypes").Tables[0];
    }

    protected void txtFromDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if (txtFromDate.SelectedDate != null)
        {
            txtToDate.MinDate = (DateTime)txtFromDate.SelectedDate;
            txtToDate.SelectedDate = (DateTime)txtFromDate.SelectedDate;
            txtRejoiningDate.SelectedDate = ((DateTime)txtToDate.SelectedDate).AddDays(1);
            txtNumberOfDays.Text = ((((DateTime)txtToDate.SelectedDate) - ((DateTime)txtFromDate.SelectedDate)).TotalDays + 1).ToString();
        }
    }

    protected void txtToDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        if (txtToDate.SelectedDate != null)
        {
            txtRejoiningDate.SelectedDate = ((DateTime)txtToDate.SelectedDate).AddDays(1);
            txtNumberOfDays.Text = ((((DateTime)txtToDate.SelectedDate) - ((DateTime)txtFromDate.SelectedDate)).TotalDays + 1).ToString();
        }
    }

    private string GetCalendarID(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);
        //rCmbCalander.ClearSelection();
        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();

        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarID;
        empcalendarID = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][0].ToString();
        return empcalendarID;
    }

    private string GetCalendarCode(string empID)
    {
        //Hashtable ht = new Hashtable();
        //ht.Add("@EmployeeID", strID);

        //rCmbCalander.ClearSelection();

        //RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        //grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0];
        ////grid.Rebind();

        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", empID);
        string empcalendarCode;
        empcalendarCode = clsDAL.GetDataSet("sp_Payroll_Get_Calander_By_Employee", ht).Tables[0].Rows[0][1].ToString();
        return empcalendarCode;
    }

    private void GetLeaveCodes(int leaveTypeID = 2)
    {
        #region Leave Code

        rCmbLeaveCode.ClearSelection();

        Hashtable ht = new Hashtable();
        ht.Add("@LeaveType", leaveTypeID);

        RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveCodes", ht).Tables[0];
        grid.Rebind();

        #endregion Leave Code
    }

    public string ValidateLeaveTransaction()
    {
        string errorStr = string.Empty;

        if (string.IsNullOrEmpty(rCmbEmployee.Text))
            errorStr += "Employee Required <br/>";

        if (string.IsNullOrEmpty(rCmbEntryType.Text))
            errorStr += "Entry Type Required <br/>";

        if (string.IsNullOrEmpty(rCmbLeaveType.Text))
            errorStr += "Leave Type Required <br/>";

        if (string.IsNullOrEmpty(rCmbLeaveCode.Text))
            errorStr += "Leave Code Required <br/>";

        if (rCmbEntryType.Text == "Entry")
        {
            if (txtFromDate.SelectedDate == null)
                errorStr += "From Date Required <br/>";

            if (txtToDate.SelectedDate == null)
                errorStr += "To Date Required <br/>";
        }

        if (string.IsNullOrEmpty(txtNumberOfDays.Text))
            errorStr += "Number of Days Required <br/>";

        return errorStr;
    }

    private void save(int saveStatus)
    {
        try
        {
            string requiredStr = ValidateLeaveTransaction();
            if (string.IsNullOrEmpty(requiredStr))
            {
                Hashtable ht = new Hashtable();

                ht.Add("@FormTypeID", Request.QueryString["FormType"]);
                ht.Add("@EmployeeUserID", rCmbEmployee.Items[0].Value);

                ht.Add("@entryType", rCmbEntryType.Items[0].Value);
                ht.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
                ht.Add("@employeeCode", rCmbEmployee.Items[0].Text);
                ht.Add("@entryDate", DateTime.Now);
                ht.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
                ht.Add("@leaveTypeCode", rCmbLeaveType.Items[0].Text);
                ht.Add("@LeaveCodeIDD", rCmbLeaveCode.Items[0].Value);
                ht.Add("@LeaveCode", rCmbLeaveCode.Items[0].Text);
                //ht.Add("@calendarIDD", rCmbCalander.Items[0].Value);
                ht.Add("@calendarIDD", GetCalendarID(rCmbEmployee.Items[0].Value));

                //            ht.Add("@calendarCode", rCmbCalander.Items[0].Text);

                ht.Add("@calendarCode", GetCalendarCode(rCmbEmployee.Items[0].Value));

                ht.Add("@fromDate", txtFromDate.SelectedDate);
                ht.Add("@toDate", txtToDate.SelectedDate);
                ht.Add("@rejoiningDate", txtRejoiningDate.SelectedDate);
                ht.Add("@calendarDays", 0);
                ht.Add("@weekendDays", 0);
                ht.Add("@holidays", 0);
                ht.Add("@leavedays", 0);
                ht.Add("@remarks1", txtRemarks1.Text);
                ht.Add("@remarks2", txtRemarks2.Text);
                ht.Add("@airTicket", checkAirTicket.Checked);
                ht.Add("@NumberOfDays", txtNumberOfDays.Text);

                ht.Add("@SaveStatus", saveStatus);
                ht.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                ht.Add("@LeaveTransactionID", 0);

                string nextnumber;
                Hashtable ht_nextnumber = new Hashtable();
                ht_nextnumber.Add("@seqcod", "REIMBURSEMENT");
                ht_nextnumber.Add("@TRX_ID", null);

                nextnumber = clsDAL.ExecuteNonQuery(Constraints.sp_User_Get_Next_Number, ht_nextnumber, "@TRX_ID", System.Data.SqlDbType.NVarChar, 255) as string;

                int Recidd = 0;
                Recidd = int.Parse(clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_LeaveTransaction, ht, "@LeaveTransactionID", System.Data.SqlDbType.Int, 0).ToString());

                if (Recidd > 0)
                {
                    #region Add attachments

                    Hashtable ht_attachments = new Hashtable();

                    if (ruDocument.UploadedFiles.Count > 0)
                    {
                        for (int l = 0; l <= ruDocument.UploadedFiles.Count - 1; l++)
                        {
                            var currentFile = ruDocument.UploadedFiles[l];
                            var filedsc = currentFile.GetFieldValue("TextBox").ToString();
                            var filename = ruDocument.UploadedFiles[l].FileName;
                            var imgStream = currentFile.InputStream;
                            int imgLen = int.Parse(currentFile.ContentLength.ToString());

                            byte[] imgBinaryData = new byte[imgLen];
                            int n = imgStream.Read(imgBinaryData, 0, imgLen);

                            // Image to Base64 string and save in database
                            // Convert byte[] to Base64 String

                            string base64String = Convert.ToBase64String(imgBinaryData);

                            ht_attachments = new Hashtable();
                            ht_attachments.Add("@transactionname", "PayrollLeave");
                            ht_attachments.Add("@transactionidd", Recidd);
                            ht_attachments.Add("@transactioncode", nextnumber);
                            ht_attachments.Add("@description", filedsc);

                            ht_attachments["@File"] = imgBinaryData;
                            ht_attachments["@Filetype"] = currentFile.ContentType;
                            ht_attachments["@Filename"] = filename;

                            clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                        }
                    }

                    #endregion

                    int wfid;
                    Hashtable ht_message = new Hashtable();
                    ht_message.Add("@FormTypeID", Request.QueryString["FormType"]);
                    ht_message.Add("@SubmittedByUserID", (string)Session["_UserID"]);
                    ht_message.Add("@WorkFlowMasterID", "0");

                    wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

                    if (saveStatus == 2 && wfid > 0)
                    {
                        ht = null;
                        ht = new Hashtable();
                        ht.Add("@SuggestionID", Recidd);
                        ht.Add("@RedirectURL", Request.Url.AbsoluteUri);
                        clsCommon.SendMail(3, ht);
                    }
                    clearForm();
                    if (wfid == 0)
                    {
                        ShowClientMessage("New clscommTransaction ID: " + Recidd.ToString() + " is Saved but cannot be Sumbitted due to missing workflow.", MessageType.Warning);
                    }
                    else if (wfid > 0 && saveStatus == 2)
                    {
                        ShowClientMessage("New Transaction ID: " + Recidd.ToString() + " is Saved and submitted.", MessageType.Success);
                    }
                    else if (wfid > 0 && saveStatus == 1)
                    {
                        ShowClientMessage("New Transaction ID: " + Recidd.ToString() + " is Saved and can be submitted from tab.", MessageType.Info);
                    }
                }
                else
                {
                    if(Recidd == -1)
                        ShowClientMessage("Leave request already exist in selected dated.", MessageType.Error);
                    else
                        ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
            }
            else
            {
                ShowClientMessage(requiredStr, MessageType.Error);
            }
        }
        catch (Exception ex)
        {
            ShowClientMessage("Sorry! some error has occurred. Please try again later.<br/>" + ex.Message, MessageType.Error);
            Logger.LogError(ex);
        }
    }

    #endregion

    #region Tab2 - Saved Requests

    //protected void gvSavedRequests_SortCommand(object sender, GridSortCommandEventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
    //}

    protected void gvSavedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            DataTable dt = clsDAL.GetDataSet("sp_User_Get_All_LeaveTransaction", ht).Tables[0];
            dt.TableName = "eb_prllevtrx";
            gvSavedRequests.DataSource = dt;
            gvSavedRequests.DataMember = "eb_prllevtrx";
        }
    }

    protected void gvSavedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);

                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                    break;
                }
        }
    }

    protected void gvSavedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {
        if (e.CommandName == "Print")
        {
            string requestId = clsEncryption.EncryptData(e.CommandArgument.ToString());
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("LeaveTrxEntryByID");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + requestId + "','" + rptName + "');", true);
        }

        if (e.CommandName == "Delete")
        {
            Hashtable ht_delete = new Hashtable();
            ht_delete.Add("@requestid", e.CommandArgument.ToString());
            clsDAL.ExecuteNonQuery("sp_User_Delete_Leave", ht_delete);
            ShowClientMessage("Transaction ID:" + e.CommandArgument.ToString() + "  is Deleted.", MessageType.Success);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
        }

        if (e.CommandName == "Submit")
        {
            int wfid;
            Hashtable ht_message = new Hashtable();
            ht_message.Add("@FormTypeID", Request.QueryString["FormType"]);
            ht_message.Add("@SubmittedbyUserID", (string)Session["_UserID"]);
            ht_message.Add("@WorkFlowMasterID", 0);

            wfid = int.Parse(clsDAL.ExecuteNonQuery_admin(Constraints.get_WorkFlowID, ht_message, "@WorkFlowMasterID", System.Data.SqlDbType.Int, 0).ToString());

            if (wfid == 0)
            {
                ShowClientMessage("Transaction cannot be submitted due to missing workflow", MessageType.Error);
            }
            else if (wfid > 0)
            {
                Hashtable ht_submit = new Hashtable();

                ht_submit.Add("@FormTypeID", Request.QueryString["FormType"]);
                ht_submit.Add("@LeaveTransactionID", e.CommandArgument.ToString());
                ht_submit.Add("@SubmittedByUserID", (string)Session["_UserID"]);

                clsDAL.ExecuteNonQuery("sp_User_Submit_LeaveTransaction", ht_submit);

                gvSavedRequests.Rebind();

                Hashtable ht_email = new Hashtable();
                ht_email.Add("LeaveTransactionID", e.CommandArgument.ToString());

                DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Info_4_Email", ht_email).Tables[0];

                if ((null != dt) && dt.Rows.Count > 0)
                {
                    string sBody = "";
                    string htmlEmailFormat = Server.MapPath("~/EmailTemplates/NotifyApplicantApproverEmail.htm");

                    //sBody = File.ReadAllText(htmlEmailFormat);
                    //sBody = sBody.Replace("<%UserFullName%>", dt.Rows[0]["MainApproverFullName"].ToString());
                    //sBody = sBody.Replace("<%ID%>", Request.QueryString["LeaveTransactionID"]);
                    ////sBody = sBody.Replace("<%FullName%>", txtFirstName.Text + txtMiddleName.Text + txtLastName.Text);
                    ////sBody = sBody.Replace("<%Position%>", rCmbPosition.SelectedValue.ToString());
                    ////sBody = sBody.Replace("<%Remarks%>", rTxtRemarks.Text);
                    //sBody = sBody.Replace("<%RedirectURL%>", Request.Url.AbsoluteUri);
                    //clsCommon.SendMail(sBody, dt.Rows[0]["Email"].ToString(), ConfigurationManager.AppSettings["EMAIL_ACC"], "A request is pending for your approval.");
                }

                ShowClientMessage("New Transaction ID: is submitted for approval.", MessageType.Success);
                clearForm();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "RefreshGrid", "refreshGrid2();", true);
            }
        }
    }

    protected void gvSavedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.DataMember == "eb_prllevtrx")
        {
            ImageButton imgBtnEdit = (ImageButton)e.Item.FindControl("imgBtnEdit");
            imgBtnEdit.Attributes["onclick"] = String.Format("return ShowEditForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], false);

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowSavedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            //ImageButton imgBtnOrgChart = (ImageButton)e.Item.FindControl("imgBtnOrgChart");
            //imgBtnOrgChart.Attributes["onclick"] = String.Format("return ShowOrgChart('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex);
        }
    }

    protected void gvSavedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {

    }

    #endregion

    #region Tab3 - Submitted Requests

    protected void gvSubmittedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;
        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();
                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);

                    break;
                }
        }
    }

    protected void gvSubmittedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void gvSubmittedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            ImageButton imgBtnRecall = (ImageButton)e.Item.FindControl("imgBtnRecall");
            if (imgBtnRecall != null)
                imgBtnRecall.Attributes["onclick"] = String.Format("return ShowRecallForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowSubmittedViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);

        }
    }

    protected void gvSubmittedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvSubmittedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);
        DataTable dt = clsDAL.GetDataSet("sp_User_Get_submitted_LeaveTransaction", ht).Tables[0];
        gvSubmittedRequests.DataSource = dt;
    }

    #endregion

    #region Tab4 - Pending Approval

    protected void gvPendingAppRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab4');", true);

                    break;
                }
        }
    }

    protected void gvPendingAppRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void gvPendingAppRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            ImageButton imgBtnApprove = (ImageButton)e.Item.FindControl("imgBtnApprove");
            if (imgBtnApprove != null)
            {
                imgBtnApprove.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
                    e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
                    e.Item.ItemIndex,
                    e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
                    Request.QueryString["FormType"]);
            }

            ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
            if (imgBtnView != null)
                imgBtnView.Attributes["onclick"] = String.Format("return ShowPendingViewForm('{0}','{1}','{2}','{3}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"], e.Item.ItemIndex, Request.QueryString["FormType"], true);
        }
    }

    protected void gvPendingAppRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@ApproverUserID", Session["_UserID"].ToString());
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_For_Approval", ht).Tables[0];
            gvPendingAppRequests.DataSource = dt;
        }
    }

    protected void gvPendingAppRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {
            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }

    }

    #endregion

    #region Tab5 - Approval Requests

    protected void gvApprovedRequests_DetailTableDataBind(object sender, GridDetailTableDataBindEventArgs e)
    {
        GridDataItem dataItem = (GridDataItem)e.DetailTableView.ParentItem;

        switch (e.DetailTableView.Name)
        {
            case "RequestStatuses":
                {
                    string ID = dataItem.GetDataKeyValue("RequestID").ToString();

                    Hashtable ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", ID);
                    DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_Statuses", ht).Tables[0];
                    dt.TableName = "tbl_LeaveTransaction_Status";
                    e.DetailTableView.DataSource = dt;
                    e.DetailTableView.DataMember = "tbl_LeaveTransaction_Status";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab5');", true);

                    break;
                }
        }
    }

    protected void gvApprovedRequests_ItemCommand(object sender, GridCommandEventArgs e)
    {

    }

    protected void gvApprovedRequests_ItemCreated(object sender, GridItemEventArgs e)
    {
        ImageButton imgBtnView = (ImageButton)e.Item.FindControl("imgBtnView");
        if (imgBtnView != null)
        {
            imgBtnView.Attributes["onclick"] = String.Format("return ShowApproveForm('{0}','{1}','{2}','{3}');",
                               e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestID"],
                               e.Item.ItemIndex,
                               e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["RequestStatusID"],
                               Request.QueryString["FormType"]);
        }
    }

    protected void gvApprovedRequests_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem && e.Item.OwnerTableView.Name == "RequestStatuses")
        {

            Color col_current = System.Drawing.ColorTranslator.FromHtml("#FF0090");
            Color col_pending = System.Drawing.ColorTranslator.FromHtml("#F7A29C");
            Color col_approved = System.Drawing.ColorTranslator.FromHtml("#49F27C");
            Color col_returned = System.Drawing.ColorTranslator.FromHtml("#49de94");
            Color col_rejected = System.Drawing.ColorTranslator.FromHtml("#FF0090 ");
            Color col_revised = System.Drawing.ColorTranslator.FromHtml("#A7B3DB");
            Color col_initiated = System.Drawing.ColorTranslator.FromHtml("#FAF873");
            Color col_completed = System.Drawing.ColorTranslator.FromHtml("#006400");
            Color col_completed_fore = System.Drawing.ColorTranslator.FromHtml("#fffaf0");

            GridDataItem dataItem = e.Item as GridDataItem;
            TableCell cell = (TableCell)dataItem["colRequestStatus"];

            if (dataItem["colRequestStatus"].Text == "Pending")
                cell.BackColor = col_pending;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Approved")
                cell.BackColor = col_approved;

            if (dataItem["colRequestStatus"].Text == "returned")
                cell.BackColor = col_returned;

            if (dataItem["colRequestStatus"].Text == "Revised")
                cell.BackColor = col_revised;

            if (dataItem["colRequestStatus"].Text == "Initiated")
                cell.BackColor = col_initiated;

            if (dataItem["colRequestStatus"].Text == "Completed")
            {
                cell.BackColor = col_completed;
                cell.ForeColor = col_completed_fore;
            }

            if (dataItem["collevelcolor"].Text == "True")
                cell.BackColor = col_current;
        }
    }

    protected void gvApprovedRequests_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_approved_LeaveTransaction", ht).Tables[0];
            gvApprovedRequests.DataSource = dt;
        }
    }

    #endregion


}

