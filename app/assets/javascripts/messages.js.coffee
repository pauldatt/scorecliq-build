jQuery ->
    if $('.message-pagination').size() > 0
        $('.pagination').hide()
        loading_posts = false
        
        $('#load-messages').show().click ->
            unless loading_posts
              loading_posts = true
              more_posts_url = $('.pagination .next_page a').attr('href')
              $this = $(this)
              $this.text('Loading....').addClass('disabled')
              $.getScript more_posts_url, ->
                $this.text('Load More Messages').removeClass('disabled') if $this
                loading_posts = false
            return
    
    