//= require jquery
$(function () {
    $('.faq-item h2').click(function (e) {
        e.preventDefault();

        let $this = $(this);
        if ($this.next().hasClass('show')) {
            $this.next().removeClass('show');
            $this.removeClass('expand');
            $this.next().slideUp(350);
        } else {
            $this.parent().parent().find('.faq-text').removeClass('show');
            $this.parent().parent().find('h2').removeClass('expand');
            $this.parent().parent().find('.faq-text').slideUp(350);
            $this.next().toggleClass('show');
            $this.toggleClass('expand');
            $this.next().slideToggle(350);
        }
    });

    updatePlayer();
    $(window).resize(function () {
        updatePlayer();
    });
});

function updatePlayer() {
    player = $("#boxgiver-video");
    pwidth = player.width();
    $('.boxgiver-videos').removeClass('preload');
    player.height(pwidth * 0.57);
}
