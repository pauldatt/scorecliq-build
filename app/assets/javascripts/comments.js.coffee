jQuery ->
    if $('#comment-page .pagination').length
        $(window).scroll ->
            url = $('#comment-page .pagination .next_page a').attr('href')
            if url && $(window).scrollTop() > $(document).height() - $(window).height() - 40
                $('#comment-page .pagination').html('<div class="row comment-load">Loading More Comments...</div>')
                $.getScript(url)
        $(window).scroll()