class PagesController < ApplicationController
  def index
    @promos = [{ title: 'Esotericism and Numerology', image: '1.png' },
               { title: 'Books in Ukrainian', image: '2.png' },
               { title: 'Psychology and Relationships', image: '3.png' },
               { title: 'Business Books', image: '4.png' },
               { title: 'Fiction', image: '5.jpg' },
               { title: 'Books for Parents', image: '6.jpg' },
               { title: '123', image: '1.png' }]
  end
end
