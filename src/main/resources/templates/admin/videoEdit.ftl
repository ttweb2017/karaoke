<#import "layout/karaoke.ftl" as layout>
<#import "datatable/datatable.ftl" as table>

<@layout.karaoke; currentUser>
    <div class="card">
        <form action="/admin/edit-video" method="post" enctype="multipart/form-data">
            <div class="card-header">
                <div class="d-flex align-items-center">
                    <h4 class="card-title">Edit Video (${video.name})</h4>
                </div>
            </div>
            <div class="card-body">
                <input type="hidden" id="_csrf" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" id="videoId" name="videoId" value="${video.id}"/>
                <div class="row">
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Name</label>
                            <input id="name" type="text" class="form-control"
                                   placeholder="video name" name="name" value="${video.name}"/>
                        </div>
                    </div>
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Singer</label>
                            <select name="singer" class="form-control" id="singer">
                                <#list singers as singer>
                                    <#if video.singer.id == singer.id>
                                    <option value="${singer.id}" selected>${singer.fullName}</option>
                                    <#else>
                                    <option value="${singer.id}">${singer.fullName}</option>
                                    </#if>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6 pr-0">
                        <div class="form-group form-group-default">
                            <label>Status</label>
                            <select name="active" class="form-control" id="active">
                                <#if video.active>
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
                            <label for="video">Video</label>
                            <input type="file" name="files" class="form-control-file" id="video" />
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group form-group-default">
                            <label for="video">Image</label>
                            <input type="file" name="files" class="form-control-file" id="image" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-action">
                <button type="submit" id="editButton" class="btn btn-primary">Edit</button>
                <a href="/admin/videos" class="btn btn-default">Cancel</a>
            </div>
        </form>
        <script type="application/javascript">
            $(document).ready(function() {
                $('#name').on('change', function () {
                    var name = $("#name");

                    if (name.val() !== "") {
                        name.parent().css('border', '1px solid rgba(0, 0, 0,.07)');
                        name.attr('placeholder', 'username');
                        name.removeClass('error');
                    }else{
                        name.parent().css('border', '1px solid rgb(243, 84, 93)');
                        name.attr('placeholder', 'Please fill this field out');
                        name.addClass('error');

                        return;
                    }
                });
            });
        </script>
    </div>
</@layout.karaoke>