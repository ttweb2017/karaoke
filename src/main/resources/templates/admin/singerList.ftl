<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; user>
    <@table.datatable "dataList">
        <div class="card">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Singer List</h4>
                    <button class="btn btn-primary btn-round ml-auto" data-toggle="modal" data-target="#addRowModal">
                        <i class="fa fa-plus"></i>
                        Add Row
                    </button>
                </div>
            </div>
            <div class="card-body">
                <#if type??>
                    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
                        <strong><#if type == "danger">Error<#else> Success</#if>!</strong> <br>${message}
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </#if>
                <!-- Modal -->
                <div class="modal fade" id="addRowModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header no-bd">
                                <h5 class="modal-title">
                                    <span class="fw-mediumbold">New</span>
                                    <span class="fw-light">Row</span>
                                </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p class="small">Create a new row using this form, make sure you fill them all</p>
                                <form id="singerForm">
                                    <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                                    <div class="row">
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>First Name</label>
                                                <input id="firstName" type="text" class="form-control"
                                                       placeholder="First Name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Last Name</label>
                                                <input id="lastName" type="text" class="form-control"
                                                       placeholder="Last Name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Status</label>
                                                <select name="active" class="form-control" id="active">
                                                    <option value="0" selected>Not Active</option>
                                                    <option value="1">Active</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label for="avatar">Avatar</label>
                                                <input type="file" name="file" class="form-control-file" id="avatar" />
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer no-bd">
                                <button type="button" id="addRowButton" class="btn btn-primary">Add</button>
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table id="dataList" class="display table table-striped table-hover">
                        <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Avatar</th>
                            <th>Status</th>
                            <th style="width: 10%">Action</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Avatar</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </tfoot>
                        <tbody>
                            <#list singers as singer>
                            <tr>
                                <td>${singer.id}</td>
                                <td>${singer.fullName}</td>
                                <td>
                                    <img class="img-fluid" width="64" height="64" src="/img/singer/${singer.avatar}" alt="${singer.fullName}" />
                                </td>
                                <td>
                                    <#if singer.active>
                                        <p class="badge-success">Active</p>
                                    <#else>
                                        <p class="badge-danger">Not Active</p>
                                    </#if>
                                </td>
                                <td>
                                    <div class="form-button-action">
                                        <a href="/admin/edit-singer/${singer.id}"
                                           data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg"
                                           data-original-title="Edit Singer">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="/admin/delete-singer/${singer.id}" style="padding-top: 12px;" onclick="return confirm('Are you sure?')"
                                           data-toggle="tooltip" title="" class="btn btn-link btn-danger"
                                           data-original-title="Remove">
                                            <i class="fa fa-times"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                            </#list>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script type="application/javascript">
            $(document).ready(function() {
                $('#firstName').on('change', function() {
                    var firstName = $("#firstName");

                    if(firstName.val() !== ""){
                        firstName.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        firstName.attr('placeholder', 'name');
                        firstName.removeClass('error');
                    }
                });

                $('#lastName').on('change', function() {
                    var lastName = $("#lastName");

                    if(lastName.val() !== ""){
                        lastName.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        lastName.attr('placeholder', 'name');
                        lastName.removeClass('error');
                    }
                });

                $('#addRowButton').click(function() {
                    //add catalog to database using ajax
                    var token = $("meta[name='_csrf']").attr("content");
                    var firstName = $("#firstName");
                    var lastName = $("#lastName");
                    var active = $("#active");

                    // Get form
                    var form = $('#singerForm')[0];
                    var data = new FormData(form);

                    data.append("firstName", firstName.val());
                    data.append("lastName", lastName.val());
                    data.append("active", active.val());

                    if(firstName.val() === 'undefined' || firstName.val() === ""){
                        firstName.parent().css('border', '1px solid rgb(243, 84, 93)');
                        firstName.attr('placeholder', 'Please fill this field out');
                        firstName.addClass('error');

                        return;
                    }

                    if(lastName.val() === 'undefined' || lastName.val() === ""){
                        lastName.parent().css('border', '1px solid rgb(243, 84, 93)');
                        lastName.attr('placeholder', 'Please fill this field out');
                        lastName.addClass('error');

                        return;
                    }

                    var request = $.ajax({
                        enctype: 'multipart/form-data',
                        url: "/admin/add-singer",
                        headers: {"X-CSRF-TOKEN": token},
                        method: "POST",
                        data: data,
                        processData: false,
                        contentType: false,
                        cache: false,
                        timeout: 600000,
                    });

                    request.done(function( json ) {
                        var action = '<td> <div class="form-button-action"> ';
                        action += '<a href="/admin/edit-singer/' + json.id + '" data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit User"> <i class="fa fa-edit"></i> </a> ';
                        action += '<a href="/admin/delete-singer/' + json.id + '" style="padding-top: 12px;" onclick="return confirm(\'Are you sure?\')" data-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </a> </div> </td>';
                        action += '</div> </td>';

                        var status = "";
                        if(json.active){
                            status = '<p class="badge-success">Active</p>';
                        }else{
                            status = '<p class="badge-danger">Not Active</p>';
                        }

                        $('#dataList').dataTable().fnAddData([
                            json.id,
                            json.firstName + " " + json.lastName,
                            json.avatar,
                            status,
                            action
                        ]);
                    });

                    request.fail(function( jqXHR, textStatus ) {
                        alert( "Request failed: " + textStatus );
                    });

                    $('#addRowModal').modal('hide');
                });
            });
        </script>
    </@table.datatable>
</@layout.karaoke>