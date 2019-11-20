<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; currentUser>
    <div class="card">
        <form action="/admin/edit-singer" method="post" enctype="multipart/form-data">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Edit Singer (${singer.fullName})</h4>
                </div>
            </div>
            <div class="card-body">
                <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" id="singerId" name="singerId" value="${singer.id}"/>
                <div class="row">
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>First Name</label>
                            <input id="firstName" type="text" class="form-control"
                                   placeholder="first name" name="firstName" value="${singer.firstName}"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label>Last Name</label>
                            <input id="lastName" type="text" class="form-control"
                                   placeholder="last name" name="lastName" value="${singer.lastName}"/>
                        </div>
                    </div>
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Status</label>
                            <select name="active" class="form-control" id="active">
                                <#if singer.active>
                                    <option value="1" selected>Active</option>
                                    <option value="0">Not Active</option>
                                <#else>
                                    <option value="0" selected>Not Active</option>
                                    <option value="1">Active</option>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label for="avatar">Avatar</label>
                            <input type="file" name="file" class="form-control-file" id="avatar" />
                        </div>
                    </div>
                    <#if singer.avatar??>
                        <div class="col-md-2">
                            <img src="/img/singer/${singer.avatar}" class="img-thumbnail" />
                        </div>
                    </#if>
                </div>
            </div>
            <div class="card-action">
                <button type="submit" id="editButton" class="btn btn-primary">Edit</button>
                <a href="/admin/singers" class="btn btn-default">Cancel</a>
            </div>
        </form>
        <script type="application/javascript">
            $(document).ready(function() {
                $('#firstName').on('change', function () {
                    var name = $("#firstName");

                    if (firstName.val() !== "") {
                        firstName.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        firstName.attr('placeholder', 'first name');
                        firstName.removeClass('error');
                    }else{
                        firstName.parent().css('border', '1px solid rgb(243, 84, 93)');
                        firstName.attr('placeholder', 'Please fill this field out');
                        firstName.addClass('error');

                        return;
                    }
                });

                $('#lastName').on('change', function () {
                    var lastName = $("#lastName");

                    if (lastName.val() !== "") {
                        lastName.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        lastName.attr('placeholder', 'last name');
                        lastName.removeClass('error');
                    }else{
                        lastName.parent().css('border', '1px solid rgb(243, 84, 93)');
                        lastName.attr('placeholder', 'Please fill this field out');
                        lastName.addClass('error');

                        return;
                    }
                });
            });
        </script>
    </div>
</@layout.karaoke>