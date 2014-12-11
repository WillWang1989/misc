<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InitData();
        }
    }

    private void InitData()
    {
        DirectoryInfo dir = new DirectoryInfo(Server.MapPath("~/log/"));
        FileInfo[] list = dir.GetFiles("*.txt");
        rpFiles.DataSource = list.OrderByDescending(d=>d.LastWriteTime);
        rpFiles.DataBind();
    }

    public String FormatFileSize(object dataItem)
    {
        var fileSize = 0L;
        var f = dataItem as FileInfo;
        if (f == null) return "--";
        fileSize = f.Length;
        if (fileSize < 0)
        {
            throw new ArgumentOutOfRangeException("fileSize");
        }
        if (fileSize >= 1024 * 1024 * 1024)
        {
            return string.Format("{0:########0.00} GB", ((Double)fileSize) / (1024 * 1024 * 1024));
        }
        if (fileSize >= 1024 * 1024)
        {
            return string.Format("{0:####0.00} MB", ((Double)fileSize) / (1024 * 1024));
        }
        if (fileSize >= 1024)
        {
            return string.Format("{0:####0.00} KB", ((Double)fileSize) / 1024);
        }
        return string.Format("{0} bytes", fileSize);
    }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>日志</title>
    <meta name="viewport" content="width=device-width;inital-scale=1.0"/>
    <style type="text/css">
        body {
            line-height: 1.6em;
        }

        .hor-minimalist-b {
            font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
            font-size: 12px;
            background: #fff;
            margin: 45px;
            width: 960px;
            border-collapse: collapse;
            text-align: left;
        }

            .hor-minimalist-b th {
                font-size: 14px;
                font-weight: normal;
                color: #039;
                padding: 10px 8px;
                border-bottom: 2px solid #6678b1;
            }

            .hor-minimalist-b td {
                border-bottom: 1px solid #ccc;
                color: #669;
                padding: 6px 8px;
            }

            .hor-minimalist-b tbody tr:hover td {
                color: #009;
            }
    </style>
</head>
<body>
    <form id="HtmlForm" runat="server">
        <div>
            <table class="hor-minimalist-b">
                <tr>
                    <th>#</th>
                    <th>FileName</th>
                    <th>Size</th>
                    <th>Date</th>
                </tr>
                <asp:Repeater runat="server" ID="rpFiles">
                    <ItemTemplate>
                        <tr>
                            
                            <td><%#(Container.ItemIndex+1)%></td>
                            <td><a href="/log/<%# DataBinder.Eval(Container.DataItem, "Name")%>" target="_blank"><%# DataBinder.Eval(Container.DataItem, "Name")%></a></td>
                            <td><%#FormatFileSize(Container.DataItem) %></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "LastWriteTime")%></td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>

        </div>
    </form>
</body>
</html>
