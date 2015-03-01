function showhide()
 {

    // basic show and hide
    $(document).ready(function() {
        //these are for toggling the show/hide with the links in the content section
        $('#toggle_overview').click(function() {
            $('div.overview').toggle('fast');
        });
        $('#toggle_bioghist').click(function() {
            $('div.top_bioghist').toggle('fast');
        });
        $('#toggle_scopecontent').click(function() {
            $('div.top_scopecontent').toggle('fast');
        });
        $('#toggle_odd').click(function() {
            $('div.top_odd').toggle('fast');
        });
        $('#toggle_use').click(function() {
            $('div.use').toggle('fast');
        });
        $('#toggle_controlaccess').click(function() {
            $('div.controlaccess').toggle('fast');
        });
        $('#ai').click(function() {
            $('div.ai').toggle('fast');
        });
        $('#toggle_dsc').click(function() {
            $('div.dsc').toggle('fast');
        });

        //these are for showing the divs when clicking on the links in the table of contents
        $('#showoverview').click(function() {
            $('div.overview').show();
        });
        $('.showbioghist').click(function() {
            $('div.top_bioghist').show();
        });
        $('.showscopecontent').click(function() {
            $('div.top_scopecontent').show();
        });
        $('.showuseinfo').click(function() {
            $('div.useinfo').show();
        });
        $('.showcontrolaccess').click(function() {
            $('div.controlaccess').show();
        });
        $('.showai').click(function() {
            $('div.ai').show();
        });
        $('.showdsc').click(function() {
            $('div.dsc').show();
        });

        //toggle contents menu items
        $('#toggle_admin_menu').click(function() {
            $('td.admin_item').toggle();
        });
        $('#toggle_admin_menu').click(function() {
            $('td.admin_buffer').toggle();
        });
        $('#toggle_useinfo').click(function() {
            $('td.useinfo_item').toggle();
        });
        $('#toggle_useinfo').click(function() {
            $('td.useinfo_buffer').toggle();
        });
        $('#toggle_toc_dsc').click(function() {
            $('td.toc_dsc_item').toggle();
        });
        $('#toggle_toc_dsc').click(function() {
            $('td.toc_dsc_buffer').toggle();
        });


        //everything expanded when clicking on a search result link in sidebar
        $('.showall').click(function() {
            $('div.overview').show();
            $('div.top_bioghist').show();
            $('div.top_scopecontent').show();
            $('div.useinfo').show();
            $('div.controlaccess').show();
            $('div.ai').show();
            $('div.dsc').show();
        });
    });

}