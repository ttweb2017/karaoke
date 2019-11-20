<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; user>
    <@table.datatable "dataList">
        <div class="card">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Users List</h4>
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
                                <form>
                                    <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                                    <div class="row">
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>First Name</label>
                                                <input id="firstName" type="text" class="form-control"
                                                       placeholder="first name">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Last Name</label>
                                                <input id="lastName" type="text" class="form-control"
                                                       placeholder="last name">
                                            </div>
                                        </div>
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>Username</label>
                                                <input id="username" type="text" class="form-control"
                                                       placeholder="username">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Email</label>
                                                <input id="email" type="email" class="form-control"
                                                       placeholder="email">
                                            </div>
                                        </div>
                                        <div class="col-md-6 pr-0">
                                            <div class="form-group form-group-default">
                                                <label>Password</label>
                                                <input id="password" type="password" class="form-control"
                                                       placeholder="password">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group form-group-default">
                                                <label>Confirm Password</label>
                                                <input id="confirmPassword" type="password" class="form-control"
                                                       placeholder="confirm password">
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
                            <th>Username</th>
                            <th>Email</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th style="width: 10%">Action</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>#</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Action</th>
                        </tr>
                        </tfoot>
                        <tbody>
                            <#list users as usr>
                            <tr>
                                <td>${usr.id}</td>
                                <td>${usr.username}</td>
                                <td>${usr.email}</td>
                                <td>${usr.firstName}</td>
                                <td>${usr.lastName}</td>
                                <td>
                                    <div class="form-button-action">
                                        <a href="/admin/edit-user/${usr.id}"
                                           data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg"
                                           data-original-title="Edit User">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <a href="/admin/delete-user/${usr.id}" style="padding-top: 12px;" onclick="return confirm('Are you sure?')"
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
                $('#username').on('change', function() {
                    var username = $("#username");

                    if(username.val() !== ""){
                        username.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        username.attr('placeholder', 'username');
                        username.removeClass('error');
                    }

                    var request = $.ajax({
                        url: "/admin/check-username/" + username.val(),
                        method: "GET",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    });

                    request.done(function( json ) {
                        if(json.username === null || json.username === ""){
                            username.parent().css('border', '1px solid rgb(53, 205, 58)');
                        }else{
                            username.parent().css('border', '1px solid rgb(243, 84, 93)');
                        }
                    });

                    request.fail(function( jqXHR, textStatus ) {
                        alert( "Request failed: " + textStatus );
                    });
                });

                $('#email').on('change', function() {
                    var email = $("#email");

                    if(email.val() !== ""){
                        email.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        email.attr('placeholder', 'email');
                        email.removeClass('error');
                    }
                });

                $('#password').on('change', function() {
                    var password = $("#password");

                    if(password.val() !== ""){
                        password.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        password.attr('placeholder', 'password');
                        password.removeClass('error');
                    }
                });

                $('#confirmPassword').on('change', function() {
                    var confirmPassword = $("#confirmPassword");

                    if(confirmPassword.val() !== ""){
                        confirmPassword.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        confirmPassword.attr('placeholder', 'confirm password');
                        confirmPassword.removeClass('error');
                    }
                });

                $('#addRowButton').click(function() {
                    //add user to database using ajax
                    var token = $("meta[name='_csrf']").attr("content");
                    var username = $("#username");
                    var email = $("#email");
                    var firstName = $("#firstName");
                    var lastName = $("#lastName");
                    var password = $("#password");
                    var confirmPassword = $("#confirmPassword");

                    if(username.val() === 'undefined' || username.val() === ""){
                        username.parent().css('border', '1px solid rgb(243, 84, 93)');
                        username.attr('placeholder', 'Please fill this field out');
                        username.addClass('error');

                        return;
                    }

                    if(email.val() === 'undefined' || email.val() === ""){
                        email.parent().css('border', '1px solid rgb(243, 84, 93)');
                        email.attr('placeholder', 'Please fill this field out');
                        email.addClass('error');

                        return;
                    }

                    if(password.val() === 'undefined' || password.val() === ""){
                        password.parent().css('border', '1px solid rgb(243, 84, 93)');
                        password.attr('placeholder', 'Please fill this field out');
                        password.addClass('error');

                        return;
                    }

                    if(confirmPassword.val() === 'undefined' || confirmPassword.val() === ""){
                        confirmPassword.parent().css('border', '1px solid rgb(243, 84, 93)');
                        confirmPassword.attr('placeholder', 'Please fill this field out');
                        confirmPassword.addClass('error');

                        return;
                    }

                    if(password.val() !== confirmPassword.val()){
                        confirmPassword.parent().css('border', '1px solid rgb(243, 84, 93)');
                        confirmPassword.attr('placeholder', 'Password not matched!');
                        confirmPassword.addClass('error');

                        password.val("");
                        confirmPassword.val("");

                        return;
                    }

                    var request = $.ajax({
                        url: "/admin/add-user",
                        headers: {"X-CSRF-TOKEN": token},
                        method: "POST",
                        data: JSON.stringify({
                            username : username.val(),
                            email: email.val(),
                            firstName: firstName.val(),
                            lastName: lastName.val(),
                            password: password.val(),
                            confirmPassword: confirmPassword.val()
                        }),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json"
                    });

                    request.done(function( json ) {
                        var action = '<td> <div class="form-button-action"> ';
                        action += '<a href="/admin/edit-user/' + json.id + '" data-toggle="tooltip" title="" class="btn btn-link btn-primary btn-lg" data-original-title="Edit User"> <i class="fa fa-edit"></i> </a> ';
                        action += '<a href="/admin/delete-user/' + json.id + '" style="padding-top: 12px;" onclick="return confirm(\'Are you sure?\')" data-toggle="tooltip" title="" class="btn btn-link btn-danger" data-original-title="Remove"> <i class="fa fa-times"></i> </a> </div> </td>';
                        action += '</div> </td>';

                        $('#dataList').dataTable().fnAddData([
                            json.id,
                            json.username,
                            json.email,
                            json.firstName,
                            json.lastName,
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