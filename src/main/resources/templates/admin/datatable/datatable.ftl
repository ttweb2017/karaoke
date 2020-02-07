<#macro datatable id>
    <div class="row">
        <div class="col-md-12">
            <#nested>
        </div>
        <!-- Datatables -->
        <script src="/static/admin/karaoke/js/plugin/datatables/datatables.min.js"></script>
        <script type="application/javascript">
            $(document).ready(function() {
                // Add Row
                $('#${id}').DataTable({
                    "pageLength": 50
                });
            });
        </script>
    </div>
</#macro>