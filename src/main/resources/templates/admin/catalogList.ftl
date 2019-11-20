<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; user>
    <@table.datatable "dataList">
        <div class="card">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Catalog List</h4>
                    <button class="btn btn-primary btn-round ml-auto" data-toggle="modal" data-target="#addRowModal">
                        <i class="fa fa-plus"></i>
                        Add Row
                    </button>
                </div>
            </div>
            <div class="card-body">
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
                                <form id="catalogForm">
                                    <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                                    <div class="row">
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>Catalog Name</label>
                                                <input id="name" type="text" class="form-control"
                                                       placeholder="name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Catalog Description</label>
                                                <input id="description" type="text" class="form-control"
                                                       placeholder="description" />
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
                                                <label for="img">Catalog  Image</label>
                                                <input type="file" name="file" class="form-control-file" id="img" />
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
                            <th>Image</th>
                            <th>Status</th>
                            <th style="width: 10%">Action</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                        </tfoot>
                        <tbody>
                            <#list catalogs as catalog>
                            <tr>
                                <td>${catalog.id}</td>
                                <td>${catalog.name}</td>
                                <td>${catalog.img}</td>
                                <td>
                                    <#if catalog.active>
                                        <p class="badge-success">Active</p>
                                    <#else>
                                        <p class="badge-danger">Not Active</p>
                                    </#if>
                                </td>
                                <td>
                                    <div class="form-button-action">
                                        <a href="/admin/edit-catalog/${catalog.id}"
                                           data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg"
                                           data-original-title="Edit Catalog">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="/admin/delete-catalog/${catalog.id}" style="padding-top: 12px;" onclick="return confirm('Are you sure?')"
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
                $('#name').on('change', function() {
                    var name = $("#name");

                    if(name.val() !== ""){
                        name.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        name.attr('placeholder', 'name');
                        name.removeClass('error');
                    }
                });

                $('#addRowButton').click(function() {
                    //add catalog to database using ajax
                    var token = $("meta[name='_csrf']").attr("content");
                    var name = $("#name");
                    var description = $("#description");
                    var active = $("#active");

                    // Get form
                    var form = $('#catalogForm')[0];
                    var data = new FormData(form);

                    data.append("name", name.val());
                    data.append("description", description.val());
                    data.append("active", active.val());

                    if(name.val() === 'undefined' || name.val() === ""){
                        name.parent().css('border', '1px solid rgb(243, 84, 93)');
                        name.attr('placeholder', 'Please fill this field out');
                        name.addClass('error');

                        return;
                    }

                    console.log(data);
                    var request = $.ajax({
                        enctype: 'multipart/form-data',
                        url: "/admin/add-catalog",
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
                        action += '<a href="/admin/edit-catalog/' + json.id + '" data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit User"> <i class="fa fa-edit"></i> </a> ';
                        action += '<a href="/admin/delete-catalog/' + json.id + '" style="padding-top: 12px;" onclick="return confirm(\'Are you sure?\')" data-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </a> </div> </td>';
                        action += '</div> </td>';

                        var status = "";
                        if(json.active){
                            status = '<p class="badge-success">Active</p>';
                        }else{
                            status = '<p class="badge-danger">Not Active</p>';
                        }

                        $('#dataList').dataTable().fnAddData([
                            json.id,
                            json.name,
                            json.img,
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