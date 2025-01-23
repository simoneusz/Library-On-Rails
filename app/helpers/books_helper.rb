module BooksHelper
  def book_action_helper(book, current_user)
    if book.available
      button_to 'Take book', borrow_book_path(book), method: :post, class: 'btn btn-primary'
    elsif book.histories.where(user: current_user, returned_at: nil).exists?
      button_to 'Return book', return_book_path(book), method: :post, class: 'btn btn-success'
    else
      content_tag(:div, 'Sorry, book is occupied', { class: 'text-danger' })
    end
  end

  def book_bookmark_helper(book, current_user)
    if current_user.bookmarks.exists?(book: book)
      button_to "<i class='bi bi-bookmark-fill'></i>".html_safe, book_bookmark_path(book), method: :delete
    else
      button_to "<i class='bi bi-bookmark'></i>".html_safe, book_bookmark_path(book), method: :post
    end
  end
end
