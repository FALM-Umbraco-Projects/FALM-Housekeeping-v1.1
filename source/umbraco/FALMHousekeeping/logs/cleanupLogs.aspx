<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cleanupLogs.aspx.cs" Inherits="FALMHousekeeping.logs.cleanupLogs" MasterPageFile="../../masterpages/umbracoPage.Master" Title="F.A.L.M. Housekeeping - Cleanup Logs" %>

<%@ Register TagPrefix="cc1" Assembly="controls" Namespace="umbraco.uicontrols" %>
<%@ Register TagPrefix="cc2" Assembly="cms" Namespace="umbraco.controls" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="cphBody" ContentPlaceHolderID="body" runat="server">
	<cc1:UmbracoPanel ID="umbPanelCleanupLogs" Text="F.A.L.M. Housekeeping" runat="server" Width="612px" Height="600px" hasMenu="false">
		<cc1:Pane ID="PanelCleanupLogs" Style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;" runat="server" CssClass="innerContent" Text="Cleanup logs">
			<asp:Table ID="tblFilter" runat="server">
				<asp:TableRow>
					<asp:TableCell>
						<small>Filter by nodeId</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by user</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by log type</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by date range (from)</small>
					</asp:TableCell>
					<asp:TableCell>
						<small>Filter by date range (to)</small>
					</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell>
						<asp:TextBox ID="txtbNodeID" runat="server" />
					</asp:TableCell>
					<asp:TableCell>
						<asp:DropDownList ID="ddlUsers" AppendDataBoundItems="true" runat="server" DataSourceID="SqlDataSourceUsers" DataTextField="userName" DataValueField="Id">
							<asp:ListItem Text="-- Any --" Value="any" />
						</asp:DropDownList>
						<asp:SqlDataSource ID="SqlDataSourceUsers" runat="server" ConnectionString="<%$ appSettings:umbracoDbDSN %>" SelectCommand="SELECT Id, userName FROM umbracoUser ORDER BY userName" />
					</asp:TableCell>
					<asp:TableCell>
						<asp:DropDownList ID="ddlLogTypes" AppendDataBoundItems="true" runat="server">
							<asp:ListItem Text="-- Any --" Value="any" />
						</asp:DropDownList>
					</asp:TableCell>
					<asp:TableCell>
						<cc2:datePicker ID="dtpckrDateFrom" runat="server" />
					</asp:TableCell>
					<asp:TableCell>
						<cc2:datePicker ID="dtpckrDateTo" runat="server" />
					</asp:TableCell>
				</asp:TableRow>
				<asp:TableRow>
					<asp:TableCell ColumnSpan="4">
						<asp:Button ID="btnShowLog" runat="server" Text="Show logs to delete" OnClick="btnShowLogs_Click" />
					</asp:TableCell>
				</asp:TableRow>
			</asp:Table>
			<p>
				<asp:Literal ID="ltrlLogTotal" runat="server" /></p>
			<p>
				<asp:Literal ID="ltrlLogInfo" runat="server" /></p>
			<asp:GridView ID="gvLogTypesList" runat="server" AutoGenerateColumns="True" AllowPaging="False" AllowCustomPaging="False" AllowSorting="False" BackColor="#FFFFFF" BorderColor="#DEDFDE" BorderWidth="1" GridLines="Both" CellPadding="4" ForeColor="#000000">
				<RowStyle BackColor="#F7F7DE" />
				<HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="#FFFFFF" HorizontalAlign="Center" Wrap="false" />
				<AlternatingRowStyle BackColor="White" />
				<SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="#FFFFFF" />
				<PagerSettings Mode="NumericFirstLast" FirstPageText="First" LastPageText="Last" />
				<PagerStyle BackColor="#6B696B" ForeColor="#FFFFFF" HorizontalAlign="Right" />
				<FooterStyle BackColor="#CCCC99" />
			</asp:GridView>
			<p>
				<asp:Button ID="btnDelete" runat="server" Text="Confirm deletion" OnClick="btnDelete_Click" Visible="false" /></p>
		</cc1:Pane>
	</cc1:UmbracoPanel>
</asp:Content>
