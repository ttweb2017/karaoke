<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; user>
    <@table.datatable "dataList">
        <div class="card">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Video List</h4>
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
                                <form id="videoForm">
                                    <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                                    <div class="row">
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>Video Name</label>
                                                <input id="name" type="text" class="form-control"
                                                       placeholder="name" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Singer</label>
                                                <select name="singer" class="form-control" id="singer">
                                                    <#list singers as singer>
                                                        <option value="${singer.id}">${singer.fullName}</option>
                                                    </#list>
                                                </select>
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
                                                <label for="video">Video</label>
                                                <input type="file" name="files" class="form-control-file" id="video" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label for="image">Image</label>
                                                <input type="file" name="files" class="form-control-file" id="image" />
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
                            <th>Viewed</th>
                            <th>Status</th>
                            <th>Added Date</th>
                            <th style="width: 10%">Action</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Image</th>
                            <th>Viewed</th>
                            <th>Status</th>
                            <th>Added Date</th>
                            <th>Action</th>
                        </tr>
                        </tfoot>
                        <tbody>
                        <#assign size = videos?size />
                            <#list videos as video>
                            <tr>
                                <td>${video?counter}</td>
                                <td>${video.name}</td>
                                <td>
                                    <#if video.image??>
                                        <img class="img-fluid" width="32" height="32" src="/img/videos/${video.image}"
                                             alt="${video.name}" />
                                    <#else>
                                        image
                                    </#if>
                                </td>
                                <td>
                                    ${video.watchedCounter}
                                </td>
                                <td>
                                    <#if video.active>
                                        <i class="badge-success" style="display: block;width: 24px;height: 24px;margin: 0 auto;"></i>
                                    <#else>
                                        <i class="badge-danger" style="display: block;width: 24px;height: 24px;margin: 0 auto;"></i>
                                    </#if>
                                </td>
                                <td>
                                    ${video.formattedDate}
                                </td>
                                <td>
                                    <div class="form-button-action">
                                        <a href="/admin/edit-video/${video.id}"
                                           data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg"
                                           data-original-title="Edit Video">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="/admin/delete-video/${video.id}" style="padding-top: 12px;"
                                           onclick="return confirm('Are you sure?')"
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
                    var active = $("#active");
                    var singer = $("#singer");

                    // Get form
                    var form = $('#videoForm')[0];
                    var data = new FormData(form);

                    data.append("name", name.val());
                    data.append("active", active.val());
                    data.append("singer", singer.val());

                    if(name.val() === 'undefined' || name.val() === ""){
                        name.parent().css('border', '1px solid rgb(243, 84, 93)');
                        name.attr('placeholder', 'Please fill this field out');
                        name.addClass('error');

                        return;
                    }

                    console.log(data);
                    var request = $.ajax({
                        enctype: 'multipart/form-data',
                        url: "/admin/add-video",
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
                        action += '<a href="/admin/edit-video/' + json.id + '" data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit User"> <i class="fa fa-edit"></i> </a> ';
                        action += '<a href="/admin/delete-video/' + json.id + '" style="padding-top: 12px;" onclick="return confirm(\'Are you sure?\')" data-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </a> </div> </td>';
                        action += '</div> </td>';

                        var status = "";
                        if(json.active){
                            status = '<i class="badge-success" style="display: block;width: 24px;height: 24px;margin: 0 auto;"></i>';
                        }else{
                            status = '<i class="badge-danger" style="display: block;width: 24px;height: 24px;margin: 0 auto;"></i>';
                        }

                        $('#dataList').dataTable().fnAddData([
                            ${size + 1},
                            json.name,
                            json.image,
                            json.watchedCounter,
                            status,
                            json.formattedDate,
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