using System;
using System.Collections;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Caching;
using System.Web.Profile;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using umbraco;
using umbraco.cms;
using umbraco.cms.businesslogic;
using umbraco.cms.businesslogic.web;
using umbraco.cms.businesslogic.property;
using umbraco.cms.businesslogic.propertytype;
using umbraco.DataLayer;

namespace FALMHousekeeping.versions
{
	public partial class showVersions : System.Web.UI.Page
	{
		// Initialize an SQL Helper Interface
		protected static ISqlHelper SqlHelper
		{
			get
			{
				return umbraco.BusinessLogic.Application.SqlHelper;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			// Set the ScriptTimeout to 100000
			Server.ScriptTimeout = 100000;
			Response.Buffer = false;

			System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(ui.Culture(umbraco.BasePages.UmbracoEnsuredPage.CurrentUser));
			System.Threading.Thread.CurrentThread.CurrentUICulture = System.Threading.Thread.CurrentThread.CurrentCulture;
		}

		/// <summary>
		/// This function will show the version history
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void btnShowVersions_Click(object sender, EventArgs e)
		{
			// Reset GridView Page to the top
			gvCurVer.PageIndex = 0;

			SqlDSCurrentVersion.SelectCommand = GetSQLCurrentVersion();
			gvCurVer.Visible = true;
		}

		/// <summary>
		///  This function return the SQLCommand of the current version published nodes
		/// </summary>
		/// <returns>strSQLCurrentVersion</returns>
		protected string GetSQLCurrentVersion()
		{
			string strSQLCurrentVersion = string.Empty;

			//strSQLCurrentVersion = "SELECT DISTINCT CurDoc.nodeId AS NodeId, CurDoc.text AS CurText, CurVer.VersionDate AS CurVersionDate ";
			//strSQLCurrentVersion += "FROM (cmsDocument CurDoc INNER JOIN cmsContentVersion CurVer ON CurDoc.versionId = CurVer.versionId) INNER JOIN (cmsDocument HistDoc INNER JOIN cmsContentVersion HistVer ON HistDoc.versionId = HistVer.VersionId) ON CurDoc.nodeId = HistDoc.nodeId ";
			//strSQLCurrentVersion += "WHERE CurDoc.newest = 1 AND HistDoc.published = 0 AND HistDoc.newest = 0 ";
			//strSQLCurrentVersion += GetDateRangeFilter();
			//strSQLCurrentVersion += "ORDER BY CurDoc.nodeId ASC";			
			
			strSQLCurrentVersion  = "SELECT DISTINCT CurDoc.nodeId, CurDoc.text, CurDoc.updateDate ";
			strSQLCurrentVersion += "FROM cmsDocument AS CurDoc INNER JOIN cmsDocument AS HistDoc ON CurDoc.nodeId = HistDoc.nodeId ";
			strSQLCurrentVersion += "WHERE (CurDoc.published = 1) ";
			if (!txtbNodeID.Text.Equals(string.Empty))
			{
				strSQLCurrentVersion += "AND nodeId = " + int.Parse(txtbNodeID.Text) + " ";
			}
			strSQLCurrentVersion += GetDateRangeFilter();
			strSQLCurrentVersion += "ORDER BY CurDoc.nodeId ASC";

			return strSQLCurrentVersion;
		}

		/// <summary>
		/// This function return the SQLCommand to shows all history versions for each node
		/// </summary>
		/// <param name="NodeId"></param>
		/// <returns></returns>
		protected string GetSQLHistoryVersions()
		{
			string strSQLHistoryVersion = string.Empty;
			strSQLHistoryVersion  = "SELECT documentUser, versionId, updateDate, text, published, newest ";
			strSQLHistoryVersion += "FROM cmsDocument ";
			strSQLHistoryVersion += "WHERE nodeId = @NodeId ";
			strSQLHistoryVersion += GetDateRangeFilter().Replace("HistDoc.updateDate", "updateDate");
			strSQLHistoryVersion += "ORDER BY updateDate DESC";

			return strSQLHistoryVersion;
		}

		/// <summary>
		/// This function return the date filter for SQLCommand
		/// </summary>
		/// <returns>strSQLDateRangeFilter</returns>
		protected string GetDateRangeFilter()
		{
			string strSQLDateRangeFilter = string.Empty;

			if ((dtpckrDateFrom.Text.Equals(string.Empty)) && (dtpckrDateTo.Text.Equals(string.Empty)))
			{
				dtpckrDateTo.DateTime = DateTime.Now.Subtract(new TimeSpan(0, 0, 0, 0));

				strSQLDateRangeFilter += "AND HistDoc.updateDate <= CONVERT(DATETIME, '" + dtpckrDateTo.DateTime.ToString("yyyy.MM.dd") + " 23:59:00', 102) ";
			}
			else if ((dtpckrDateFrom.Text.Equals(string.Empty)) && (!dtpckrDateTo.Text.Equals(string.Empty)))
			{
				strSQLDateRangeFilter += "AND HistDoc.updateDate <= CONVERT(DATETIME, '" + dtpckrDateTo.DateTime.ToString("yyyy.MM.dd") + " 23:59:00', 102) ";
			}
			else if ((!dtpckrDateFrom.Text.Equals(string.Empty)) && (dtpckrDateTo.Text.Equals(string.Empty)))
			{
				strSQLDateRangeFilter += "AND HistDoc.updateDate >= CONVERT(DATETIME, '" + dtpckrDateFrom.DateTime.ToString("yyyy.MM.dd") + " 00:00:00', 102) ";
			}
			else if (dtpckrDateFrom.DateTime <= dtpckrDateTo.DateTime)
			{
				strSQLDateRangeFilter += "AND HistDoc.updateDate >= CONVERT(DATETIME, '" + dtpckrDateFrom.DateTime.ToString("yyyy.MM.dd") + " 00:00:00', 102) AND HistDoc.updateDate <= CONVERT(DATETIME, '" + dtpckrDateTo.DateTime.ToString("yyyy.MM.dd") + " 23:59:00', 102) ";
			}
			else
			{
				string strDateFrom = dtpckrDateFrom.Text;
				string strDateSince = dtpckrDateTo.Text;

				dtpckrDateFrom.DateTime = DateTime.Parse(strDateSince);
				dtpckrDateTo.DateTime = DateTime.Parse(strDateFrom);

				strSQLDateRangeFilter += "AND HistDoc.updateDate >= CONVERT(DATETIME, '" + dtpckrDateFrom.DateTime.ToString("yyyy.MM.dd") + " 00:00:00', 102) AND HistDoc.updateDate <= CONVERT(DATETIME, '" + dtpckrDateTo.DateTime.ToString("yyyy.MM.dd") + " 23:59:00', 102) ";
			}

			return strSQLDateRangeFilter;
		}

		/// <summary>
		/// This function shows all version history for each current node
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void gvCurVer_RowDataBound(object sender, GridViewRowEventArgs e)
		{
			if (e.Row.RowType == DataControlRowType.DataRow)
			{
				Label lblNodeId = (Label) e.Row.FindControl("lblNodeId");
				Literal ltrlHistVer = (Literal) e.Row.FindControl("ltrlHistVer");

				using (IRecordsReader dr = SqlHelper.ExecuteReader(GetSQLHistoryVersions(), SqlHelper.CreateParameter("@nodeId", int.Parse(lblNodeId.Text))))
				{
					while (dr.Read())
					{
						ltrlHistVer.Text += dr.GetString("text") + " <small>(Created: " + dr.GetDateTime("updateDate").ToShortDateString() + " " + dr.GetDateTime("updateDate").ToShortTimeString() + ") ";
						if (dr.GetBoolean("published"))
						{
							ltrlHistVer.Text += "(<span style='color: green;'>published</span>)";
						}

						if (dr.GetBoolean("newest"))
						{
							ltrlHistVer.Text += "(<span style='color: navy;'>newest</span>)";
						}

						ltrlHistVer.Text += "</small><br />";
					}
				}
			}
		}

		/// <summary>
		/// This function manage the gridview paging
		/// </summary>
		/// <param name="sender"></param>
		/// <param name="e"></param>
		protected void gvCurVer_PageIndexChanging(object sender, GridViewPageEventArgs e)
		{
			gvCurVer.PageIndex = e.NewPageIndex;
			SqlDSCurrentVersion.SelectCommand = GetSQLCurrentVersion();
		}

		protected string convertToShortDateTime(string dDate)
		{
			string convertedDate = DateTime.Parse(dDate).ToShortDateString() + " " + DateTime.Parse(dDate).ToShortTimeString();

			return convertedDate;
		}
	}
}