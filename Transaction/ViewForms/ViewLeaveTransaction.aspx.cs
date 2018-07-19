using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using Telerik.Web.UI;

public partial class Payroll_Transaction_ViewForms_ViewLeaveTransaction : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string LeaveTransactionID = " ";
        if (Request.QueryString["LeaveTransactionID"] != null)
        {
            LeaveTransactionID = Request.QueryString["LeaveTransactionID"];
        }

        if (!IsPostBack)
        {
            bindCombos();
            if (!string.IsNullOrEmpty(Request.QueryString["LeaveTransactionID"]))
            {
                bindRecord();
                bindAttach();
            }
            ShowReadOnlyPage(this.Controls);
        }
    }

    private void bindCombos()
    {
        if (null != Session["_UserID"] && !string.IsNullOrEmpty(Request.QueryString["FormType"]))
        {
            RadGrid grid;

            #region Entry Type

            rCmbEntryType.ClearSelection();

            grid = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
            grid.DataSource = clsCommon.DDLValueSet_GetByDDLID(Constraints.DropDownLists.LeaveEntryType, -1, 1).Tables[0];
            grid.Rebind();

            #endregion Entry Type

            #region Leave Type

            rCmbLeaveType.ClearSelection();

            grid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_LeaveTypes").Tables[0];
            grid.Rebind();

            #endregion Leave Type

            #region Calendar

            rCmbCalander.ClearSelection();

            grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_Calanders").Tables[0];
            grid.Rebind();

            #endregion Calendar

            #region Fill Employees

            rCmbEmployee.ClearSelection();

            Hashtable ht = new Hashtable();
            ht.Add("@UserID", Session["_UserID"].ToString());
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
            grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];
            grid.Rebind();


            rCmbEmployee_SelectedIndexChanged(null, null);

            #endregion Fill Employees
        }
    }

    protected void bindRecord()
    {
        try
        {
            Hashtable ht = new Hashtable();
            ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
            DataTable dt = clsDAL.GetDataSet("sp_User_Get_LeaveTransaction_ByID_4_Edit", ht).Tables[0];

            if (dt != null)
            {
                if (dt.Rows.Count > 0)
                {
                    this.SetEmployee(Convert.ToString(dt.Rows[0]["EmployeeUserID"]));

                    this.SetEntryType(Convert.ToString(dt.Rows[0]["EntryType"]));
                    this.SetCalander(Convert.ToString(dt.Rows[0]["calendarIDD"]));
                    this.SetLeaveType(Convert.ToString(dt.Rows[0]["leaveTypeIDD"]));

                    this.GetLeaveCodes(int.Parse(Convert.ToString(dt.Rows[0]["leaveTypeIDD"])));

                    this.SetLeaveCode(Convert.ToString(dt.Rows[0]["LeaveCodeIDD"]));

                    txtRemarks1.Text = Convert.ToString(dt.Rows[0]["Remarks1"]);
                    txtRemarks2.Text = Convert.ToString(dt.Rows[0]["Remarks2"]);
                    lblTransactionNumber.Text = Convert.ToString(dt.Rows[0]["transactionNumber"]);

                    if (Convert.ToString(dt.Rows[0]["EntryType"]) == "Entry")
                    {
                        if (dt.Rows[0]["fromDate"] == "NULL")
                            txtFromDate.SelectedDate = (DateTime)dt.Rows[0]["fromDate"];
                        if (dt.Rows[0]["toDate"] == "NULL")
                            txtToDate.SelectedDate = (DateTime)dt.Rows[0]["toDate"];
                        if (dt.Rows[0]["rejoiningDate"] == "NULL")
                            txtRejoiningDate.SelectedDate = (DateTime)dt.Rows[0]["rejoiningDate"];
                    }

                    checkAirTicket.Checked = (bool)dt.Rows[0]["airTicket"];
                    txtNumberOfDays.Text = Convert.ToString(dt.Rows[0]["NumberOfDays"]);

                    hfTransactionNo.Value = Convert.ToString(dt.Rows[0]["transactionNumber"]);
                    rCmbEmployee_SelectedIndexChanged(null, null);
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void bindAttach()
    {
        try
        {
            Hashtable ht_attach = new Hashtable();
            ht_attach.Add("@ID", Request.QueryString["LeaveTransactionID"]);
            ht_attach.Add("@transactioname", "PayrollLeave");

            DataTable dt_attach = clsDAL.GetDataSet("sp_User_Get_attach_ByID", ht_attach).Tables[0];

            if (dt_attach != null && dt_attach.Rows.Count > 0)
            {
                ltrNoResults.Visible = false;
                Repeater1.Visible = true;
                Repeater1.DataSource = dt_attach;
                Repeater1.DataBind();
            }
            else
            {
                ltrNoResults.Visible = true;
                Repeater1.Visible = false;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }
    protected void rBtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            save(1);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
        }
    }

    private void save(int saveStatus)
    {
        try
        {
            Hashtable ht = new Hashtable();

            ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
            ht.Add("@EmployeeUserID", rCmbEmployee.Items[0].Value);
            ht.Add("@isRecalled", bool.Parse(Request.QueryString["isRecalled"]));
            ht.Add("@SaveStatus", saveStatus);


            ht.Add("@entryType", rCmbEntryType.Items[0].Value);
            ht.Add("@employeeIDD", rCmbEmployee.Items[0].Value);
            ht.Add("@employeeCode", rCmbEmployee.Items[0].Text);
            ht.Add("@entryDate", DateTime.Now);
            ht.Add("@leaveTypeIDD", rCmbLeaveType.Items[0].Value);
            ht.Add("@leaveTypeCode", rCmbLeaveType.Items[0].Text);
            ht.Add("@LeaveCodeIDD", rCmbLeaveCode.Items[0].Value);
            ht.Add("@LeaveCode", rCmbLeaveCode.Items[0].Text);
            ht.Add("@calendarIDD", rCmbCalander.Items[0].Value);
            ht.Add("@calendarCode", rCmbCalander.Items[0].Text);
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
            ht.Add("@FormTypeID", Request.QueryString["FormType"]);

            ht.Add("@SubmittedByUserID", Convert.ToInt16((string)Session["_UserID"]));
            ht.Add("@DBMessage", "");

            {
                string DBMessage = clsDAL.ExecuteNonQuery("sp_User_Update_LeaveTransaction", ht, "@DBMessage", System.Data.SqlDbType.NVarChar, 255) as string;

                // start
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
                        ht_attachments.Add("@transactionidd", Request.QueryString["LeaveTransactionID"]);
                        ht_attachments.Add("@transactioncode", hfTransactionNo.Value);
                        ht_attachments.Add("@description", filedsc);

                        ht_attachments["@File"] = imgBinaryData;
                        ht_attachments["@Filetype"] = currentFile.ContentType;
                        ht_attachments["@Filename"] = filename;


                        clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                    }
                }
                //end
                if (saveStatus == 2)
                {
                    ht = null;
                    ht = new Hashtable();
                    ht.Add("@LeaveTransactionID", Request.QueryString["LeaveTransactionID"]);
                    ht.Add("@RedirectURL", Request.Url.AbsoluteUri);

                    clsCommon.SendMail(3, ht);
                }

                if ((null != DBMessage) && DBMessage.Contains("ERROR:"))
                {
                    //ShowClientMessage("Sorry! some error has occurred. Please try again later.", MessageType.Error);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "CloseAndRebind();", true);
                }
            }
        }
        catch (Exception ex)
        {
            //ShowClientMessage(ex.Message, MessageType.Error);
        }
    }

    protected void rBtnSaveAndSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            save(2);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex);
            throw ex;
        }
    }

    private void ShowReadOnlyPage(ControlCollection objCtrl)
    {
        try
        {

            this.Title = "View Leave Transaction Details";
            foreach (Control c in objCtrl)
            {
                System.Diagnostics.Debug.WriteLine(c.GetType().ToString());
                DisableControl(c);
                foreach (Control ctrl in c.Controls)
                {
                    System.Diagnostics.Debug.WriteLine(ctrl.GetType().ToString());
                    DisableControl(ctrl);
                    if (ctrl.Controls.Count > 0)
                    {
                        ShowReadOnlyPage(ctrl.Controls);
                    }
                }
            }

            rBtnSave.Visible = false;
            rBtnSaveAndSubmit.Visible = false;

        }
        catch (Exception)
        {
            throw;
        }
    }


    private void DisableControl(Control objC)
    {
        try
        {
            if (objC is Telerik.Web.UI.RadTextBox)
            {
                Telerik.Web.UI.RadTextBox obj = (Telerik.Web.UI.RadTextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadComboBox)
            {
                Telerik.Web.UI.RadComboBox obj = (Telerik.Web.UI.RadComboBox)objC;
                obj.Enabled = false;
                obj.BackColor = Color.White;
                obj.ForeColor = Color.Black;
            }

            if (objC is Telerik.Web.UI.RadNumericTextBox)
            {
                Telerik.Web.UI.RadNumericTextBox obj = (Telerik.Web.UI.RadNumericTextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadDatePicker)
            {
                Telerik.Web.UI.RadDatePicker obj = (Telerik.Web.UI.RadDatePicker)objC;
                obj.Enabled = false;
            }

            if (objC is Telerik.Web.UI.DatePickingCalendar)
            {
                Telerik.Web.UI.DatePickingCalendar obj = (Telerik.Web.UI.DatePickingCalendar)objC;
                obj.Enabled = false;
            }

            if (objC is System.Web.UI.WebControls.RadioButtonList)
            {
                System.Web.UI.WebControls.RadioButtonList obj = (System.Web.UI.WebControls.RadioButtonList)objC;
                obj.Enabled = false;
            }

            if (objC is System.Web.UI.WebControls.TextBox)
            {
                System.Web.UI.WebControls.TextBox obj = (System.Web.UI.WebControls.TextBox)objC;
                obj.ReadOnly = true;
            }

            if (objC is Telerik.Web.UI.RadUpload)
            {
                Telerik.Web.UI.RadUpload obj = (Telerik.Web.UI.RadUpload)objC;
                obj.Enabled = false;
            }

            if (objC is Telerik.Web.UI.RadButton)
            {
                Telerik.Web.UI.RadButton obj = (Telerik.Web.UI.RadButton)objC;
                obj.ReadOnly = true;
            }
        }
        catch (Exception)
        {
            throw;
        }
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        if (rCmbEmployee.Items[0].Value != null)
        {
            //ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);

            this.GetLeaveBalance(rCmbEmployee.Items[0].Value);
        }
    }

    private void SetEmployee(string strID)
    {
        RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbEmployee.Items[0].Value = strID;
                        rCmbEmployee.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
                        rCmbEmployee.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();

                        break;
                    }
                }
            }
    }
    private void SetEntryType(string strID)
    {
        RadGrid grid = rCmbEntryType.Items[0].FindControl("rGrdEntryTypes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Value"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbEntryType.Items[0].Value = strID;
                        rCmbEntryType.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Text"].ToString();
                        rCmbEntryType.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["Text"].ToString();

                        break;
                    }
                }
            }
    }
    private void SetCalander(string strID)
    {
        RadGrid grid = rCmbCalander.Items[0].FindControl("rGrdCalanders4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdcli"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbCalander.Items[0].Value = strID;
                        rCmbCalander.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdclc"].ToString();
                        rCmbCalander.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["grdclc"].ToString();

                        break;
                    }
                }
            }
    }
    private void SetLeaveType(string strID)
    {
        RadGrid grid = rCmbLeaveType.Items[0].FindControl("rGrdLeaveTypes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbLeaveType.Items[0].Value = strID;
                        rCmbLeaveType.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levtypcod"].ToString();
                        rCmbLeaveType.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levtypcod"].ToString();

                        break;
                    }
                }
            }
    }
    private void SetLeaveCode(string strID)
    {
        RadGrid grid = rCmbLeaveCode.Items[0].FindControl("rGrdLeaveCodes4DDL") as RadGrid;
        if (grid != null)
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["recidd"].ToString() == strID)
                    {
                        dataItem.Selected = true;

                        rCmbLeaveCode.Items[0].Value = strID;
                        rCmbLeaveCode.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levcod"].ToString();
                        rCmbLeaveCode.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["levcod"].ToString();

                        break;
                    }
                }
            }
    }

    protected void rGrdEmployees4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        rCmbEmployee_SelectedIndexChanged(null, null);
    }

    protected void rGrdLeaveTypes4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        var leveTypeID = ((sender as RadGrid).SelectedValues as Telerik.Web.UI.DataKey)["recidd"];
        this.GetLeaveCodes((int)leveTypeID);
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
    private void GetLeaveBalance(string strID)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@EmployeeID", strID);
        ht.Add("@LeaveType", strID);
        ht.Add("@LeaveCode", strID);
        var dsEmployee = clsDAL.GetDataSet("sp_Get_User_LeaveTransaction_Balance", ht);

        if (dsEmployee != null)
        {
            if (dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
            {
                literalBroughtForward.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["BroughtForward"]);
                literalAvailableBalance.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["AvailableBalance"]);
                literalLVBalanceAOD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LVBalanceAOD"]);
                literalUnpostedLeaves.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["UnpostedLeaves"]);
                literalCalandarDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["CalandarDays"]);
                literalWeekends.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["Weekends"]);
                literalRestDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["RestDays"]);
                literalPublicHolidays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["PublicHolidays"]);
                literalActualLeaveDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["ActualLeaveDays"]);
                literalLeaveTakenYTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenYTD"]);
                literalLeaveTakenLTD.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenLTD"]);
                literalLeaveTakenAOY.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["LeaveTakenAOY"]);
                literalAdjustedDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["AdjustedDays"]);
                literalExcessDays.Text = Convert.ToString(dsEmployee.Tables[0].Rows[0]["ExcessDays"]);
            }
        }
    }

    protected void Repeater1_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
    {
        Int32 idd = Convert.ToInt32(e.CommandArgument.ToString());
        if (e.CommandName == "Download")
        {
            try
            {
                using (SqlConnection myConnection = new SqlConnection(
                    ConfigurationManager.ConnectionStrings["eb_payroll"].ConnectionString))
                {
                    const string SQL = @"SELECT idd,documentname ,description, documenttype,document FROM dbo.eb_prlattach 
                                        WHERE idd = @IDD";
                    SqlCommand myCommand = new SqlCommand(SQL, myConnection);
                    myCommand.Parameters.AddWithValue("@IDD", idd);

                    myConnection.Open();
                    SqlDataReader myReader = myCommand.ExecuteReader();

                    RadAjaxManager manager = new RadAjaxManager();
                    manager.EnableAJAX = false;

                    if (myReader.Read())
                    {
                        Response.Clear();
                        Response.ContentType = myReader["documenttype"].ToString();
                        Response.AddHeader("Content-Disposition", "attachment;filename=" + myReader["documentname"].ToString());
                        Response.BinaryWrite((byte[])myReader["document"]);
                        Response.Flush();
                        Response.Close();
                        Response.End();
                    }

                    myReader.Close();
                    myConnection.Close();
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
        else if (e.CommandName == "Remove")
        {
            try
            {
                Hashtable ht = new Hashtable();
                ht.Add("@Id", idd);
                clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Delete_Attachment", ht);

                bindAttach();

                ShowClientMessage("Attachment record deleted successfuly.", MessageType.Success);
            }
            catch (Exception ex)
            {
                ShowClientMessage(ex.Message, MessageType.Error);
            }
        }
        else if (e.CommandName == "Change")
        {
            try
            {
                RadTextBox txtfiledescription = e.Item.FindControl("txtfiledescription") as RadTextBox;
                if (txtfiledescription != null)
                {
                    Hashtable ht = new Hashtable();
                    ht.Add("@id", idd);
                    ht.Add("@desc", txtfiledescription.Text);
                    clsDAL.ExecuteNonQuery_payroll("sp_Payroll_Update_Attachment", ht);

                    bindAttach();

                    ShowClientMessage("Attachment description udpated successfuly.", MessageType.Success);
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage(ex.Message, MessageType.Error);
            }
        }
    }

    public void ShowClientMessage(string message, MessageType type, string redirect = "")
    {
        if (type == MessageType.Error)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showError('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Success)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showSuccess('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Warning)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showWarning('{0}', '{1}', 5000)", message, redirect), true);
        }
        else if (type == MessageType.Info)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "radalert", string.Format("showInfo('{0}', '{1}', 5000)", message, redirect), true);
        }
    }

}