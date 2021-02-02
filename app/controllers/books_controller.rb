class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:create] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # コントローラを通さないのでここに@booksを定義する
      @books = Book.all
      render :index
# バリデーション対応がしたい。空白の場合動かない。renderがわからない。

    end
  end

  def edit
    @book = Book.find(params[:id])

  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:update] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:destroy] = "Book was successfully destroyed."
    redirect_to books_path

  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
    # ストロングパラメータがわからない
  end

end
