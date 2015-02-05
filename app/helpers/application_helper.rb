module ApplicationHelper
    # ページごとの完全なタイトルを返します。
    def full_title(page_title)
        base_title = "R on R App"
        if page_title.empty?
            base_title
        else
            "Rails | #{page_title}"
        end
    end
end
