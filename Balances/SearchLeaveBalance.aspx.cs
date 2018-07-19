using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Collections;
using System.Data;
using System.DirectoryServices;
using System.Configuration;

public partial class Payroll_SearchLeaveBalance : BasePage
{
    public static Hashtable htSearchParams = null;
    public bool exporting = false;

    // page load function
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            htSearchParams = null;
            dtpdate.SelectedDate = DateTime.Now;
        }
    }

    // pay code ddl data loading and binding
    protected void rGrdEmployee4DDL_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        RadGrid grid = sender as RadGrid;
        grid.DataSource = clsDAL.GetDataSet_Payroll("sp_payroll_GetAllEmployeeRecords", htSearchParams).Tables[0];
    }

    // page initialization function
    protected override void Page_Init(object sender, EventArgs e)
    {
        FormName = "LeaveBalance";
        base.Page_Init(sender, e);
    }

    // search function
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlEmployee.Items.Count > 0)
            {
                    htSearchParams = new Hashtable();
                    htSearchParams.Add("@EmpID", int.Parse(ddlEmployee.Items[0].Value.Trim()));
                    htSearchParams.Add("@Date", dtpdate.SelectedDate);
                    grdLeaves.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveBalanceRecordForSearchGrid", htSearchParams);
                    grdLeaves.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    // grd data loading and binding
    protected void grdLeaves_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        grdLeaves.DataSource = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeLeaveBalanceRecordForSearchGrid", htSearchParams);
    }

    // grd setting for exporting
    protected void grdLeaves_ItemCommand(object sender, GridCommandEventArgs e)
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
            grid.MasterTableView.ExportToExcel();
        }
        if (e.CommandName == RadGrid.ExportToCsvCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.ExportSettings.ExportOnlyData = false;
            grid.MasterTableView.ExportToCSV();
        }
        if (e.CommandName == RadGrid.ExportToPdfCommandName)
        {
            exporting = true;
            grid.GridLines = GridLines.Both;
            grid.BorderStyle = BorderStyle.Solid;
            grid.BorderWidth = Unit.Pixel(1);
            grid.MasterTableView.ExportToPdf();
        }
    }

    // employee ddl selected item change event
    protected void ddlEmployee_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        RadComboBox ddlEmployee = sender as RadComboBox;
        if (ddlEmployee != null)
        {
            RadGrid ddlEmpgrid = ddlEmployee.Items[0].FindControl("rGrdEmployee4DDL") as RadGrid;
            if (ddlEmpgrid != null)
            {
                if (ddlEmpgrid.SelectedItems.Count > 0)
                {
                    GridDataItem dataItem = ddlEmpgrid.SelectedItems[0] as GridDataItem;
                    int empIdd = Convert.ToInt32(dataItem.GetDataKeyValue("recidd"));

                    htSearchParams = new Hashtable();
                    htSearchParams.Add("@EmpId", empIdd);
                    DataTable dtResult = clsDAL.GetDataSet_Payroll("sp_Payroll_GetEmployeeSearchGridRecord", htSearchParams).Tables[0];

                    if (dtResult.Rows.Count > 0)
                    {
                        txtbxJoingingDate.Text = DateTime.Parse(dtResult.Rows[0]["empdoj"].ToString()).ToString("dd/MMM/yyyy");
                        txtbxCalenderID.Text = dtResult.Rows[0]["grdclc"].ToString();
                    }
                }
            }
        }
    }

}