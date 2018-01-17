﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" CodeFile="Display.aspx.cs" Inherits="Display" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="pnlContentWrapper" runat="server">
    </asp:Panel>
<br />
<br />
    <asp:Panel ID="pnlCommentWrapper" runat="server">
    </asp:Panel>
<br />
<asp:Panel ID="pnlComments" runat="server">
</asp:Panel>
<asp:Panel ID="pnlCommentSubmission" runat="server">
<div id="commentform">
<h3>Leave a Comment</h3>
    <dl>
        <dt>
        <asp:Label ID="lblName" runat="server">Name</asp:Label>
        <em>(required)</em>
        </dt>
        <dd>
        <input type="text" id="txtName" /></dd>
        <dt>
        <br />
        <asp:Label ID="lblEmail" runat="server">Email</asp:Label>
        <em>optional</em>
        </dt>
        <dd>
        <input type="text" id="txtEmail" /></dd>
        <dt>
        <br />
        <asp:Label ID="lblHomePage" runat="server">Home Page</asp:Label>
        </dt>
        <dd>
        <input type="text" id="txtHomePage" /></dd>
        <dt>
        <br />
        <asp:Label ID="lblComment" runat="server">Comments</asp:Label>
        </dt>
        <dd>
        <textarea id="txtComment" rows="10" cols="50"></textarea>
        </dd>
        <dt>
        <br />
        <input type="button" value="Submit" onclick="addBlogPostComment();" />
        </dt>
    </dl>
</div>
</asp:Panel>
<asp:HiddenField ID="hfArrivalTime" runat="server" />
<asp:HiddenField ID="hfBlogPostId" runat="server" />
    <script type="text/javascript">
        function addBlogPostComment() {
            var BlogPostComment = {};
            BlogPostComment.Id = 0;
            BlogPostComment.BlogPostId = $("#ctl00_ContentPlaceHolder1_hfBlogPostId").val();
            BlogPostComment.User = $("#txtName").val();
            BlogPostComment.Email = $("#txtEmail").val();
            BlogPostComment.HomePage = $("#txtHomePage").val();
            BlogPostComment.Comment = $("#txtComment").val();
            BlogPostComment.DatePublished = "";
            BlogPostComment.DateModified = "";
            BlogPostComment.Active = false;
            var DTO = { 'comment': BlogPostComment };
            ServiceInvoke("./../../../../measervice.asmx", "InsertBlogComment", true, DTO, OnInsertPostCommentSuccess,
                          OnFailure, "User Context", 1000000);
        }

        function OnInsertPostCommentSuccess(result) {
            $("#commentform").html("Thank you for submitting your comment, due to recent blog spam, " + 
            "your comment will be reviewed before it is viewable.");
        }

        function OnFailure(result) {
            $("#commentform").html("There was a problem submitting your comment. Please try again later.");
        }

        function ServiceInvoke(path, methodName, useHttpGet, parameters, succeededCallback, failedCallback, userContext, timeout) {
            if (typeof parameters !== "string") {
                parameters = JSON.stringify(parameters);
            }
            $.ajax({
                type: "POST",
                url: path + "/" + methodName,
                data: parameters,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                error: function(result) { failedCallback(result); },
                success: function(result) { succeededCallback(result.d); }
            });
        }
</script>
</asp:Content>
