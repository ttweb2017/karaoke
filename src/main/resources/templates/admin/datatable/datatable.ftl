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
                    "pageLength": 5,
                    initComplete: function () {
                        this.api().columns().every( function () {
                            var column = this;
                            var select = $('<select class="form-control"><option value=""></option></select>')
                                    .appendTo( $(column.footer()).empty() )
                                    .on( 'change', function () {
                                        var val = $.fn.dataTable.util.escapeRegex(
                                                $(this).val()
                                        );
                                        column.search( val ? '^'+val+'$' : '', true, false ).draw();
                                    } );
                            column.data().unique().sort().each( function ( d, j ) {
                                select.append( '<option value="'+d+'">'+d+'</option>' )
                            } );
                        } );
                    }
                });
            });
        </script>
    </div>
</#macro>