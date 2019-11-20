<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; currentUser>
    <div class="card">
        <form action="/admin/edit-user" method="post">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Edit User (${currentUser.username})</h4>
                </div>
            </div>
            <div class="card-body">
                <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" id="userId" name="userId" value="${user.id}"/>
                <div class="row">
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>First Name</label>
                            <input id="firstName" type="text" class="form-control"
                                   placeholder="first name" name="firstName" value="${user.firstName}"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label>Last Name</label>
                            <input id="lastName" type="text" class="form-control"
                                   placeholder="last name" name="lastName" value="${user.lastName}"/>
                        </div>
                    </div>
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Username</label>
                            <input id="username" type="text" class="form-control"
                                   placeholder="username" name="username" value="${user.username}"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label>Email</label>
                            <input id="email" type="email" class="form-control"
                                   placeholder="email" name="email" value="${user.email}"/>
                        </div>
                    </div>
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Password</label>
                            <input id="password" type="password" name="password" class="form-control"
                                   placeholder="password"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label>Confirm Password</label>
                            <input id="confirmPassword" type="password" name="confirmPassword" class="form-control"
                                   placeholder="confirm password">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group form-group-default">
                            <label>Status</label>
                            <select name="status" class="form-control" id="formGroupDefaultSelect">
                                <#if user.active>
                                    <option value="1" selected>Active</option>
                                    <option value="0">Not Active</option>
                                <#else >
                                    <option value="0" selected>Not Active</option>
                                    <option value="1">Active</option>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label><b>USER ROLES</b></label>
                        <#list roles as role>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input class="form-check-input" type="checkbox"
                                           name="${role}" ${user.roles?seq_contains(role)?string("checked", "")} />
                                    <span class="form-check-sign">${role}</span>
                                </label>
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
            <div class="card-action">
                <button type="submit" id="editButton" class="btn btn-primary">Edit</button>
                <a href="/admin/users" class="btn btn-default">Cancel</a>
            </div>
        </form>
        <script type="application/javascript">
            $(document).ready(function() {
                $('#username').on('change', function () {
                    var username = $("#username");
                    var currentUser = '${user.username}';
                    var userId = $("#userId");

                    if (username.val() !== "") {
                        username.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        username.attr('placeholder', 'username');
                        username.removeClass('error');
                    }else{
                        username.parent().css('border', '1px solid rgb(243, 84, 93)');
                        username.attr('placeholder', 'Please fill this field out');
                        username.addClass('error');

                        return;
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
                        }else if(currentUser === json.username){
                            username.parent().css('border', '1px solid rgba(0,0,0,.07)');
                        }else{
                            username.parent().css('border', '1px solid rgb(243, 84, 93)');
                        }
                    });

                    request.fail(function( jqXHR, textStatus ) {
                        alert( "Request failed: " + textStatus );
                    });
                });
            });
        </script>
    </div>
</@layout.karaoke>