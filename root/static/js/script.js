jQuery(function($) {
    $(document).ready(function() {
        if ($('div.video_file').length != 0) {
            $('div.video_file').each(function() {
                var video = new SWFObject('/static/swf/player.swf', 'player', '817', '446', '9');
                video.addParam('allowfullscreen','true');
                video.addParam('allowscriptaccess','always');
                var file = $(this).attr('title');
                video.addVariable('autostart','true');
                video.addVariable('repeat','always');
                video.addVariable('controlbar','over');
                video.addVariable('file',file);
                video.write($(this).attr('id'));
            });
        }
    });
});
