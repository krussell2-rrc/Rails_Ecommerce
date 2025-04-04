class PagesController < ApplicationController
  def about
    @page = Page.find_by(name: "About")
  end

  def contact
    @page = Page.find_by(name: "Contact")
  end
end
