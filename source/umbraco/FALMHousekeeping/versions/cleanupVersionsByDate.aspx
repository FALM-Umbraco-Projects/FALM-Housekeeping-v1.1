<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cleanupVersionsByDate.aspx.cs" Inherits="FALMHousekeeping.versions.cleanupVersionsByDate" MasterPageFile="../../masterpages/umbracoPage.Master" Title="F.A.L.M. Housekeeping - Cleanup Versions by Date" %>

<%@ Register TagPrefix="cc1" Assembly="controls" Namespace="umbraco.uicontrols" %>
<%@ Register TagPrefix="cc2" Assembly="cms" Namespace="umbraco.controls" %>

<asp:Content ID="cphHead" ContentPlaceHolderID="head" runat="server" />

<asp:Content ID="cphBody" ContentPlaceHolderID="body" runat="server">
	<cc1:UmbracoPanel ID="umbPanelCleanupVersionsByDate" Text="F.A.L.M. Housekeeping" runat="server" Width="612px" Height="600px" hasMenu="false">
		<cc1:Pane ID="PanelCleanupVersionsByDate" Style="padding-right: 10px; padding-left: 10px; padding-bottom: 10px; padding-top: 10px;" runat="server" CssClass="innerContent" Text="Cleanup versions by date">
			<p>With this tool you can cleanup the version history, deleting every version up to a given date.</p>
			<p><em>Please note that Umbraco requires each node to have at least 2 versions (the currently published and the latest). These versions will never be deleted.</em><br /><br /></p>
			<p>
				Delete all versions since&nbsp;&nbsp;&nbsp;
				<cc2:datePicker ID="dtpckrDate" runat="server" />
				&nbsp;&nbsp;&nbsp;<asp:Button ID="btnClearVersions" runat="server" Text="Delete" OnClick="btnClearVersions_Click" /></p>
			<p>
				&nbsp;</p>
			<p>
				<asp:Literal ID="ltrlVersions" runat="server" Text="" /></p>
		</cc1:Pane>
	</cc1:UmbracoPanel>
</asp:Content>
