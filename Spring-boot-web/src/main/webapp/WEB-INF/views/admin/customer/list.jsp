<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formUrl" value="/admin/customer-list"/>
<html>
<head>
    <title>Danh sách khách hàng</title>
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
                    <a href="#">List customers</a>
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
                <h1>Customer
                </h1>
            </div><!-- /.page-header -->

            <div class="row">
                <div class="col-xs-12">
                    <div class="widget-box" style="font-family: 'Times New Roman', Times, serif;">
                        <div class="widget-header">
                            <h4 class="widget-title">Tìm kiếm</h4>

                            <span class="widget-toolbar">
                                            <a href="#" data-action="reload">
                                                <i class="ace-icon fa fa-refresh"></i>
                                            </a>

                                            <a href="#" data-action="collapse">
                                                <i class="ace-icon fa fa-chevron-up"></i>
                                            </a>
                                        </span>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <form:form action="/admin/customer-list" method="GET" id="listForm" modelAttribute="searchModel">
                                    <div>
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-4">
                                                        <label>Tên khách hàng</label>
                                                        <form:input path="fullName" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label>Di động</label>
                                                        <form:input path="phone" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label>Email</label>
                                                        <form:input path="email" class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <security:authorize access="hasRole('MANAGER')">
                                                        <div class="col-xs-4">
                                                            <label>Chọn nhân viên</label>
                                                                <form:select class="form-control" path="staffId">
                                                                    <form:option value="">--Chọn nhân viên--</form:option>
                                                                    <form:options items="${staffs}"/>
                                                                </form:select>
                                                        </div>
                                                    </security:authorize>
                                                    <div class="col-xs-4">
                                                        <label>Tình trạng</label>
                                                        <form:select class="form-control" path="status">
                                                            <form:option value="">--Chọn tình trạng--</form:option>
                                                            <form:options items="${statuses}"/>
                                                        </form:select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-6">
                                                        <button class="btn btn-sm btn-primary" id="bthSearch">
                                                            <i class="ace-icon glyphicon glyphicon-search"></i>
                                                            Tìm kiếm
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                    <security:authorize access="hasRole('MANAGER')">
                        <div class="pull-right">
                            <button title="Xoá khách hàng" class="btn btn-danger" id="btnDeleteCustomers">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash" viewBox="0 0 16 16">
                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1m0-7a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                    <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                </svg>
                            </button>
                            <a href="/admin/customer-edit">
                                <button title="Thêm khách hàng" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-add" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0m-2-6a3 3 0 1 1-6 0 3 3 0 0 1 6 0M8 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4"/>
                                        <path d="M8.256 14a4.5 4.5 0 0 1-.229-1.004H3c.001-.246.154-.986.832-1.664C4.484 10.68 5.711 10 8 10q.39 0 .74.025c.226-.341.496-.65.804-.918Q8.844 9.002 8 9c-5 0-6 3-6 4s1 1 1 1z"/>
                                    </svg>
                                </button>
                            </a>
                        </div>
                    </security:authorize>
                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div class="hr hr-18 dotted hr-double"></div>
                        <div class="table-responsive">
                            <display:table name="listResponse" cellspacing="0" cellpadding="0"
                                           requestURI="${formUrl}" partialList="true" sort="external"
                                           size="${totalItems}" defaultsort="2" defaultorder="ascending"
                                           id="tableList" pagesize="${maxPages}"
                                           export="false"
                                           class="table table-fcv-ace table-striped table-bordered table-hover dataTable no-footer"
                                           style="margin: 3em 0 1.5em;">
                                <display:column title="<fieldset class='form-group'>
												        <input type='checkbox' id='checkAll' class='check-box-element'>
												        </fieldset>" class="center select-cell"
                                                headerClass="center select-cell">
                                    <fieldset>
                                        <input type="checkbox" name="checkList" value="${tableList.id}"
                                               id="checkbox_${tableList.id}" class="check-box-element"/>
                                    </fieldset>
                                </display:column>
                                <display:column headerClass="text-left" property="fullName" title="Tên khách hàng"/>
                                <display:column headerClass="text-left" property="phone" title="Di động"/>
                                <display:column headerClass="text-left" property="email" title="Email"/>
                                <display:column headerClass="text-left" property="demand" title="Nhu cầu"/>
                                <display:column headerClass="text-left" property="createdBy" title="Người thêm"/>
                                <display:column headerClass="text-left" property="createdDate" title="Ngày thêm"/>
                                <display:column headerClass="text-left" property="status" title="Tình trạng"/>
                                <display:column title="Thao tác" class="center select-cell"
                                                headerClass="center select-cell">
                                    <fieldset>
                                        <security:authorize access="hasRole('MANAGER')">
                                            <Button class="btn btn-xs btn-danger" title="Xoá toà nhà" onclick="btnDeleteCustomer(${tableList.id})">
                                                <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                            </Button>
                                        </security:authorize>

                                        <a class="btn btn-xs btn-info" title="Sửa thông tin khách hàng" href="/admin/customer-edit-${tableList.id}">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </a>

                                        <security:authorize access="hasRole('MANAGER')">
                                            <Button class="btn btn-xs btn-success"
                                                    title="Giao cho nhân viên quản lý" onclick="assignmentCustomer(${tableList.id})">
                                                <i
                                                        class="ace-icon glyphicon glyphicon-align-justify bigger-120"></i>
                                            </Button>
                                        </security:authorize>
                                    </fieldset>
                                </display:column>
                            </display:table>
                        </div>
                    </div>
                </div>
            </div><!-- /.col -->
        </div><!-- /.row -->
    </div><!-- /.page-content -->
</div><!-- /.main-content -->
<div class="modal fade" id="assignmentCustomerModal" role="dialog">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Danh sách nhân viên</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped table-bordered table-hover" id="staffList">
                    <thead>
                    <tr>
                        <th class="center">
                            <label class="pos-rel">Chọn
                            </label>
                        </th>
                        <th class="center">Nhân viên</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <input type="hidden" id="customerId" name="customerId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAssignmentCustomer">Giao khách hàng</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<script>
    $('#btnSearch').click(function(e){
        e.preventDefault();
        $('#listForm').submit();
    });

    function assignmentCustomer(id) {
        $('#assignmentCustomerModal').modal();
        $('#customerId').val(id);
        loadStaffs(id);
    }

    function loadStaffs(customerId){
        $.ajax({
            type: "GET",
            url: "/api/customers/" + customerId +'/staffs',
            dataType : "json",
            success:(response) =>{
                var row = '';
                $.each(response.data, function (index, item){
                    row += ' <tr> ';
                    row += ' <td class="center"> ';
                    row += ' <label class="pos-rel"> ';
                    row += ' <input type="checkbox" class="ace" value="' + item.staffId + '" id="form_' + item.staffId + '" ' + item.checked + '  > ';
                    row += ' <span class="lbl"></span> ';
                    row += ' </label> ';
                    row += ' <td class="center"> ' + item.fullName + ' </td> ';
                    row += ' </td> ';
                    row += ' </tr> ';
                });
                $('#staffList tbody').html(row);
                // console.log("success");
                // window.location.replace("/admin/building-list");
            },
            error : function (response){
                alert("failed!");
            }
        });
    }

    $('#btnAssignmentCustomer').click(function (e){
        e.preventDefault()

        var data = {}
        data['id'] = $('#customerId').val()
        var staffs =  $('#staffList').find('tbody input[type=checkbox]:checked').map(function(){
            return $(this).val();
        }).get();
        data['staffs'] = staffs

        $.ajax({
            type: "PUT",
            url: "/api/customers",
            data: JSON.stringify(data),
            contentType : "application/json",
            success :(response) =>{
                alert("success");
            },
            error : function (response){
                alert("failed")
            }
        });
    })

    $('#btnDeleteCustomers').click(function(e){
        e.preventDefault();
        var data = {};
        var customerIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function(){
            return $(this).val();
        }).get();
        data['ids'] = customerIds;
        deleteCustomers(data['ids']);
    })

    function btnDeleteCustomer (customerId){
        var data = {}
        data['ids'] = [customerId]
        deleteCustomers(data['ids'])
    }

    function deleteCustomers (customerIds) {
        $.ajax({
            type: "DELETE",
            url: "/api/customers",
            data: JSON.stringify(customerIds),
            contentType : "application/json",
            dataType : "text",
            success :(response) =>{
                alert("success");
                window.location.replace("/admin/customer-list");
            },
            error : function (response){
                alert("failed")
            }
        });


    }
</script>
</body>
</html>