using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Linq;
using System.Web.Security;
using System.Web;
using System.Collections.Generic;
using System.Web.UI;
using System.Threading;
using System.Collections.Generic;

public partial class LeaveProvision : BasePage
{
    public class Employee
    {
        public int recidd { get; set; }
        public string empcod { get; set; }
        public string empfsn { get; set; }
        public int dptidd { get; set; }
    }

    #region Page functions

    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "LeaveProvision";
        base.Page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        RadGrid rGrdDepartments4DDL = rCmbDepartments.Items[0].FindControl("rGrdDepartments4DDL") as RadGrid;
        RadAjaxManager1.AjaxSettings.AddAjaxSetting(rGrdDepartments4DDL, rCmbEmployee);
    }

    #endregion

    #region Tab 1

    public string ValidateLeavePro()
    {
        string errorStr = string.Empty;

        if (string.IsNullOrEmpty(rCmbDepartments.Text))
            errorStr += "Department Required <br/>";

        if (string.IsNullOrEmpty(rCmbEmployee.Text))
            errorStr += "Employee Required <br/>";

        if (txtDate.SelectedDate == null)
            errorStr += "Till Date Required <br/>";

        return errorStr;
    }

    protected void rBtnCalculate_Click(object sender, EventArgs e)
    {
        try
        {
            string requiredStr = ValidateLeavePro();
            if (string.IsNullOrEmpty(requiredStr))
            {
                RadGrid rGrdEmployees4DDL = (rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid);
                string selectedIds = string.Empty;
                if (rGrdEmployees4DDL.SelectedItems.Count > 0)
                {
                    foreach (GridDataItem dataItem in rGrdEmployees4DDL.SelectedItems)
                    {
                        int empId = Convert.ToInt32(dataItem["recidd"].Text);
                        Hashtable ht_parm = new Hashtable();
                        ht_parm.Add("@empId", empId);
                        // call sp here for process logic
                        //DataTable dt = clsDAL.GetDataSet("sp_User_Get_Loan_Info_4_Email", ht_parm).Tables[0];
                    }
                }
                ShowClientMessage("Calculate Process Completed Successfully.<br/>", MessageType.Success);
            }
            else
            {
                ShowClientMessage(requiredStr, MessageType.Error);
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", "ShowTab('#tab1');", true);
        }
        catch (Exception ex)
        {
            ShowMessage("Invalid Operation.<br/>" + ex.Message, MessageType.Error);
            Logger.LogError(ex);
        }
    }

#region Leave Balance Calculation Procedures
    private void CalculateLeaveBalance(int employee)
    {
    
        

    }

#endregion
    protected void rGrdDepartments4DDL_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            RadGrid rgrdDepartment = sender as RadGrid;
            string selectedIds = string.Empty;
            if (rgrdDepartment.SelectedItems.Count > 0)
            {
                foreach (GridDataItem dataItem in rgrdDepartment.SelectedItems)
                {
                    if (string.IsNullOrEmpty(selectedIds))
                        selectedIds = dataItem["dptidd"].Text;
                    else
                        selectedIds = selectedIds + "," + dataItem["dptidd"].Text;
                }
            }
            hfdps.Value = selectedIds;
            (rCmbEmployee.Items[0].FindControl("rGrdEmployees4DDL") as RadGrid).Rebind();
        }
        catch (Exception ex)
        {

        }
    }

    protected void rGrdDepartments4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet("sp_Payroll_Get_All_Departments").Tables[0];
    }

    protected void rGrdEmployees4DDL_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        rCmbEmployee.ClearSelection();
        rCmbEmployee.Text = string.Empty;

        var grid = sender as RadGrid;
        Hashtable ht_param = new Hashtable();

        DataTable dt = clsDAL.GetDataSet("sp_payroll_GetAllEmployeeRecords", ht_param).Tables[0];
        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(hfdps.Value))
            {
                List<Employee> empList = new List<Employee>();
                Array arr = hfdps.Value.Split(',');
                if (arr.Length > 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        if (SearchIds(arr, row["dptidd"].ToString()))
                        {
                            Employee temp = new Employee();
                            temp.recidd = Convert.ToInt32(row["recidd"].ToString());
                            temp.empcod = row["empcod"].ToString();
                            temp.empfsn = row["empfsn"].ToString();
                            temp.dptidd = Convert.ToInt32(row["dptidd"].ToString());
                            empList.Add(temp);
                        }
                    }
                }
                grid.DataSource = empList;
            }
            else
                grid.DataSource = new DataTable();
        }
        else
            grid.DataSource = new DataTable();
    }

    bool SearchIds(Array array, string dptid)
    {
        if (Array.LastIndexOf(array, dptid) > -1)
            return true;
        else
            return false;
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

    #endregion
}

