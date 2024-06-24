<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="formUrl" value="/admin/building-list"/>
<html>
<head>
    <title>Danh sách toà nhà</title>
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
                    <a href="#">List buildings</a>
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
                <h1>Building
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
                                <form:form action="/admin/building-list" method="GET" id="listForm" modelAttribute="searchModel">
                                    <div>
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-6">
                                                        <label>Tên toà nhà</label>
                                                        <form:input path="name" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-6">
                                                        <label>Diện tích sàn</label>
                                                        <form:input path="floorArea" class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-2">
                                                        <label>Quận</label>
                                                        <form:select class="form-control" path="district">
                                                            <form:option value="">--Quận--</form:option>
                                                            <form:options items="${districts}"/>
                                                        </form:select>
                                                    </div>
                                                    <div class="col-xs-5">
                                                        <label>Phường</label>
                                                        <form:input path="ward" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-5">
                                                        <label>Đường</label>
                                                        <form:input path="street" class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-4">
                                                        <label>Số tầng hầm</label>
                                                        <form:input path="numberOfBasement" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label>Hướng</label>
                                                        <form:input path="direction" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label>Hạng</label>
                                                        <form:input path="level" class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-3">
                                                        <label>Diện tích từ</label>
                                                        <form:input path="areaFrom" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <label>Diện tích đến</label>
                                                        <form:input path="areaTo" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <label>Giá thuê từ</label>
                                                        <form:input path="rentPriceFrom" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-3">
                                                        <label>Giá thuê đến</label>
                                                        <form:input path="rentPriceTo" class="form-control"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-4">
                                                        <label>Tên quản lý</label>
                                                        <form:input path="managerName" class="form-control"/>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <label>SĐT quản lý</label>
                                                        <form:input path="managerPhone" class="form-control"/>
                                                    </div>
                                                    <security:authorize access="hasRole('MANAGER')">
                                                        <div class="col-xs-4">
                                                            <label>Nhân viên phụ trách</label>
                                                            <form:select path="staffId" class="form-control">
                                                                <form:option value="">--Chọn nhân viên--</form:option>
                                                                <form:options items="${staffs}"/>
                                                            </form:select>
                                                        </div>
                                                    </security:authorize>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-xs-12">
                                                    <div class="col-xs-6">
                                                        <form:checkboxes path="type" items="${typeCodes}"/>
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
                            <button title="Xoá" class="btn btn-danger" id="btnDeleteBuilding">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                     fill="currentColor" class="bi bi-building-dash" viewBox="0 0 16 16">
                                    <path
                                            d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1" />
                                    <path
                                            d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                                    <path
                                            d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
                                </svg>
                            </button>
                            <a href="/admin/building-edit">
                                <button title="Thêm toà nhà" class="btn btn-primary">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                         class="bi bi-building-add" viewBox="0 0 16 16">
                                        <path
                                                d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0" />
                                        <path
                                                d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z" />
                                        <path
                                                d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z" />
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
                            <display:table name="listReponseBuilding.listResult" cellspacing="0" cellpadding="0"
                                           requestURI="${formUrl}" partialList="true" sort="external"
                                           size="${listReponseBuilding.totalItems}" defaultsort="2" defaultorder="ascending"
                                           id="tableList" pagesize="${listReponseBuilding.maxPageItems}"
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
                                <display:column headerClass="text-left" property="name" title="Tên toà nhà"/>
                                <display:column headerClass="text-left" property="address" title="Địa chỉ"/>
                                <display:column headerClass="text-left" property="numberOfBasement" title="Số tầng hầm"/>
                                <display:column headerClass="text-left" property="managerName" title="Tên quản lý"/>
                                <display:column headerClass="text-left" property="managerPhone" title="SĐT"/>
                                <display:column headerClass="text-left" property="floorArea" title="Diện tích sàn"/>
                                <display:column headerClass="text-left" property="emptyArea" title="Diện tích trống"/>
                                <display:column headerClass="text-left" property="rentArea" title="Diện tích thuê"/>
                                <display:column headerClass="text-left" property="rentPrice" title="Giá thuê"/>
                                <display:column headerClass="text-left" property="serviceFee" title="Phí dịch vụ"/>
                                <display:column headerClass="text-left" property="brokerageFee" title="Phí MG"/>
                                <display:column title="Thao tác" class="center select-cell"
                                                headerClass="center select-cell">
                                    <fieldset>
                                        <security:authorize access="hasRole('MANAGER')">
                                            <Button class="btn btn-xs btn-danger" title="Xoá toà nhà" onclick="btnDeleteBuilding(${tableList.id})">
                                                <i class="ace-icon fa fa-trash-o bigger-120"></i>
                                            </Button>
                                        </security:authorize>

                                        <a class="btn btn-xs btn-info" title="Sửa toà nhà" href="/admin/building-edit-${tableList.id}">
                                            <i class="ace-icon fa fa-pencil bigger-120"></i>
                                        </a>

                                        <security:authorize access="hasRole('MANAGER')">
                                            <Button class="btn btn-xs btn-success"
                                                    title="Giao cho nhân viên quản lý" onclick="assignmentBuilding(${tableList.id})">
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
<div class="modal fade" id="assignmentBuildingModal" role="dialog">
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
                <input type="hidden" id="buildingId" name="buildingId" value="">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="btnAssignmentBuilding">Giao toà nhà</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
            </div>
        </div>

    </div>
</div>
<script>
    function assignmentBuilding(buildingId) {
        $('#assignmentBuildingModal').modal();
        $('#buildingId').val(buildingId);
        loadStaffs(buildingId);
    }

    function loadStaffs(buildingId){
        $.ajax({
            type: "GET",
            url: "/api/buildings/" + buildingId +'/staffs',
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

    $('#btnAssignmentBuilding').click(function(e){
        e.preventDefault();
        var data = {};
        data['id'] = $('#buildingId').val();
        var staffs = $('#staffList').find('tbody input[type=checkbox]:checked').map(function(){
            return $(this).val();
        }).get();
        data['staffs'] = staffs;

        $.ajax({
            type: "PUT",
            url: "/api/buildings",
            data: JSON.stringify(data),
            contentType : "application/json",
            success :(response) =>{
                alert("success");
            },
            error : function (response){
                alert("failed")
            }
        });
    });

    $('#btnDeleteBuilding').click(function(e){
        e.preventDefault();
        var data = {};
        var buildingIds = $('#tableList').find('tbody input[type=checkbox]:checked').map(function(){
            return $(this).val();
        }).get();
        data['ids'] = buildingIds;
        deleteBuildings(data);
    });

    function btnDeleteBuilding(buildingID){
        var data = {};
        var id = [buildingID];
        data['ids'] = id;
        deleteBuildings(data);
    }

    function deleteBuildings(data){
        $.ajax({
            type: "DELETE",
            url: "/api/buildings",
            data: JSON.stringify(data['ids']),
            contentType : "application/json",
            dataType : "text",
            success:(response) =>{
                alert("Delete successful!");
                window.location.replace("/admin/building-list");
            },
            error : function (response){
                alert("Delete failed!");
            }
        });
    }

    $('#btnSearch').click(function(e){
        e.preventDefault();
        $('#listForm').submit();
    });
</script>
</body>
</html>