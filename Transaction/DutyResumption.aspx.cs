using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Payroll_Transaction_DutyResumption : BasePage
{
    #region Startup

    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "Duty Resumption";
        base.Page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["_UserID"] != null)
            {
                clearForm();
            }
        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        RadGrid rGrdRecords4DDL = rCmbRecords.Items[0].FindControl("rGrdRecords4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdRecords4DDL, ucEmployeeCard);
    }

    #endregion

    #region Tab1 - New Requests

    #region Common Functions

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

    private void clearForm()
    {
        txtResumptionDate.Clear();
        txtEntryDate.Clear();
        txtDescription.Text = string.Empty;
        rCmbEmployee_SelectedIndexChanged(null, null);
    }

    public string ValidateResumption()
    {
        string errorStr = string.Empty;

        if (txtResumptionDate.SelectedDate == null)
            errorStr += "Resumption Date Required <br/>";

        if (txtEntryDate.SelectedDate == null)
            errorStr += "Entry Date Required <br/>";

        return errorStr;
    }

    protected void rCmbEmployee_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //if (rCmbEmployee.Items[0].Value != null)
        //{
        //    ucEmployeeCard.LoadEmployeeCard(rCmbEmployee.Items[0].Value);

        //    Hashtable ht = new Hashtable();
        //    ht.Add("@EmployeeID", rCmbEmployee.Items[0].Value);
        //    var dsEmployee = clsDAL.GetDataSet("sp_Payroll_Get_Employee_Card_By_ID", ht);

        //    if (dsEmployee != null && dsEmployee.Tables.Count > 0 && dsEmployee.Tables[0].Rows.Count > 0)
        //    {
        //        //this.SetDepartment(Convert.ToString(dsEmployee.Tables[0].Rows[0]["DepartmentIDD"]));

        //        //this.SetPosition(Convert.ToString(dsEmployee.Tables[0].Rows[0]["PositionIDD"]));
        //    }
        //}
    }

    protected void rGrdEmployees4DDL_ItemCommand(object sender, GridCommandEventArgs e)
    {
        rCmbEmployee_SelectedIndexChanged(null, null);
    }

    protected void rGrdEmployees4DDL_DataBound(object sender, EventArgs e)
    {
        //RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        //foreach (GridItem item in grid.MasterTableView.Items)
        //{
        //    if (item is GridDataItem)
        //    {
        //        GridDataItem dataItem = (GridDataItem)item;
        //        if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == Session["_UserID"].ToString())
        //        {
        //            dataItem.Selected = true;
        //            break;
        //        }
        //    }
        //}
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        hfTrxId.Value = string.Empty;
        clearForm();
        rCmbRecords.ClearSelection();
        rCmbRecords.Text = string.Empty;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
    }

    private void SetGridValue4DLL(string id, RadComboBox rCmb, RadGrid grid, string dataValueKey, string dataTextKey)
    {
        if (grid != null)
        {
            foreach (GridItem item in grid.MasterTableView.Items)
            {
                if (item is GridDataItem)
                {
                    GridDataItem dataItem = (GridDataItem)item;
                    if (Convert.ToString(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex][dataValueKey]) == id)
                    {
                        dataItem.Selected = true;

                        rCmb.Items[0].Value = id;
                        rCmb.Items[0].Text = Convert.ToString(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex][dataTextKey]);
                        rCmb.Text = Convert.ToString(dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex][dataTextKey]);

                        break;
                    }
                }
            }
        }
    }

    #endregion

    #region resumption section

    protected void rGrdRecords4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_User_Get_All_Posted_LeaveTransaction", ht).Tables[0];
    }

    protected void rGrdRecords4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecords.Items[0].Value))
        {
            hfTrxId.Value = rCmbRecords.Items[0].Value;
            clearForm();
            loadresumptionRecord();
        }
    }

    public void loadresumptionRecord()
    {
        Hashtable htSearchParams = new Hashtable();
        htSearchParams["@recordIDD"] = hfTrxId.Value;
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Transaction", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            this.ltrlevcode.Text = "Code : "+dt.Rows[0]["LeaveCode"].ToString();
            this.ltrlevtype.Text = "Type : "+dt.Rows[0]["leaveTypeCode"].ToString();
            this.ltrlevstartdate.Text = !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()) ? "Start Date : " +DateTime.Parse(dt.Rows[0]["fromDate"].ToString()).ToString("dd-MMM-yyyy"): "Start Date : ";
            this.ltrlevenddate.Text =!string.IsNullOrEmpty(dt.Rows[0]["toDate"].ToString()) ? "End Date : "+ DateTime.Parse( dt.Rows[0]["toDate"].ToString()).ToString("dd-MMM-yyyy"): "End Date : ";
            this.ltrlevrejoiningdate.Text = !string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) ? "Rejoining Date : " +DateTime.Parse( dt.Rows[0]["rejoiningDate"].ToString() ).ToString("dd-MMM-yyyy") : "Rejoining Date : ";
            if (!string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) &&
               !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()))
            {
                this.ltrlevnoofdays.Text = "No of Days : " + Convert.ToString( (DateTime.Parse(dt.Rows[0]["rejoiningDate"].ToString()) - DateTime.Parse(dt.Rows[0]["fromDate"].ToString())).TotalDays + 1);
            }
            else
                this.ltrlevnoofdays.Text = "No of Days : 0";
            this.ucEmployeeCard.LoadEmployeeCard(dt.Rows[0]["employeeIDD"].ToString());
        }      
    }

    private void SetEmployee(string empID)
    {
        //RadGrid grid = rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        //if (grid != null)
        //{
        //    foreach (GridItem item in grid.MasterTableView.Items)
        //    {
        //        if (item is GridDataItem)
        //        {
        //            GridDataItem dataItem = (GridDataItem)item;
        //            if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == empID)
        //            {
        //                dataItem.Selected = true;

        //                rCmbEmployee.Items[0].Value = empID;
        //                rCmbEmployee.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
        //                rCmbEmployee.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();

        //                break;
        //            }
        //        }
        //    }
        //}
        this.ucEmployeeCard.LoadEmployeeCard(empID);
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecords.Items[0].Value))
        {
            string recordId = rCmbRecords.Items[0].Value;
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("BatchMaster");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + recordId + "','" + rptName + "');", true);
        }
        else
            ShowClientMessage(string.Format("No record selected!"), MessageType.Error);
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(hfTrxId.Value))
        {
            try
            {
                string requiredStr = ValidateResumption();
                if (string.IsNullOrEmpty(requiredStr))
                {
                    #region save resumption record

                    Hashtable ht = new Hashtable();
                    ht.Add("@TransactionID", Convert.ToInt32(hfTrxId.Value));
                    ht.Add("@TransactionNumber", rCmbRecords.Text);
                    ht.Add("@ResumptionDate", txtResumptionDate.SelectedDate);
                    ht.Add("@EntryDate", txtEntryDate.SelectedDate);
                    ht.Add("@ResumpDesc", txtDescription.Text);
                    ht.Add("@SubmittedByUserID", (string)Session["_UserID"]);         
                    ht.Add("@ResumptionID", 0);

                    int Appidd = 0;
                    Appidd = int.Parse(clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_LeaveResumption, ht, "@ResumptionID", System.Data.SqlDbType.Int, 0).ToString());

                    #endregion

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

                            string base64String = Convert.ToBase64String(imgBinaryData);

                            ht_attachments = new Hashtable();
                            ht_attachments.Add("@transactionname", "LeaveResumption");
                            ht_attachments.Add("@transactionidd", Convert.ToInt32(hfTrxId.Value));
                            ht_attachments.Add("@transactioncode", rCmbRecords.Text);
                            ht_attachments.Add("@description", filedsc);

                            ht_attachments["@File"] = imgBinaryData;
                            ht_attachments["@Filetype"] = currentFile.ContentType;
                            ht_attachments["@Filename"] = filename;

                            clsDAL.ExecuteNonQuery(Constraints.sp_User_Insert_Attachment, ht_attachments);
                        }
                    }

                    #endregion

                    rCmbRecords.Text = string.Empty;
                    rCmbRecords.ClearSelection();
                    (rCmbRecords.Items[0].FindControl("rGrdRecords4DDL") as RadGrid).Rebind();

                    rCmbRecordsPosted.Text = string.Empty;
                    rCmbRecordsPosted.ClearSelection();
                    (rCmbRecordsPosted.Items[0].FindControl("rGrdRecordsPosted4DDL") as RadGrid).Rebind();

                    ShowClientMessage(string.Format("Record Posted Successfully"), MessageType.Success);

                    hfTrxId.Value = string.Empty;
                    clearForm();
                }
                else
                {
                    ShowClientMessage(requiredStr, MessageType.Error);
                }
            }
            catch (Exception ex)
            {
                ShowClientMessage("Sorry! some error has occurred. Please try again later.<br/>" + ex.Message, MessageType.Error);            
            }
        }
        else
            ShowClientMessage(string.Format("Please select a record"), MessageType.Error);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(hfTrxId.Value))
        {
            Hashtable ht_submit = new Hashtable();
            ht_submit.Add("@trxid", Convert.ToInt32(hfTrxId.Value));
            clsDAL.ExecuteNonQuery("sp_Payroll_Delete_LoanTransaction", ht_submit);

            rCmbRecords.Text = string.Empty;
            rCmbRecords.ClearSelection();
            RadGrid grid = (rCmbRecords.Items[0].FindControl("rGrdRecords4DDL") as RadGrid);
            if (grid != null)
                grid.Rebind();

            ShowClientMessage(string.Format("Record Deleted Successfully"), MessageType.Success);

            hfTrxId.Value = string.Empty;
            clearForm();
        }
        else
            ShowClientMessage(string.Format("Please select a record"), MessageType.Error);
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
    }

    #endregion

    #endregion

    #region Tab2 - Posted Requests

    #region resumption Section

    private void clearFormPosted()
    {
        //txtInstallmentsPosted.Text = "";
        txtResumptionDatePosted.Clear();

        rCmbEmployeePosted_SelectedIndexChanged(null, null);
    }

    protected void btnPrintPosted_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecordsPosted.Items[0].Value))
        {
            string recordId = rCmbRecordsPosted.Items[0].Value;
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("BatchMaster");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + recordId + "','" + rptName + "');", true);
        }
        else
            ShowClientMessage(string.Format("No record selected!"), MessageType.Error);
    }

    protected void btnVoidCancel_Click(object sender, EventArgs e)
    {
        // set a record voided/cancel
        if (!string.IsNullOrEmpty(rCmbRecordsPosted.Items[0].Value))
        {
            int recordId = Convert.ToInt32(rCmbRecordsPosted.Items[0].Value);
            Hashtable ht_submit = new Hashtable();
            ht_submit.Add("@trxid", recordId);
            ht_submit.Add("@voidedUserId", Convert.ToInt32(Session["_UserID"].ToString()));
            ht_submit.Add("@voidedUserCode", User.Identity.Name);
            clsDAL.ExecuteNonQuery("sp_Payroll_LeaveResumptionSetVoided", ht_submit);
            ShowClientMessage(string.Format("Transaction ID : " + recordId + " Voided Successfully"), MessageType.Success);

            (rCmbRecordsPosted.Items[0].FindControl("rGrdRecordsPosted4DDL") as RadGrid).Rebind();
        }
        else
        {
            ShowClientMessage(string.Format("No record selected! "), MessageType.Error);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
    }

    protected void rGrdEmployeesPosted4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);

        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];

        //rCmbEmployeePosted.Items[0].Value = Session["_UserID"].ToString();
        //rCmbEmployeePosted.Items[0].Text = "Self";
        //rCmbEmployeePosted.Text = "Self";

        rCmbEmployeePosted_SelectedIndexChanged(null, null);
    }

    protected void rCmbEmployeePosted_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //if (rCmbEmployeePosted.Items[0].Value != null)
        //{
        //    this.ucEmployeeCard1.LoadEmployeeCard(rCmbEmployeePosted.Items[0].Value);
        //}
    }

    protected void rGrdRecordsPosted4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_User_Get_All_Posted_LeaveResumption", ht).Tables[0];
    }

    protected void rGrdRecordsPosted4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecordsPosted.Items[0].Value))
        {
            clearFormPosted();
            loadresumptionRecordPosted();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab2');", true);
        }
    }

    public void loadresumptionRecordPosted()
    {
        Hashtable htSearchParams = new Hashtable();
        htSearchParams["@recordIDD"] = rCmbRecordsPosted.Items[0].Value;
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Transaction", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            this.ltrlevcodposted.Text = "Code : " + dt.Rows[0]["LeaveCode"].ToString();
            this.ltrlevtypposted.Text = "Type : " + dt.Rows[0]["leaveTypeCode"].ToString();
            this.ltrlevstartdateposted.Text = !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()) ? "Start Date : " + DateTime.Parse(dt.Rows[0]["fromDate"].ToString()).ToString("dd-MMM-yyyy") : "Start Date : ";
            this.ltrlevenddateposted.Text = !string.IsNullOrEmpty(dt.Rows[0]["toDate"].ToString()) ? "End Date : " + DateTime.Parse(dt.Rows[0]["toDate"].ToString()).ToString("dd-MMM-yyyy") : "End Date : ";
            this.ltrlevrejoiningdateposted.Text = !string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) ? "Rejoining Date : " + DateTime.Parse(dt.Rows[0]["rejoiningDate"].ToString()).ToString("dd-MMM-yyyy") : "Rejoining Date : ";
            if (!string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) &&
               !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()))
            {
                this.ltrnoofdaysposted.Text = "No of Days : " + Convert.ToString((DateTime.Parse(dt.Rows[0]["rejoiningDate"].ToString()) - DateTime.Parse(dt.Rows[0]["fromDate"].ToString())).TotalDays + 1);
            }
            else
                this.ltrnoofdaysposted.Text = "No of Days : 0";

            txtDescriptionPosted.Text = dt.Rows[0]["resumpDsc"].ToString();
            txtResumptionDatePosted.DbSelectedDate = DateTime.Parse(dt.Rows[0]["resumptionDate"].ToString());
            rdpEntryDatePosted.DbSelectedDate = DateTime.Parse(dt.Rows[0]["entryDate"].ToString());

            if (Convert.ToBoolean(dt.Rows[0]["voided"].ToString()))
            {
                btnVoidCancel.Enabled = false;
            }
            else
                btnVoidCancel.Enabled = true;

            this.ucEmployeeCard1.LoadEmployeeCard(dt.Rows[0]["employeeIDD"].ToString());
        }
    }

    private void SetEmployeePosted(string empID)
    {
        //RadGrid grid = rCmbEmployeePosted.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        //if (grid != null)
        //{
        //    foreach (GridItem item in grid.MasterTableView.Items)
        //    {
        //        if (item is GridDataItem)
        //        {
        //            GridDataItem dataItem = (GridDataItem)item;
        //            if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == empID)
        //            {
        //                dataItem.Selected = true;

        //                rCmbEmployeePosted.Items[0].Value = empID;
        //                rCmbEmployeePosted.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
        //                rCmbEmployeePosted.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();

        //                break;
        //            }
        //        }
        //    }
        //}
        //this.ucEmployeeCard1.LoadEmployeeCard(empID);
    }

    #endregion

    #endregion

    #region Tab3 - Archive Requests

    #region resumption Section

    private void clearFormArchived()
    {
        txtResumptionDateArchived.Clear();

        rCmbEmployeeArchived_SelectedIndexChanged(null, null);
    }

    protected void btnPrintArchived_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecordsArchived.Items[0].Value))
        {
            string recordId = rCmbRecordsArchived.Items[0].Value;
            // bring report from formtype
            string rptName = clsEncryption.EncryptData("BatchMaster");
            ScriptManager.RegisterStartupScript(this, Page.GetType(), "mykey", "ShowReport('" + recordId + "','" + rptName + "');", true);
        }
        else
            ShowClientMessage(string.Format("No record selected!"), MessageType.Error);
    }

    protected void rGrdEmployeesArchived4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        ht.Add("@UserID", Session["_UserID"].ToString());
        ht.Add("@FormTypeID", Request.QueryString["FormType"]);

        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_admin("sp_User_Get_Employees_By_UserID_4_DDL", ht).Tables[0];

        //rCmbEmployeeArchived.Items[0].Value = Session["_UserID"].ToString();
        //rCmbEmployeeArchived.Items[0].Text = "Self";
        ////rCmbEmployeeArchived.Text = "Self";

        rCmbEmployeeArchived_SelectedIndexChanged(null, null);
    }

    protected void rCmbEmployeeArchived_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
    {
        //if (rCmbEmployeeArchived.Items[0].Value != null)
        //{
        //    this.ucEmployeeCard2.LoadEmployeeCard(rCmbEmployeeArchived.Items[0].Value);
        //}
    }

    protected void rGrdRecordsArchived4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        Hashtable ht = new Hashtable();
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_User_Get_All_Archived_LeaveResumption", ht).Tables[0];
    }

    protected void rGrdRecordsArchived4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(rCmbRecordsArchived.Items[0].Value))
        {
            clearFormArchived();
            loadresumptionRecordArchived();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab3');", true);
        }
    }

    public void loadresumptionRecordArchived()
    {
        Hashtable htSearchParams = new Hashtable();
        htSearchParams["@recordIDD"] = rCmbRecordsArchived.Items[0].Value;
        DataTable dt = clsDAL.GetDataSet_Payroll("sp_Payroll_Get_Leave_Transaction", htSearchParams).Tables[0];
        if (dt.Rows.Count > 0)
        {
            this.ltrlevcodarchived.Text = "Code : " + dt.Rows[0]["LeaveCode"].ToString();
            this.ltrlevtyparchived.Text = "Type : " + dt.Rows[0]["leaveTypeCode"].ToString();
            this.ltrlevstartdatearchived.Text = !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()) ? "Start Date : " + DateTime.Parse(dt.Rows[0]["fromDate"].ToString()).ToString("dd-MMM-yyyy") : "Start Date : ";
            this.ltrlevenddatearchived.Text = !string.IsNullOrEmpty(dt.Rows[0]["toDate"].ToString()) ? "End Date : " + DateTime.Parse(dt.Rows[0]["toDate"].ToString()).ToString("dd-MMM-yyyy") : "End Date : ";
            this.ltrlevrejoiningdatearchived.Text = !string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) ? "Rejoining Date : " + DateTime.Parse(dt.Rows[0]["rejoiningDate"].ToString()).ToString("dd-MMM-yyyy") : "Rejoining Date : ";
            if (!string.IsNullOrEmpty(dt.Rows[0]["rejoiningDate"].ToString()) &&
               !string.IsNullOrEmpty(dt.Rows[0]["fromDate"].ToString()))
            {
                this.ltrnoofdaysarchived.Text = "No of Days : " + Convert.ToString((DateTime.Parse(dt.Rows[0]["rejoiningDate"].ToString()) - DateTime.Parse(dt.Rows[0]["fromDate"].ToString())).TotalDays + 1);
            }
            else
                this.ltrnoofdaysarchived.Text = "No of Days : 0";

            txtDescriptionArchived.Text = dt.Rows[0]["resumpDsc"].ToString();
            txtResumptionDateArchived.DbSelectedDate = DateTime.Parse(dt.Rows[0]["resumptionDate"].ToString());
            rdpEntryDateArchived.DbSelectedDate = DateTime.Parse(dt.Rows[0]["entryDate"].ToString());
            
            this.ucEmployeeCard2.LoadEmployeeCard(dt.Rows[0]["employeeIDD"].ToString());
        }
    }

    private void SetEmployeeArchived(string empID)
    {
        //RadGrid grid = rCmbEmployeeArchived.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid;
        //if (grid != null)
        //{
        //    foreach (GridItem item in grid.MasterTableView.Items)
        //    {
        //        if (item is GridDataItem)
        //        {
        //            GridDataItem dataItem = (GridDataItem)item;
        //            if (dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["UserID"].ToString() == empID)
        //            {
        //                dataItem.Selected = true;

        //                rCmbEmployeeArchived.Items[0].Value = empID;
        //                rCmbEmployeeArchived.Items[0].Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();
        //                rCmbEmployeeArchived.Text = dataItem.OwnerTableView.DataKeyValues[dataItem.ItemIndex]["EmployeeFullNameWithID"].ToString();

        //                break;
        //            }
        //        }
        //    }
        //}
        this.ucEmployeeCard2.LoadEmployeeCard(empID);
    }

    #endregion

    #endregion
}