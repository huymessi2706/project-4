<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<%--<c: var="buildingEditURL" values="/admin/building-edit"/>--%>
<html>
<head>
    <title>Thông tin toà nhà</title>
</head>
<body>
<div class="main-content">
    <div class="main-content-inner">
        <div class="breadcrumbs" id="breadcrumbs">
            <script type="text/javascript">
                try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
            </script>

            <ul class="breadcrumb">
                <li>
                    <i class="ace-icon fa fa-home home-icon"></i>
                    <a href="<c:url value="/admin/home"/>">Home</a>
                </li>

                <li>
                    <a href="#">Customer Details</a>
                </li>
<%--                <li class="active">Content Sliders</li>--%>
            </ul><!-- /.breadcrumb -->

            <div class="nav-search" id="nav-search">
                <form class="form-search">
                                <span class="input-icon">
                                    <input type="text" placeholder="Search ..." class="nav-search-input"
                                           id="nav-search-input" autocomplete="off" />
                                    <i class="ace-icon fa fa-search nav-search-icon"></i>
                                </span>
                </form>
            </div><!-- /.nav-search -->
        </div>

        <div class="page-content">
            <div class="page-header">
                <h1>Update or Add Building
                </h1>
            </div><!-- /.page-header -->

            <div class="row" style="font-family: 'Times New Roman', Times, serif;">
                <form:form method="get" action="/admin/customer-edit" modelAttribute="editModel" id="form-edit">
                    <c:if test="${editModel.id != null}">
                        <c:if test="${editModel.isActive == 0}">
                            <c:redirect url="/admin/customer-list" />
                        </c:if>
                    </c:if>
                    <input type="hidden" id="customerId" name="customerId" value="${editModel.id}">
                    <div class="col-xs-12">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-xs-3">Tên khách hàng</label>
                                <div class="col-xs-9">
                                    <form:input path="fullName" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Số điện thoại</label>
                                <div class="col-xs-9">
                                    <form:input path="phone" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Email</label>
                                <div class="col-xs-9">
                                    <form:input path="email" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Tên công ty</label>
                                <div class="col-xs-9">
                                    <form:input path="companyName" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Nhu cầu</label>
                                <div class="col-xs-9">
                                    <form:input path="demand" class="form-control"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3">Tình trạng</label>
                                <div class="col-xs-2">
                                    <form:select class="form-control" path="status">
                                        <form:option value="">--Chọn tình trạng--</form:option>
                                        <form:options items="${statuses}"/>
                                    </form:select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-xs-3"></label>
                                <div class="col-xs-9">
                                    <c:if test="${empty editModel.id}">
                                        <button type="button" class="btn btn-sm btn-success" id="btn-updateOrAdd">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-add" viewBox="0 0 16 16">
                                                <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                                <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                            </svg>
                                            Thêm khách hàng
                                        </button>
                                    </c:if>
                                    <c:if test="${not empty editModel.id}">
                                        <security:authorize access="hasRole('MANAGER')">
                                            <button type="button" class="btn btn-sm btn-success" id="btn-updateOrAdd">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-add" viewBox="0 0 16 16">
                                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                                    <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                                </svg>
                                                Cập nhật khách hàng
                                            </button>
                                        </security:authorize>
                                    </c:if>
                                    <a class="btn btn-sm btn-danger" href="/admin/customer-list">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                             fill="currentColor" class="bi bi-ban" viewBox="0 0 16 16">
                                            <path
                                                    d="M15 8a6.97 6.97 0 0 0-1.71-4.584l-9.874 9.875A7 7 0 0 0 15 8M2.71 12.584l9.874-9.875a7 7 0 0 0-9.874 9.874ZM16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0" />
                                        </svg>
                                        Huỷ thao tác
                                    </a>
                                    <img src="/img/loading.gif" style="display: none; height: 100px" id="loading_image">
                                </div>
                            </div>
                        </form>
                    </div>
                </form:form>
            </div>
        </div><!-- /.col -->
    </div><!-- /.row -->
    <c:forEach var="item" items="${transactions}">

        <div class="col-xs-12">
<%--            <div class="col-sm-12">--%>
                <h3 class="header smaller lighter blue">${item.value}</h3>
                <button class="btn btn-lg btn-primary" onclick="transactionType('${item.key}', ${editModel.id})">
                    <i class="orange ace-icon fa fa-location-arrow bigger-130"></i>Add
                </button>
<%--            </div>--%>
        </div>

        <c:if test="${item.key == 'CSKH'}">
            <div class="col-xs-12">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Ngày tạo</th>
                            <th>Người tạo</th>
                            <th>Ngày sửa</th>
                            <th>Người sửa</th>
                            <th>Chi tiết giao dịch</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>

                    <tbody>
                    <c:forEach var="it" items="${listCSKH}">
                        <tr>
                            <td>${it.createdDate}</td>
                            <td>${it.createdBy}</td>
                            <c:if test="${it.modifiedDate != it.createdDate}">
                                <td>${it.modifiedDate}</td>
                                <td>${it.modifiedBy}</td>
                            </c:if>
                            <c:if test="${it.modifiedDate == it.createdDate}">
                                <td></td>
                                <td></td>
                            </c:if>
                            <td>${it.note}</td>
                            <td>
                                <Button class="btn btn-xs btn-info" title="Chỉnh sửa giao dịch" onclick="btnUpdateTransaction(${it.id})">
                                    <i class="ace-icon fa fa-pencil bigger-120"></i>
                                </Button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${item.key == 'DDX'}">
                <div class="col-xs-12">
                <table class="table table-striped table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>Ngày tạo</th>
                            <th>Người tạo</th>
                            <th>Ngày sửa</th>
                            <th>Người sửa</th>
                            <th>Chi tiết giao dịch</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="it" items="${listDDX}">
                                <tr>
                                    <td>${it.createdDate}</td>
                                    <td>${it.createdBy}</td>
                                    <c:if test="${it.modifiedDate != it.createdDate}">
                                        <td>${it.modifiedDate}</td>
                                        <td>${it.modifiedBy}</td>
                                    </c:if>
                                    <c:if test="${it.modifiedDate == it.createdDate}">
                                        <td></td>
                                        <td></td>
                                    </c:if>
                                    <td>${it.note}</td>
                                    <td>
                                        <Button class="btn btn-xs btn-info" title="Chỉnh sửa giao dịch" onclick="btnUpdateTransaction(${it.id})">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </Button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                </table>
            </div>
        </c:if>
    </c:forEach>

    <div class="modal fade" id="transactionTypeModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Nội dung giao dịch</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group has-success">
                        <label for="transactionDetail" class="col-xs-12 col-sm-3 control-label no-padding-right">
                            Chi tiết giao dịch
                        </label>
                        <div class="col-xs-12 col-sm-9">
                            <span class="block input-icon input-icon-right">
                                <input type="text" id="transactionDetail" class="width-100">
                            </span>
                        </div>
                    </div>
<%--                    <input type="hidden" name="customerId" id="customerId" value="">--%>
                    <input type="hidden" name="code" id="code" value="">
                    <input type="hidden" name="transactionId" id="transactionId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnAddOrUpdateTransaction">Thêm/Sửa nội dung giao dịch</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>
</div><!-- /.page-content -->
<script>
    $('#btn-updateOrAdd').click(function(e){
        var data = {}
        var formData = $('#form-edit').serializeArray();
        $.each(formData, function (i, it) {
            data["" + it.name + ""] = it.value;
        })

        if(data['phone'] == '' || data['fullName'] == '')
            return alert("Name or phone is empty!")
        data['id'] = $('#customerId').val();
        addOrUpdate((data))
    })

    function addOrUpdate(data) {
        $.ajax({
            type: "POST",
            url: "/api/customers",
            data: JSON.stringify(data),
            contentType : "application/json",
            success:(response)=>{
                alert("success");
                window.location.replace("/admin/customer-list");
            },
            error : function (response){
                // $('#loading_image').hide();
                alert("failed");
            }
        });
    }

    function transactionType (type, customerId){
        $('#transactionTypeModal').modal();
        $('#customerId').val(customerId);
        $('#code').val(type);
    }

    function btnUpdateTransaction (transactionId){
        $('#transactionTypeModal').modal();
        $('#transactionId').val(transactionId);
        loadTransactions(transactionId)
    }

    function loadTransactions(transactionId){
        $.ajax({
            type: "GET",
            url: "/api/customers/transactions-" + transactionId,
            dataType : "json",
            success:(response) =>{
                var item = response.data
                $('#transactionDetail').val(item.transactionDetail)
            },
            error : function (response){
                alert("failed!");
            }
        });
    }

    $('#btnAddOrUpdateTransaction').click(function(e){
        e.preventDefault();
        data = {}
        data['type'] = $('#code').val();
        data['customerId'] = $('#customerId').val();
        data['id'] = $('#transactionId').val();
        data['transactionDetail'] = $('#transactionDetail').val();
        $.ajax({
            type: "POST",
            url: "/api/customers/transactions",
            data: JSON.stringify(data),
            contentType : "application/json",
            success:(response)=>{
                alert("success");
                window.location.replace("/admin/customer-edit-" + $('#customerId').val());
            },
            error : function (response){
                // $('#loading_image').hide();
                alert("failed");
            }
        });
    })

</script>
</body>
</html>